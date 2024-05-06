"""
@file       memoryMap.py
@author     Suyong Choi
@brief      Reads and Updates the memory of the ROM file and its values.
@version    1.0
@date       2024.05.01
"""
import numpy as np

class memoryMap():

    def __init__(self, env):
        self.env = env.gymMarioEnv
        """ 
        @brief      :   Function to initialize the memoryMap class
        @param env  :   openAI super mario bros gym Environment
        @return     :   None
        """

        """
        @brief      :   Dictionary containing memory addresses of ROM files(Key And Value are Must set String)
        """ 
        self.memoryAddr = {
                            'x_position'        :   'self.env.ram[0x6d] * 0x100 + self.env.ram[0x86]',
                            'left_x_position'   :   'np.uint8(int(self.env.ram[0x86]) - int(self.env.ram[0x071c])) % 256',
                            'y_pixel'           :   'self.env.ram[0x03b8]',
                            'y_viewport'        :   'self.env.ram[0x00b5]',
                            'player_state'      :   'self.env.ram[0x000e]',
                            'life'              :   'self.env.ram[0x075a]',
                            'world_state'       :   'self.env.ram[0x0770]',
                            'life'              :   'self.env.ram[0x075a]',
                            'screen_edge_x_pos' :   'self.env.ram[0x071c]',
                            'move_screen_x_pos' :   'self.env.ram[0x071d]',

                            'score'             :   'self._read_mem_range(0x07de, 6)',
                            'time'              :   'self._read_mem_range(0x07f8, 3)',
                            'coin'              :   'self._read_mem_range(0x7ed, 2)',

                        }
        """ 
        @brief      :   Dictionary containing updated Value From Memory Address
        """ 
        self.memoryMap = {}

    def memory_update(self):
        """ 
        @brief      :   Interpret maps containing memory details and update data
        @param      :   None
        @return     :   None
        """
        
        for key in self.memoryAddr:
            value                   =   self.memoryAddr[key].replace("'","")
            self.memoryMap[key]     =   eval(value)

    def _read_mem_range(self, address, length):
        """ 
        @brief      :   Reading memory values in a certain section (excerpted from openAI environment)
        @param      :   None
        @return     :   None
        """
        return int(''.join(map(str, self.env.ram[address:address + length])))
