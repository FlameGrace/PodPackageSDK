# coding=utf-8
import os
import sys
import subprocess
import shutil

buildDirName = 'build'
bundlesDirName = 'gotbundles'


# 实时输出命令行打印
def sh(command):
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE)
    print(type(p))
    lines = []
    for line in iter(p.stdout.readline, b''):
        line = line.strip()
        print(line)
        lines.append(line)
    return lines




def buildPod(bundleName):
	bulidcmd = 'xcodebuild -target ' + bundleName + ' -configuration Release clean build'
	sh(bulidcmd)
	productpath = os.path.abspath(buildDirName + '/Release-iphoneos/' + bundleName + '.bundle')
	despath = os.path.abspath(bundlesDirName + '/' + bundleName + '.bundle')
	if os.path.exists(productpath) is True:
		shutil.copytree(productpath, despath)
		return True
	return False




bundleNames = ['FGFoundationBundle','FGApplicationBundle','FGExtensionBundle']
removebulidcmd = 'rm -R ' + buildDirName
removebundlescmd = 'rm -R ' + bundlesDirName
sh(removebulidcmd)
sh(removebundlescmd)
bundlespath = os.path.abspath(bundlesDirName)
despath = os.path.realpath('../../Resource')
result = True
for bundleName in bundleNames:
	if buildPod(bundleName) is False:
		raise Exception('打包失败')
		result = False
if result is True:
	removeresourcecmd = 'rm -R ' + despath
	sh(removeresourcecmd)
	shutil.copytree(bundlespath, despath)
	sh(removebulidcmd)
	sh(removebundlescmd)




	 

