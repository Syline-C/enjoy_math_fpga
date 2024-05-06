"""
@file       draw.py
@author     Suyong Choi
@brief      A class that outputs shapes and text on Super Mario's screen.
@version    1.0
@date       2024.05.06
"""
import pyglet
from queue import Queue

from define import DEFINE
from logger.logger import logger
from ..property.figureProperty import figureProperty
from ..property.textProperty import textProperty

class draw:

    def __init__(self, window):
        """
        @brief              :   Function to initialize instances displayed on the screen of Super Mario
        @param   window     :   Super Mario Window Instance
        @return             :   None
        """
        self.stepQue                =   Queue()
        self.window                 =   window

        self.rewardTextProperty     =   textProperty('Reward', 30, (5 ,800))
        self.rewardLabel            =   self.set_reward_label()

    def make_step_node(self, coordinate, step):
        """
        @brief              :   Function to create a node to display Mario's steps on the screen
        @param  coordinate  :   Coordinates for displaying Mario step nodes on the window 
        @param  step        :   Mario's step numbers displayed on the screen
        @return             :   None
        """

        step_node =   None

        circle  =   firgureProperty()
        circle.set_circle_coordinate(coordinate)

        text    =   textProperty()
        text.set_coordinate(coordinate)
        text.set_text(step)

        step_node = (circle, text) 

        if step_circle is DEFINE._DEFINE_NULL:
           logger.instanceEmptyAssertLog('step circle') 

        return step_node

    def set_step_circle_to_queue(self, step_node):
        """
        @brief              :   Function to put a Mario step node into the output queue.
        @param  step_node   :   Step node to queue for output
        @return             :   None
        """
        self.stepQueue.put(step_node)

    def pop_step_circle(self):
        """
        @brief              :   Function to pop a Mario step node in front of the output queue.
        @return             :   None
        """
        self.setpQueue.get()

    def set_reward_label(self):
        """
        @brief              :   Function to create a reward text label displayed on the screen
        @return             :   None
        """

        text            =   self.rewardTextProperty.get_text() + " : 0"
        fontsize        =   self.rewardTextProperty.get_fontsize() 
        x_coordinate    =   self.rewardTextProperty.get_coordinate()[0]
        y_coordinate    =   self.rewardTextProperty.get_coordinate()[1]

        reward_label = pyglet.text.Label(text,
                          font_name='Times New Roman',
                          font_size= fontsize,
                          x=x_coordinate, y=y_coordinate)

        if reward_label is DEFINE._DEFINE_NULL:
           logger.instanceEmptyAssertLog('reward label')

        return reward_label

    def update_reward_text(self, rewardScore):
        """
        @brief              :   Function to update the reward value displayed on the screen
        @param  rewardScore :   Reward value to be updated 
        @return             :   None
        """
        self.rewardLabel.text   =   self.rewardTextProperty.get_text() + " : " + str(rewardScore)

    def write_reward(self, rewardScore):
        """
        @brief              :   Function to print reward label on Super Mario window
        @param  rewardScore :   Reward value to be updated 
        @return             :   None
        """
        self.update_reward_text(rewardScore)
        self.rewardLabel.draw()

