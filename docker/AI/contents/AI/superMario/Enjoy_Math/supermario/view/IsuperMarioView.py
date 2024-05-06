"""
@file       IsuperMarioView.py
@author     Suyong Choi
@brief      Interface of view class that control view
@version    1.0
@date       2024.05.01
"""
from abc import ABC, abstractmethod

class IsuperMarioView(ABC):

    @abstractmethod
    def render(self):
        """
        @brief              :   Function that renders the screen on a window based on data at view class
        @return             :   None
        """
        pass

    @abstractmethod
    def reset(self):
        """
        @brief              :   Function to reset the data of the game window and return it to its initial state at view class
        @return             :   None
        """
        pass
