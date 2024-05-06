"""
@file       Iobserver.py
@author     Suyong Choi
@brief      Interface for observer classes to keep instances up to date
@version    1.0
@date       2024.05.06
"""
from abc import ABC, abstractmethod

class Iobserver(ABC):

    @abstractmethod
    def update(self, value):
        """ 
        @brief              :   Function to update the instance to the latest state
        @param  value       :   Update target value 
        @return  	    :   None
        """
        pass
