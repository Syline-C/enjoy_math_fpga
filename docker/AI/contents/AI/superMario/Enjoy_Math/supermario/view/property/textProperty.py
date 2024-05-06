"""
@file       textProperty.py
@author     Suyong Choi
@brief      Property class for text drawn on Super Mario's window
@version    1.0
@date       2024.05.03
"""

class textProperty():
    
    def __init__(self, text, fontsize, coordinate):
        """ 
        @brief              :   Function to initialize the Text Property class that default setting
        @return             :   None
        """
        self.text       =   text
        self.fontsize   =   fontsize
        self.coordinate =   coordinate
        self.font       =   'Times New Roman'


    def get_text(self):
        """ 
        @brief              :   Function to get text
        @return             :   text that print on windwas String
        """
        return self.text

    def get_fontsize(self):
        """ 
        @brief              :   Function to get text size
        @return             :   text size as Inteager
        """
        return self.fontsize

    def get_coordinate(self):
        """ 
        @brief              :   Function to get text coordinate
        @return             :   text coordinate as dictornary(x,y)
        """
        return self.coordinate

    def set_text(self, text):
        """ 
        @brief              :   Function to set text
        @param  text        :   text as String
        @return             :   None
        """
        self.text   =   text

    def set_fontsize(self, fontsize):
        """ 
        @brief              :   Function to set font size
        @param  fontsize    :   fontsize as Inteager
        @return             :   None
        """
        self.fontsize   =   fontsize

    def set_coordinate(self, coordinate):
        """ 
        @brief              :   Function to set text coordinate
        @param  coordinatee :   coordinate as dictonary(x,y)
        @return             :   None
        """
        self.coordinate =   coordinate
