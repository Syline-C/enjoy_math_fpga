"""
@file       superMarioViewController.py
@author     Suyong Choi
@brief      Controller class that controls the Super Mario View class
@version    1.0
@date       2024.05.03
"""
from abc import ABC, abstractmethod
import gym

from define import DEFINE
from logger.logger import logger
from ...view.IsuperMarioView import IsuperMarioView
from ...view.superMarioView import superMarioView
from ...view.property.superMarioViewProperty import superMarioViewProperty

class superMarioViewController(IsuperMarioView):

    def __init__(self, gymEnv, title):
        """ 
        @brief              :   Function to initialize the View Controller class that control view classe
        @param gymMario     :   openAI's super mario bros environment
        @param title        :   Super Mario's Windows title
        @return             :   None
        """
        self.title          =   title
        self.marioView      =   None
        self.gymEnv         =   gymEnv
        self.marioView      =   self.set_superMarioView()
        self.viewProperty   =   superMarioViewProperty()

        
    def step(self, action):
        """
        TODO                :   Write reinforcement learning logic for Mario's decision making 
                                Currently, openAI's function is being used, so once the logic is completed, delete step method in view class
        @brief              :   Function that returns data based on the results of Mario's decision.
        @return state       :   Game data based on Mario's decision-making results 
        @return reward      :   Reward Value based on Mario's decision-making results 
        @return done        :   Whether to reset the game according to the results of Mario's decision
        """
        result =  self.marioView.step(action)

        state = result[0]
        reward = result[1]
        done    = result[2]

        return state, reward, done

    def render(self):
        """
        @brief              :   Function that renders the screen on a window based on data
        @return             :   None
        """
        self.marioView.render()

    def reset(self):
        """
        @brief              :   Function to reset the data of the game window and return it to its initial state
        @return             :   None
        """
        self.marioView.reset()

    def set_superMarioView(self):
        """ 
        @brief              :   Function to create and assign a Super Mario view class
        @return marioModel  :   mario view class instance
        """
        marioView = superMarioView( self.gymEnv)

        if marioView is  DEFINE._DEFINE_NULL:
            logger.instanceEmptyAssertLog("View")

        return marioView 

    def get_marioView(self):
        """ 
        @brief              :   Function to get a Super Mario view class
        @return marioModel  :   mario view class instance
        """
        return self.marioView
