# coding=utf-8
import os
import sys
sys.path.append("../")
import subprocess
import shutil
import packagebase

podName = 'FGFoundationSDK'
productPodName = 'FGFoundation'
podPath = os.path.abspath('') +'/'
outerClassPath = os.path.abspath("../../Classes") +'/'
outerClassFilePaths = ["Foundation"]
outerResousePath = os.path.abspath("../../Resource") +'/'
outerResouseFilePaths = ["FGFoundationBundle.bundle"]
publicHeaderFileNames = ['FGFoundationSDK.h']
localRepoPath = os.path.abspath("../Repo")
newVersion = '0.0.1'
if len(sys.argv) >= 2:
	newVersion = sys.argv[1]
pack = packagebase.FGPodPackage(podName, productPodName, podPath, newVersion, outerClassPath, outerClassFilePaths, outerResousePath, outerResouseFilePaths, publicHeaderFileNames,True,None)
pack.startPod()
# 需要建立本地Repo用于其他SDK引用
localRepoPath = os.path.abspath("../Repo")
specPath = os.path.abspath(podName+'.podspec')
packagebase.addSpecToLocalRepo(localRepoPath,podName+'Repo',specPath,podName,newVersion)


