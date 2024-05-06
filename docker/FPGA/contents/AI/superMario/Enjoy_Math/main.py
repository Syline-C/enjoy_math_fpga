"""
@file       main.py
@author     Suyong Choi
@brief      Main file that runs Super Mario.
@version    1.0
@date       2024.05.01
"""
from builder import marioBuilder
import pyglet

marioBuilder = marioBuilder('Supermario','SuperMarioBros-v0')
env = marioBuilder.build()

done = True

def update(dt):
    """ 
    @brief          :   Function to update state and rewards according to Mario’s decisions
    @param dt       :   Delta time, which is the time difference between frames.
    @return         :   None
    """
    global done
    if done:
        state = env.reset()

    state, reward, done = env.step()
    env.render(reward)
    
pyglet.clock.schedule_interval(update, 1/60)
pyglet.app.run()

