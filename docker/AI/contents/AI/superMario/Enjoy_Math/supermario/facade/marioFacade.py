"""
@file       marioFacade.py
@author     Suyong Choi
@brief      Facade Class that connects Super Mario's backend environment and builder class
@version    1.0
@date       2024.05.01
"""

import gym

from logger.logger import logger
from define import DEFINE

from gym_super_mario_bros.actions import SIMPLE_MOVEMENT

from ..controller.controller.superMarioControllerBuilder import superMarioControllerBuilder
from ..controller.coordinator.superMarioActionCoordinator import superMarioActionCoordinator
from ..controller.coordinator.superMarioDrawCoordinator import superMarioDrawCoordinator
from ..observer.Iobserver import Iobserver
from ..observer.observer import observer

from logger.logger import logger
from logger.actionDataLogger import actionDataLogger
from logger.frameDataLogger import frameDataLogger
from define import DEFINE

class marioFacade(Iobserver):

    def __init__(self, gymMario, title, mode):
        """ 
        @brief              :   Function to initialize the facade class that connects Super Mario's backend environment and builder class
        @param gymMario     :   openAI's super mario bros environment
        @param title        :   Super Mario's Windows title
        @return             :   None
        """
    
        self.viewController     = None
        self.controllerBuilder  = None
        self.actionCoordinator  = None
        self.drawCoordinator    = None
        self.observer           = None
        self.actionLogger       = None
        self.frameLogger        = None
        self.mode               = mode

        self.controllerBuilder  = superMarioControllerBuilder(gymMario, title, mode)
        self.actionCoordinator  = superMarioActionCoordinator(self.controllerBuilder, SIMPLE_MOVEMENT)
        self.drawCoordinator    = superMarioDrawCoordinator(self.controllerBuilder)

        self.viewController     = self.controllerBuilder.get_marioViewController()
        self.modelController    = self.controllerBuilder.get_marioModelController()
        self.actionLogger       = actionDataLogger()
        self.frameLogger        = frameDataLogger() 
        self.observer           = observer()
       
        self.set_observer()
        self.makeLog()

    def step(self):
        """
        @brief              :   Function that returns data based on the results of Mario's decision.
        @return state       :   Game data based on Mario's decision-making results 
        @return reward      :   Reward Value based on Mario's decision-making results 
        @return done        :   Whether to reset the game according to the results of Mario's decision
        """

        state, reward, done = self.actionCoordinator.makeStep()
        self.writeLog(state, reward)
        
        if reward == DEFINE._DEFINE_REWARD_MAX_MIN_VAL :
           self.closeLogStream()

        return (state, reward, done)

    def interactiveStep(self, action):
        """
        @brief              :   Function that returns data based on the results of Mario's decision.
        @return state       :   Game data based on Mario's decision-making results 
        @return reward      :   Reward Value based on Mario's decision-making results 
        @return done        :   Whether to reset the game according to the results of Mario's decision
        """

        state, reward, done = self.actionCoordinator.setStep(action)

        self.writeLog(state, reward)
        if reward == DEFINE._DEFINE_REWARD_MAX_MIN_VAL :
           self.closeLogStream()

        return (state, reward, done)


    def render(self, reward):
        """
        @brief              :   Function that renders the screen on a window based on data
        @param   reward     :   Reward value according to Mario's decision
        @return             :   None
        """
        if self.viewController is DEFINE._DEFINE_NULL:
           logger.instanceEmptyAssertLog('viewController') 

        window = self.viewController.render()

        if self.viewController.get_marioView() is not DEFINE._DEFINE_NULL:
            self.update('reward', reward)

        if self.mode == 'interactive':    
            return window

    def reset(self):
        """
        @brief              :   Function to reset the data of the game window and return it to its initial state
        @return             :   None
        """
        if self.viewController is DEFINE._DEFINE_NULL:
           logger.instanceEmptyAssertLog('viewController') 

        self.viewController.reset()


    def set_observer(self):
        """
        @brief              :   Register classes to be monitored in real time in Observer
        @return             :   None
        """
        self.observer.attach(self.drawCoordinator, 'reward')

        self.observer.attach(self.actionCoordinator,'action')

        self.observer.attach(self.actionLogger,'actionlog')
        self.observer.attach(self.frameLogger,'framelog')

    def update(self, obsCategory, value):
        """
        @brief              :   Function to update instances registered in the observer class to the latest status
        @param  obsCategory :   Category of registered instance 
        @param  value       :   The value you want to update to the latest from the observer class. 
        @return             :   None
        """

        if obsCategory == 'reward':
            self.observer.reward_notify(value)           
        elif obsCategory == 'action':
            self.observer.action_notify(value)
        elif obsCategory == 'actionlog':            
            stepNum = self.actionCoordinator.getStepNum()
            self.actionLogger.setStepNum(stepNum)
            self.observer.actionLogNotify( value )

        elif obsCategory == 'framelog':            
            stepNum = self.actionCoordinator.getStepNum()
            self.frameLogger.setStepNum(stepNum)
            self.observer.frameLogNotify( value )

    def writeLog(self, frame, reward):
        self.update('actionlog', reward)
        self.update('framelog', frame)

    def makeLog(self):
        self.frameLogger.makeLogFile()
        self.actionLogger.makeLogFile()

    def closeLogStream(self):
        self.frameLogger.closeStream()
        self.actionLogger.closeStream()

    def reviveScenarioPoint(self):
        #TODO get specific scenario state data from logfile and set that data at window
        return "A"

