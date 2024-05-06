"""
@file       superMarioModelController.py
@author     Suyong Choi
@brief      Controller class that controls the Super Mario model class
@version    1.0
@date       2024.05.03
"""
from abc import ABC, abstractmethod
from define import DEFINE
from logger.logger import logger

from ...view.superMarioView import superMarioView
from ...model.superMarioModel import IsuperMarioModel
from ...model.superMarioModel import superMarioModel

class superMarioModelController(IsuperMarioModel):

    def __init__(self, gymMario):
        """ 
        @brief              :   Function to initialize the Model Controller class that control model class
        @param gymMario     :   openAI's super mario bros environment
        @return             :   None
        """
        self.marioModel     =   None

        self.gym            =   gymMario
        self.marioModel     =   self.set_superMarioModel()


    def get_mario_x_position(self):
        """ 
        @brief              :   Function to get Mario's current x-coordinate from the data model class
        @return  	    :   Mario's current X coordinate data as an Inteager
        """
        return self.marioModel.get_mario_x_position()

    def get_mario_x_from_left_position(self):
        """ 
        @brief              :   Function that retrieves the distance between the left end of the window and the current Mario position from the data model class
        @return  	    :   retrieves the distance between the left end of the window and the current Mario position data as an Inteager
        """
        return self.marioModel.get_mario_x_from_left_position()

    def get_mario_y_position(self):
        """ 
        @brief              :   Function to get Mario's current y-coordinate from the data model class
        @return  	    :   Mario's current Y coordinate data as an Inteager
        """
        return self.marioModel.get_mario_y_position()

    def get_mario_gravity(self):
        """ 
        @brief              :   Function to get crrent gravity data from the data model class
        @return  	    :   current gravity data as an Inteager
        """
        gravity = self.marioModel.get_mario_gravity()

    def get_mario_speed(self):
        """ 
        @brief              :   Function to read current speed data from the data model class
        @return  	    :   current speed data as an Inteager
        """
        speed = self.marioModel.get_mario_speed()

    def get_score(self):
        """ 
        @brief              :   Function to read current score data from the data model class
        @return  	    :   current score data as an Inteager
        """
        score =  self.marioModel.get_score()

    def get_time(self):
        """ 
        @brief              :   Function to read current time data from the data model class
        @return  	    :   current score time as an Inteager
        """
        time = self.marioModel.get_time()

    def is_dead(self):
        """ 
        @brief              :   Function to check if Mario's status is death from the data model class
        @return  	    :   current state data which is dead as an Boolean
        """
        is_deade =  self.marioModel.is_dead()

    def is_clear(self):
        """ 
        @brief              :   Function to check if World is cleared from the data model class
        @return  	    :   stata to check whether the stage has been cleared as Boolean
        """
        is_clear =  self.marioModel.is_clear()

    def is_game_over(self):
        """ 
        @brief              :   Function that retrieves current health data checks whether it is 0 from the data accessor class
        @return  	    :   data to check if life is 0 as Boolean
        """
        return self.marioModel.is_game_over()

    def get_edge_x_pos(self):
        """ 
        @brief              :   Function to get screen edge x position which loads next screen when player past it from the data model class
        @return  	    :   screen edge x position data as Inteager
        """
        return self.marioModel.get_edge_x_pos()

    def get_move_screen_x_pos(self):
        """ 
        @brief              :   Function to get Player x position, moves screen position forward when this move from the data model class
        @return  	    :   get Player x position as Inteager
        """
        return self.marioModel.get_move_screen_x_pos()

    def memory_update(self):
        """ 
        @brief              :   Function to update memory map data at data model class
        @return  	    :   None
        """
        self.marioModel.memory_update()

    def set_superMarioModel(self):
        """ 
        @brief              :   Function to create and assign a Super Mario model class
        @return marioModel  :   mario model class instance
        """
        marioModel = superMarioModel(self.gym)

        if marioModel is DEFINE._DEFINE_NULL:
           logger.instanceEmptyAssertLog('model') 

        return marioModel

