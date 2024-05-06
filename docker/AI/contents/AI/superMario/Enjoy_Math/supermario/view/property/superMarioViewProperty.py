"""
@file       superMarioViewProperty.py
@author     Suyong Choi
@brief      Super Mario's Window View Property Class
@version    1.0
@date       2024.05.03
"""

class superMarioViewProperty:

    def __init__(self):
        """ 
        @brief              :   Function to initialize the View Property class that default setting
        @return             :   None
        """
        self.SCREEN_HEIGHT   =   1000
        self.SCREEN_WIDTH    =   1000
        self.TITLE           =   "ENJOY_MATH_SUPERMARIO"   

    def get_screen_height(self):
        """ 
        @brief              :   Function to get view screen height size 
        @return             :   screen height size as Inteager
        """
        return self.SCREEN_HEIGHT

    def get_screen_width(self):
        """ 
        @brief              :   Function to get view screen width size 
        @return             :   screen width size as Inteager
        """
        return self.SCREEN_HEIGHT

    def get_title(self):
        """ 
        @brief              :   Function to get window title 
        @return             :   window title as String
        """
        return self.TITLE

    def set_screen_height(self, height):
        """ 
        @brief              :   Function to set view screen height size 
        @param  height      :   view screen height size
        @return             :   None
        """
        self.SCREEN_HEIGHT = height

    def set_screen_width(self, width):
        """ 
        @brief              :   Function to set view screen width size 
        @param  width       :   view screen width size
        @return             :   None
        """
        self.SCREEN_WIDTH = width

    def set_title(self, title):
        """ 
        @brief              :   Function to set window title
        @param  width       :   window title
        @return             :   None
        """
        self.TITLE = title


