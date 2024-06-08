"""
@file       superMarioControllerBuilder.py
@author     Suyong Choi
@brief      Builder class that creates and manages Super Mario's controller classes
@version    1.0
@date       2024.05.03
"""
from abc import ABC, abstractmethod
import gym

from define import DEFINE
from logger.logger import logger

from .IsuperMarioController import IsuperMarioController
from .superMarioViewController import superMarioViewController
from .superMarioModelController import superMarioModelController

class superMarioControllerBuilder(IsuperMarioController):

    def __init__(self, gymMario, title, mode ):
        """ 
        @brief              :   Function to initialize the Controller Builder class that creates and manages Super Mario's controller classes
        @param gymMario     :   openAI's super mario bros environment
        @param title        :   Super Mario's Windows title
        @return             :   None
        """
        self.gymMario                   =   gymMario
        self.title                      =   title
        self.mode                       =   mode
        self.marioModelController       =   None
        self.marioViewController        =   None
        #TODO
        self.marioObserverController    =   None

        self.marioViewController        =   self.set_marioViewController()
        self.marioModelController       =   self.set_marioModelController()
        #TODO
        self.marioObserverController    =   self.set_marioObserverController()

    def set_marioViewController(self):
        """
        @brief              :   Function to create and assign the Super Mario Viewer Controller class
        @return             :   Super Mario Viewer Controller Class Instance
        """
        marioViewController   = superMarioViewController(self.gymMario, self.title, self.mode)
        
        if marioViewController is DEFINE._DEFINE_NULL:
            logger.instanceEmptyAssertLog('viewController')

        return marioViewController

    def set_marioModelController(self):
        """
        @brief              :   Function to create and assign the Super Mario Model Controller class
        @return             :   Super Mario Model Controller Class Instance
        """
        marioModelController   = superMarioModelController(self.gymMario)

        if marioModelController is DEFINE._DEFINE_NULL:
            logger.instanceEmptyAssertLog('modelController')

        return marioModelController
        
    def set_marioObserverController(self):
        """
        TODO                :   After reinforcement learning logic is completed, create class creation and allocation logic to monitor the results
        @brief              :   Function to create and assign the Reenforcement Observer Controller class
        @return             :   Reenforcement Observer Class Instance
        """
    #   self.marioObserverController = superMarioObserverController() 
    #   if marioModelController is DEFINE._DEFINE_NULL:
    #        logger.instanceEmptyAssertLog('modelController')

        return "A"


    def get_marioViewController(self):
        """
        @brief              :   Function to get mario view controller instance
        @return             :   mario view controller Class Instance
        """
        return self.marioViewController

    def get_marioModelController(self):
        """
        @brief              :   Function to get mario model controller instance
        @return             :   mario model controller Class Instance
        """
        return self.marioModelController

    def get_marioObserverController(self):
        """
        TODO                :   After reinforcement learning logic is completed, create get mario Observer controller instances
        @brief              :   Function to create and assign the Reenforcement Observer Controller class
        @return             :   Reenforcement Observer Class Instance
        """
        # return self.marioObserverController
        return "A"
        

