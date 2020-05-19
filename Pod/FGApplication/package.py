# coding=utf-8
import os
import sys
sys.path.append("../")
import subprocess
import shutil
import packagebase

podName = 'FGApplicationSDK'
productPodName = 'FGApplication'
podPath = os.path.abspath('') +'/'
outerClassPath = os.path.abspath("../../Classes") +'/'
outerClassFilePaths = ["Application"]
outerResousePath = os.path.abspath("../../Resource") +'/'
outerResouseFilePaths = ["FGApplicationBundle.bundle"]
publicHeaderFileNames = ['FGApplicationSDK.h']
localRepoPath = os.path.abspath("../Repo")
newVersion = '0.0.1'
if len(sys.argv) >= 2:
	newVersion = sys.argv[1]
pack = packagebase.FGPodPackage(podName, productPodName, podPath, newVersion, outerClassPath, outerClassFilePaths, outerResousePath, outerResouseFilePaths, publicHeaderFileNames,True,localRepoPath)
pack.startPod()


