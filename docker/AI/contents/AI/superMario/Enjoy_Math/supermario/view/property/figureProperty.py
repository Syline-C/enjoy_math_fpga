"""
@file       figureProperty.py
@author     Suyong Choi
@brief      Property class for shapes drawn on Super Mario's window
@version    1.0
@date       2024.05.03
"""

class figureProperty:

    def __init__(self):
        """ 
        @brief              :   Function to initialize the Figure Property class that default setting
        @return             :   None
        """
        self.circleColor        =   (255,0,0)
        self.circleRadius       =   10
        self.circleCoordinate   =   (0,0)

    def get_circle_color(self):
        """ 
        @brief              :   Function to get circle color
        @return             :   circle color as dictonary(RGB)
        """
        return self.color

    def get_circle_radius(self):
        """ 
        @brief              :   Function to get circle radius
        @return             :   circle color as Inteager
        """
        return self.radius

    def get_circle_coordinate(self):
        """ 
        @brief              :   Function to get circle coordinate
        @return             :   circle color as dictonary(x,y)
        """
        return self.cordinate

    def set_circle_color(self, color):
        """ 
        @brief              :   Function to set circle color
        @param  color       :   circle color as dictonary(RGB)
        @return             :   None
        """
        self.color  =   color

    def set_circle_radius(self, radius):
        """ 
        @brief              :   Function to set circle radius
        @param  radius      :   circle radius as Inteager
        @return             :   None
        """
        self.radius - radius

    def set_circle_coordonate(self, coordinate):
        """ 
        @brief              :   Function to set circle coordinate
        @param  radius      :   circle coordinate as dictonary(x,y)
        @return             :   None
        """
        self.coordinate = coordinate

