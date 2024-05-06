"""
@file       observer.py
@author     Suyong Choi
@brief      bserver classes to keep instances up to date
@version    1.0
@date       2024.05.06
"""

class observer:

    def __init__(self):
        """ 
        @brief              :   Function to initialize the observer class that stores instances for monitoring
        @return  	    :   None
        """
        self.actionObserver      =   []
        self.rewardObserver      =   []
    
    def attach(self, observer, obsCategory):
        """ 
        @brief              :   Function to register instances for monitoring in the observer class
        @param  observer    :   attatch Instances for monitoring
        @param  obsCategory :   Monitoring category for the instance
        @return  	    :   None
        """

        if obsCategory == 'action':
            self.actionObserver.append(observer)
        elif obsCategory == 'reward':
            self.rewardObserver.append(observer)

    def detach(self, observer, obsCategory):
        """ 
        @brief              :   Function to detatch instances for monitoring in the observer class
        @param  observer    :   detach Instances for monitoring
        @param  obsCategory :   Monitoring category for the instance
        @return  	    :   None
        """
        if obsCategory == 'action':
            self.actionObserver.remove(observer)
        elif obsCategory == 'reward':
            self.rewardObserver.remove(observer)

    def action_notify(self, value):
        """ 
        @brief              :   Update instances that need to be updated according to the results of the action.
        @param  value       :   A value that needs to be updated according to the result of the action
        @return  	    :   None
        """
        for obs in self.actionObserver:
            obs.update(value)

    def reward_notify(self, reward):
        """ 
        @brief              :   Update instances that need to be updated according to the results of the reward.
        @param  value       :   A value that needs to be updated according to the result of the reward
        @return  	    :   None
        """
        for obs in self.rewardObserver:
            obs.update(reward)
    
