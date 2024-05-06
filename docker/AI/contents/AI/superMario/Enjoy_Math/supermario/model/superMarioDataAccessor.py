"""
@file       superMarioDataAccessor.py
@author     Suyong Choi
@brief      DataAccessor class that reads data from ROM file
@version    1.0
@date       2024.05.01
"""
from define import DEFINE
from logger.logger import logger

from memoryMap import memoryMap

class superMarioDataAccessor:

    def __init__(self, env):
        """ 
        @brief              :   Function to initialize the data accessor class that reads data from the ROM file
        @param env  	    :   openAI's super mario bros environment
        @return             :   None
        """
        self.map = {}
        self.mem = memoryMap(env)

    def get_mario_x_position(self):
        """ 
        @brief              :   Function to get Mario's current x-coordinate data from the memory map
        @return  	    :   Mario's current X coordinate data as an Inteager
        """
        x_position = self.map['x_position']
        return x_position

    def get_mario_x_from_left_position(self):
        """ 
        @brief              :   Function that retrieves the distance between the left end of the window and the current Mario position in the memory map.
        @return  	    :   retrieves the distance between the left end of the window and the current Mario position data as an Inteager
        """
        left_x_position = self.map['left_x_position']
        return left_x_position


    def get_mario_y_position(self):
        """ 
        @brief              :   Function that calculates Mario's current y-coordinate through data in the memory map. 
        @return  	    :   Mario's current Y coordinate data as an Inteager
        """

        viewport    = self.map['y_viewport']
        y_pixel     = self.map['y_pixel']

        if viewport < 1:
            return 255 * ( 255 - y_pixel)

        return (255 - y_pixel)

    def get_mario_gravity(self):
        """ 
        TODO                    Write logic to calculate gravity
        @brief              :   Function to get crrent gravity data from the memory map
        @return  	    :   current gravity data as an Inteager
        """
        return "A"

    def get_mario_speed(self):
        """ 
        TODO                    Write logic to get current Mario's speed data 
        @brief              :   Function to read current speed data from the data accessor class
        @return  	    :   current speed data as an Inteager
        """
        return "A"

    def get_score(self):
        """ 
        @brief              :   Function to read current score data from the memory map
        @return  	    :   current score data as an Inteager
        """
        score = self.map['score']

        if score is not DEFINE._DEFINE_NULL :
            logger.variableNoneAssertLog('score')

        return score

    def get_time(self):
        """ 
        @brief              :   Function to read current time data from the memory map
        @return  	    :   current score time as an Inteager
        """
        time = self.map['time']

        if time is not DEFINE._DEFINE_NULL :
            logger.variableNoneAssertLog('time')

        return time


    def is_dead(self):
        """ 
        @brief              :   Function to check if Mario's status is death through memory map data
        @return  	    :   current state data which is dead as an Boolean
        """
        state = self.map['player_state']

        if state is DEFINE._DEFINE_NULL :
            logger.variableNoneAssertLog('player_state')

        return (state == DEFINE._DEFINE_PLAYER_DEAD)
        
    def is_world_over(self):
        """ 
        @brief              :   Function to check if World is over through memory map data
        @return  	    :   current state data which is dead as an Boolean
        """
        world_state   =   self.map['world_state']

        if world_state is DEFINE._DEFINE_NULL:
            logger.variableNoneAssertLog('world_state')

        return (world_state == DEFINE._DEFINE_WORLD_STATE_END)

    def is_game_over(self):
        """ 
        @brief              :   Function that retrieves current health data from the memory map and checks whether it is 0.
        @return  	    :   data to check if life is 0 as Boolean
        """
        life    =   self.map['life']
        return (life == DEFINE._DEFINE_LIFE_IS_OVER)


    def get_edge_x_pos(self):
        """ 
        @brief              :   Function to get screen edge x position which loads next screen when player past it from the memory map
        @return  	    :   screen edge x position data as Inteager
        """
        screen_x_pos    =   self.map['screen_edge_x_pos']
        return screen_x_pos


    def get_move_screen_x_pos(self):
        """ 
        @brief              :   Function to get Player x position, moves screen position forward when this move from the memory map
        @return  	    :   get Player x position as Inteager
        """
        move_x_pos    =   self.map['move_screen_x_pos']
        return move_x_pos

    def memory_update(self):
        """ 
        @brief              :   Function to update memory map data
        @return  	    :   None
        """
        self.mem.memory_update()
        self.map    =   self.mem.memoryMap
