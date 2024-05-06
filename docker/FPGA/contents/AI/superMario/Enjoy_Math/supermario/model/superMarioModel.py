"""
@file       superMarioModel.py
@author     Suyong Choi
@brief      Model class that reads data from ROM file
@version    1.0
@date       2024.05.01
"""
from .IsuperMarioModel import IsuperMarioModel
from .superMarioDataAccessor import superMarioDataAccessor

class superMarioModel(IsuperMarioModel):
    
    def __init__(self, env):
        """ 
        @brief              :   Function to initialize the model class that reads data from the ROM file
        @param env  	    :   openAI's super mario bros environment
        @return             :   None
        """
        self.supermario     = env
        self.dataAccessor   = superMarioDataAccessor(env)

    def get_mario_x_position(self):
        """ 
        @brief              :   Function to get Mario's current x-coordinate from the data accessor class
        @return  	    :   Mario's current X coordinate data as an Inteager
        """
        return self.dataAccessor.get_mario_x_position()

    def get_mario_x_from_left_position(self):
        """ 
        @brief              :   Function that retrieves the distance between the left end of the window and the current Mario position from the data accessor class
        @return  	    :   retrieves the distance between the left end of the window and the current Mario position data as an Inteager
        """
        return self.dataAccessor.get_mario_x_from_left_position()

    def get_mario_y_position(self):
        """ 
        @brief              :   Function to get Mario's current y-coordinate from the data accessor class
        @return  	    :   Mario's current Y coordinate data as an Inteager
        """
        return self.dataAccessor.get_mario_y_position()

    def get_mario_gravity(self):
        """ 
        @brief              :   Function to get crrent gravity data from the data accessor class
        @return  	    :   current gravity data as an Inteager
        """
        return self.dataAccessor.get_mario_gravity()

    def get_mario_speed(self):
        """ 
        @brief              :   Function to read current speed data from the data accessor class
        @return  	    :   current speed data as an Inteager
        """
        return self.dataAccessor.get_mario_speed()

    def get_score(self):
        """ 
        @brief              :   Function to read current score data from the data accessor class
        @return  	    :   current score data as an Inteager
        """
        return self.dataAccessor.get_score()

    def get_time(self):
        """ 
        @brief              :   Function to read current time data from the data accessor class
        @return  	    :   current score time as an Inteager
        """
        return self.dataAccessor.get_time()

    def is_dead(self):
        """ 
        @brief              :   Function to check if Mario's status is death from the data accessor class
        @return  	    :   current state data which is dead as an Boolean
        """
        return self.dataAccessor.is_dead()

    def is_clear(self):
        """ 
        @brief              :   Function to check if World is cleared from the data accessor class
        @return  	    :   stata to check whether the stage has been cleared as Boolean
        """
        return self.dataAccessor.is_clear()

    def get_edge_x_pos(self):
        """ 
        @brief              :   Function to get screen edge x position which loads next screen when player past it from the data accessor class
        @return  	    :   screen edge x position data as Inteager
        """
        return self.dataAccessor.get_edge_x_pos()

    def is_game_over(self):
        """ 
        @brief              :   Function that retrieves current health data checks whether it is 0 from the data accessor class
        @return  	    :   data to check if life is 0 as Boolean
        """
        return self.dataAccessor.is_game_over()

    def get_move_screen_x_pos(self):
        """ 
        @brief              :   Function to get Player x position, moves screen position forward when this move from the data accessor class
        @return  	    :   get Player x position as Inteager
        """
        return self.dataAccessor.get_move_screen_x_pos()

    def memory_update(self):
        """ 
        @brief              :   Function to update memory map data at data accessor class
        @return  	    :   None
        """
        self.dataAccessor.memory_update()
