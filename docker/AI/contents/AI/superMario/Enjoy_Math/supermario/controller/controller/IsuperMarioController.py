"""
@file       IsuperMarioController.py
@author     Suyong Choi
@brief      Interface in Controller Builder Class
@version    1.0
@date       2024.05.03
"""
from abc import ABC, abstractmethod

class IsuperMarioController(ABC):

    @abstractmethod
    def get_marioModelController(self):
        """
        @brief          :   Function to retrieve the Super Mario Model Controller class
        @return         :   Super Mario Model class Instanace
        """
        pass

    @abstractmethod
    def get_marioObserverController(self):
        """
        @brief          :   Function to retrieve the Reenforcement Observer class
        @return         :   Reenforcement class Instanace
        """
        pass

    @abstractmethod
    def get_marioViewController(self):
        """
        @brief          :   Function to retrieve the Super Mario View class
        @return         :   Super Mario View class Instanace
        """
        pass
