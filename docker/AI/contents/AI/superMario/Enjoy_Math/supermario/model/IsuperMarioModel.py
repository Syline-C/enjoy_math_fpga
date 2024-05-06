"""
@file       IsuperMarioModel.py
@author     Suyong Choi
@brief      Interface of model class that reads data from ROM file
@version    1.0
@date       2024.05.01
"""
from abc import ABC, abstractmethod

class IsuperMarioModel(ABC):
    
    @abstractmethod
    def get_mario_x_position(self):
        """ 
        @brief              :   Function to read Mario's current X coordinate data
        @return  	    :   Mario's current X coordinate data as an Inteager
        """
        pass

    @abstractmethod
    def get_mario_x_from_left_position(self):
        """ 
        @brief              :   Function that retrieves the distance between the left end of the window and the current Mario position 
        @return  	    :   retrieves the distance between the left end of the window and the current Mario position data as an Inteager
        """
        pass


    @abstractmethod
    def get_mario_y_position(self):
        """ 
        @brief              :   Function to read Mario's current Y coordinate data
        @return  	    :   Mario's current Y coordinate data as an Inteager
        """
        pass

    @abstractmethod
    def get_mario_gravity(self):
        """ 
        TODO                    Write logic to calculate gravity
        @brief              :   Function to get crrent gravity data
        @return  	    :   current gravity data as an Inteager
        """
        pass

    @abstractmethod
    def get_mario_speed(self):
        """ 
        TODO                    Write logic to get current Mario's speed
        @brief              :   Function to read current speed data
        @return  	    :   current speed data as an Inteager
        """
        pass

    @abstractmethod
    def get_score(self):
        """ 
        @brief              :   Function to read current score data
        @return  	    :   current score data as an Inteager
        """
        pass

    @abstractmethod
    def get_time(self):
        """ 
        @brief              :   Function to read current time data
        @return  	    :   current score time as an Inteager
        """
        pass

    @abstractmethod
    def is_dead(self):
        """ 
        @brief              :   Function to check if Mario's status is death
        @return  	    :   current state data which is dead as an Boolean
        """
        pass

    @abstractmethod
    def is_clear(self):
        """ 
        @brief              :   Function to check if World is cleared
        @return  	    :   stata to check whether the stage has been cleared as Boolean
        """
        pass

    @abstractmethod
    def get_edge_x_pos(self):
        """ 
        @brief              :   Function to get screen edge x position which loads next screen when player past it
        @return  	    :   screen edge x position data as Inteager
        """
        pass

    @abstractmethod
    def is_game_over(self):
        """ 
        @brief              :   Function that retrieves current health data checks whether it is 0.
        @return  	    :   data to check if life is 0 as Boolean
        """
        pass


    @abstractmethod
    def get_move_screen_x_pos(self):
        """ 
        @brief              :   Function to get Player x position, moves screen position forward when this moves
        @return  	    :   get Player x position as Inteager
        """
        pass

    @abstractmethod
    def memory_update(self):
        """ 
        @brief              :   Function to update memory map data
        @return  	    :   None
        """
        pass


