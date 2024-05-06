"""
@file       builder.py
@author     Suyong Choi
@brief      Declaring the Super Mario environment builder class
@version    1.0
@date       2024.05.01
"""

import gym_super_mario_bros
import gym

from gym import Wrapper
from gym import Env

from gym_super_mario_bros.actions import SIMPLE_MOVEMENT
from nes_py.wrappers import JoypadSpace

from supermario.facade.marioFacade import marioFacade

from logger.logger import logger
from define import DEFINE


class gymMario:
    def __init__(self, level):
        """ 
        @brief          :   Function to create a Mario environment in openAI
        @param level    :   The Super Mario stage level you want to run
        @return         :   None
        """

        self.gymMarioEnv    = gym_super_mario_bros.make(level)
        self.gymMarioEnv    = JoypadSpace(self.gymMarioEnv, SIMPLE_MOVEMENT)

class superMario(Wrapper):
   
    def __init__(self, gymMario:Env, title):
        """ 
        @brief              :   Function to create a customized Super Mario environment from Facade Class
        @param gymMario     :   openAI's Super Mario environment created from the gymMario class
        @param title        :   Super Mario screen title
        @return             :   None
        """
        self.marioFacede = None

        self.marioFacade = marioFacade(gymMario, title)

        if self.marioFacade is DEFINE._DEFINE_NULL:
           logger.instanceEmptyAssertLog('Facade') 


    def step(self):
        """ 
        @brief              :   Returns the result of Mario's decision
        @return state       :   Mario's state according to decision making as an Integer
        @return reward      :   Reward value based on decision-making as an Float
        @return done        :   True if decision-making is in progress, False otherwisee as an Boolean
        """

        return self.marioFacade.step()

    def reset(self):
        """ 
        @brief              :   Use openAI’s Windows data reset function
        @return             :   None
		"""
        self.marioFacade.reset()

    def render(self, reward):
        """ 
        @brief              :   Function to render Mario's game data to a window
        @return             :   None
		"""
        self.marioFacade.render(reward)


class marioBuilder:

    def __init__(self, title, level):
        """ 
        @brief              :   Initialize the class that builds the customized Super Mario environment and openAI's Mario environment.
        @param title        :   Super Mario screen title
        @param level        :   Super Mariio game level
        @return             :   None
        """
        self.title          = title
        self.builder        = None
        self.baseMario      = gymMario(level)

    def build(self):
        """ 
        @brief              :   Build a customized Super Mario environment and openAI’s Mario environment
        @return  builder    :   Built Super Mario environment as superMario Class Instance
        """
        self.builder     = superMario(self.baseMario, self.title)

        if self.builder is DEFINE._DEFINE_NULL:
           logger.instanceEmptyAssertLog('builder') 

        return self.builder

