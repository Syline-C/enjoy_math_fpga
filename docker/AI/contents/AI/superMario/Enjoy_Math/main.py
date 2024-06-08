"""
@file       main.py
@author     Suyong Choi
@brief      Main file that runs Super Mario.
@version    1.0
@date       2024.05.01
"""
import pyglet
import os
from builder import marioBuilder

import time

env             = None
reward          = 0.0
done            = True
window          = None

def init_env(mode='interactive'):
    global env

    makeLogDir()

    builder         = marioBuilder('Supermario','SuperMarioBros-v0')
    builder.set_mode(mode)
    env = builder.build()

def update(dt):
    global state, done, reward
    if done:
        state = env.reset()
    state, reward, done = env.step()
    env.render(reward)
    
def set_action_and_step(action):
    global  state, done, reward, window
    if done:
        state  = env.reset()
        done = False
    else:
        
        state, reward, done = env.step(action)
        window = env.render(reward)
        window.flip()
    return state, reward, done

def reset_env():
    global state, done, window, reward
    state  = env.reset()

    return state


def makeLogDir():
    if not os.path.exists("LOG/frame"):
            os.makedirs("LOG/frame")

    if not os.path.exists("LOG/action"):
            os.makedirs("LOG/action")

if __name__ == "__main__":

    init_env('command')
    pyglet.clock.schedule_interval(update, 1/60)
    pyglet.app.run()

#    init_env()
#    reset_env()
#    for i in range (100):
#        state, reward, done = set_action_and_step(1)

