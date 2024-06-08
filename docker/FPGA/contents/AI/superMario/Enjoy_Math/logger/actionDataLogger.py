import os
from datetime import datetime

from define import DEFINE
from logger.logger import logger
from supermario.observer.Iobserver import Iobserver

class actionDataLogger(Iobserver):

    def __init__(self):
        self.actionLogDir   =  DEFINE._DEFINE_ACTION_LOG_DIR 

        now = datetime.now()
        logTime = now.strftime('%Y_%m_%d_%H:%M:%S')

        self.actionLogfile  =   self.actionLogDir + "/" + logTime

        self.actionLogFileStream    =   None

        self.stepNum                 = 0

    def makeLogFile(self):
        if not os.path.exists(self.actionLogfile):
            self.actionLogFileStream = open(self.actionLogfile, mode="w")

    def writeActionLogFile(self, step, reward):
        if self.actionLogFileStream is DEFINE._DEFINE_NULL:
            logger.fileStreamNoneAssertLog('action stream')

        self.actionLogFileStream.write(f"{step},{reward},\n")


    def closeSteam(self):
        self.actionLogFileStream.close()

    def update(self, value):
        self.writeActionLogFile(self.stepNum, value)
    
    def setStepNum(self, stepNum):
        self.stepNum = stepNum

