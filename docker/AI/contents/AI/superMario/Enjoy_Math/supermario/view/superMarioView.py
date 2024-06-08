"""
@file       superMarioView.py
@author     Suyong Choi
@brief      View Class that outputs ROM file data to Windows
@version    1.0
@date       2024.05.06
"""
import pyglet

from define import DEFINE
from logger.logger import logger

from nes_py._image_viewer import ImageViewer 
from .IsuperMarioView import IsuperMarioView
from .property.superMarioViewProperty import superMarioViewProperty
from .draw.draw import draw

class superMarioView(IsuperMarioView):

    def __init__(self,  gym, mode):
        """ 
        @brief              :   Function that initializes a class that outputs ROM file data to Windows.
        @param gym          :   openAI's gym environment
        @return             :   None
        """
        self.gymMario           =   gym.gymMarioEnv
        self.viewer             =   gym.gymMarioEnv.viewer
        self.screen             =   gym.gymMarioEnv.screen
        self.done               =   gym.gymMarioEnv.done
        self.mode               =   mode

        self.viewProperty       =   superMarioViewProperty()
        self.window             =   None
        self.image              =   None

    def render(self, mode = 'human'):
        """ 
        @brief              :   Function to render game data on the screen
        @param mode         :   Rendering mode: Only human mode is used by default.
        @return             :   None
        """
        if mode == 'human':
            if self.viewer is None:
                self.viewer = self.set_image_viewer()

                self.viewer.open()
                self.get_img_data(self.screen)
            self.show(self.screen)
            
            if self.mode == 'interactive':
                return self.window

        elif mode == 'rgb_array':
            return self.screen
        else:
            render_modes = [repr(x) for x in self.metadata['render.modes']]
            msg = 'valid render modes are: {}'.format(', '.join(render_modes))
            raise NotImplementedError(msg)

    def set_image_viewer(self):
        """ 
        @brief              :   Function to create and initialize an image viewer
        @return             :   None
        """
        height  =   self.viewProperty.get_screen_height()
        width   =   self.viewProperty.get_screen_width()
        title   =   self.viewProperty.get_title()

        viewer = ImageViewer(
                    caption=title,
                    height=height,
                    width=width,
                )

        if viewer is DEFINE._DEFINE_NULL:
           logger.instanceEmptyAssertLog('gymMario View') 
        return viewer

    def step(self, action):
        """ 
        TODO                :   Currently using openAI's example. Needs to be modified after writing reinforcement learning logic
        @brief              :   Function that moves Mario according to an action randomly selected from the action list.
        @param  action      :   Action selected from Mario's action list
        @return             :   None
        """
        return self.gymMario.step(action)

    def reset(self):
        """ 
        @brief              :   Function to initialize Mario's view
        @return             :   None
        """
        return self.gymMario.reset()

    def get_img_data(self, frame):
        """ 
        @brief              :   Function to extract game data from ROM file
        @param  frame       :   Game data extracted from ROM files
        @return             :   None
        """
        height  =   self.viewProperty.get_screen_height()
        width   =   self.viewProperty.get_screen_width()

        image = pyglet.image.ImageData(
            frame.shape[1],
            frame.shape[0],
            'RGB',
            frame.tobytes(),
            pitch=frame.shape[1]*-3
        )
        # send the image to the window
        self.image = image
        image.blit(0, 0, width=width, height=height)

    def set_imageData(self, frame):
        return "A"

    def show(self, frame):
        """ 
        @brief              :   Function to output game data extracted from ROM file to Windows
        @param  frame       :   Game data extracted from ROM files
        @return             :   None
        """
        self.window = self.viewer._window
        height  =   self.viewProperty.get_screen_height()
        width   =   self.viewProperty.get_screen_width()


        if len(frame.shape) != 3:
            raise ValueError('frame should have shape with only 3 dimensions')
        if not self.is_open:
            self.open()

        self.window.clear()
        self.window.switch_to()
        self.window.dispatch_events()

        image = pyglet.image.ImageData(
            frame.shape[1],
            frame.shape[0],
            'RGB',
            frame.tobytes(),
            pitch=frame.shape[1]*-3
        )
        # send the image to the window
        self.image = image
        image.blit(0, 0, width=width, height=height)

    @property
    def is_open(self):
        """ 
        @brief              :   Property function to check whether Super Mario's window has been created.
        @return             :   Returns true if the screen is open, or false otherwise as Boolean
        """
        return self.window is not None
