"""
@file       superMarioDrawCoordinator.py
@author     Suyong Choi
@brief      Coordinator class that Draw Mario's decisions and actions on Window
@version    1.0
@date       2024.05.03
"""
from define import DEFINE
from ...observer.Iobserver import Iobserver
from ...view.draw.draw import draw

class superMarioDrawCoordinator(Iobserver):
    
    def __init__(self, controllerBuilder) :
        """ 
        @brief                      :   Function that initializes a class that draws shapes according to Super Mario's decisions and actions.
        @param controllerBuilder    :   Integrated builder class with controllers for drawing shapes
        @return                     :   None
        """

        self.modelController    =   controllerBuilder.get_marioModelController()
        self.viewController     =   controllerBuilder.get_marioViewController()

        self.viewer             =   self.viewController.get_marioView().viewer

        self.window             =   None
        self.drawer             =   None

        self.stepNum            =   0
        self.dotList            =   ()

    def write_text(self, rewardScore):
        """ 
        @brief                      :   Function to print text on Super Mario's screen
        @param rewardScore          :   Reward value of decision
        @return                     :   None
        """
        self.drawer.write_reward(rewardScore)


    def draw_dot(self):
        """ 
        TODO                        :   Create logic to output shapes and numbers appropriate for the node 
        @brief                      :   Function to display nodes according to Mario's decision on the screen
        @return                     :   None
        """
        return "A"



    def draw_line(self):
        """ 
        TODO                        :   Write logic to connect nodes with lines
        @brief                      :   Function that outputs lines to connect nodes
        @return                     :   None
        """
        return "A"


    def update(self, rewardScore):
        """ 
        @brief                      :   Function to update data output on the screen in real time
        @param rewardScore          :   Reward value of decision
        @return                     :   None
        """
        
        marioView   =   self.viewController.get_marioView()

        if marioView is not DEFINE._DEFINE_NULL:
            self.window     =   marioView.window

        if self.window is not DEFINE._DEFINE_NULL:
            self.drawer     =   self.set_draw()

        if self.drawer is not DEFINE._DEFINE_NULL:
            self.write_text(rewardScore)

    def set_draw(self):
        """ 
        @brief                      :   Function to set the draw class
        @return                     :   None
        """

        drawer    =   draw(self.window)
        if drawer is DEFINE._DEFINE_NULL:
            logger.instanceEmptyAssertLog('draw')

        return drawer

    def get_draw(self):
        """ 
        @brief                      :   Function to get the draw class
        @return                     :   draw class instance
        """
        return self.drawer

