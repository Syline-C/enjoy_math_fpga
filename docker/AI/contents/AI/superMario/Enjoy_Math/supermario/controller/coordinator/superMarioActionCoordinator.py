"""
@file       superMarioActionCoordinator.py
@author     Suyong Choi
@brief      Coordinator class that controls Mario's decisions and actions
@version    1.0
@date       2024.05.03
"""
from abc import ABC, abstractmethod
import gym
from ..controller.superMarioControllerBuilder import superMarioControllerBuilder

class superMarioActionCoordinator:

    def __init__(self, controllerBuilder, actions:list ):
        """ 
        @brief              :   Function to initialize the Controller Builder class that creates and manages Super Mario's controller classes
        @param gymMario     :   openAI's super mario bros environment
        @param title        :   Super Mario's Windows title
        @return             :   None
        """
        self.controllerBuilder  = controllerBuilder

        self.modelController    = controllerBuilder.get_marioModelController()
        self.viewController   = controllerBuilder.get_marioViewController()

    def makeStep(self):
        """
        TODO                :   Connect to reinforcement learning logic for Mario's decision making  
        @brief              :   Function that returns data based on the results of Mario's decision.
        @return state       :   Game data based on Mario's decision-making results as Integer(dictonary[0]) 
        @return reward      :   Reward Value based on Mario's decision-making results as Float(dictornary[1])
        @return done        :   Whether to reset the game according to the results of Mario's decision as Boolean(dictonary[2])
        """
        self.modelController.memory_update()

        ## TODO connect to reenforcement Logic
        return self.viewController.step(self.controllerBuilder.gymMario.gymMarioEnv.action_space.sample())

