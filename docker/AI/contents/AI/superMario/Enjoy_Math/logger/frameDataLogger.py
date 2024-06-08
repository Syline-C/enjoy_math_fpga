import os
import numpy as np
from datetime import datetime

from define import DEFINE
from logger.logger import logger
from supermario.observer.Iobserver import Iobserver

class frameDataLogger(Iobserver):

    def __init__(self):
        self.frameLogDir    =  DEFINE._DEFINE_FRAME_LOG_DIR 

        now = datetime.now()
        logTime = now.strftime('%Y_%m_%d_%H:%M:%S')

        self.frameLogfile   =   self.frameLogDir + "/" + logTime

        self.frameLogFileStream     =   None

        self.stepNum                 = 0

    def makeLogFile(self):
        if not os.path.exists(self.frameLogfile):
            self.frameLogFileStream = open(self.frameLogfile, mode="a")


    def writeFrameLogFile(self, step, frame):
        if self.frameLogFileStream is DEFINE._DEFINE_NULL:
            logger.fileStreamNoneAssertLog('frame stream')
        
        self.frameLogFileStream.write(f"{step},{frame.tobytes()},\n")

    def closeSteam(self):
        self.frameLogFileStream.close()

    def update(self, value):
        self.writeFrameLogFile(self.stepNum, value)
    
    def setStepNum(self, stepNum):
        self.stepNum = stepNum

    def makeCSV(self, frame):
        
        dataStr = ""
        for std in frame:
            if dataStr == "":
                dataStr += dataStr + str(std)
            else:
                dataStr += dataStr + "," + str(std)

        return dataStr
