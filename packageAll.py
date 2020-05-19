# coding=utf-8
import os
import sys
sys.path.append("Pod")
import subprocess
import shutil
from packagebase import sh
from packagebase import makedir
from packagebase import removePath

newVersion = '0.0.1'
if len(sys.argv) >= 2:
	newVersion = sys.argv[1]
sh("cd DevDir/DemoProject; python buildBundle.py")
removePath("SDK")
makedir("SDK")
needPackList = ["FGFoundation","FGApplication","FGExtension"]
for x in needPackList:
	pkcmd = 'cd Pod/'+x+';python package.py '+newVersion
	sh(pkcmd)
	srcPath = os.path.abspath('Pod/' + x + '/' + newVersion)
	desPath = os.path.abspath('SDK/' + x)
	shutil.copytree(srcPath,desPath)

