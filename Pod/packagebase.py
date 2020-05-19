# coding=utf-8
import os
import sys
import subprocess
import shutil

def removePath(path):
	if os.path.exists(path) is True:
		deletecmd = 'rm -rf -R  ' + path
		sh(deletecmd)

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

def makedir(path):
    if os.path.exists(path) is False:
    	print "hhh"
    	os.makedirs(path)

# 实时输出命令行打印
def addSpecToLocalRepo(localRepoPath,repoName,specPath,podName,version):
	localRepoPathSDKPath = localRepoPath + '/Specs/'+ podName +'/'+version+'/'
	if os.path.exists(localRepoPathSDKPath) is False:
		os.makedirs(localRepoPathSDKPath)
	shutil.copy(specPath,localRepoPathSDKPath)
	sh("cd "+localRepoPath +";git init;git add .;git commit -m 'spec'")
	sh("pod repo remove " + repoName)
	sh("pod repo add " + repoName +' '+localRepoPath)


# 成品文件为.framework
class FGPodPackage():
	"""docstring for ClassName"""
	def __init__(self, podName, productPodName, podPath, newVersion, outerClassPath, outerClassFilePaths, outerResousePath, outerResouseFilePaths, publicHeaderFileNames,outLibrary,localRepoPath):
		print podName
		print podPath
		print newVersion
		print outerClassPath
		print outerClassFilePaths
		print outerResousePath
		print outerResouseFilePaths
		print publicHeaderFileNames
		self.podPath = podPath
		self.productPodName = productPodName
		self.newVersion = newVersion
		self.outerClassPath = outerClassPath
		self.outerClassFilePaths = outerClassFilePaths
		self.podClassPath = self.podPath + 'Classes/'
		self.podName = podName
		self.outerResousePath = outerResousePath
		self.outerResouseFilePaths = outerResouseFilePaths
		self.publicHeaderFileNames = publicHeaderFileNames
		self.excludeplists = []
		self.outLibrary = outLibrary
		self.localRepoPath = localRepoPath


	def startPod(self):
		print "开始打包"
		self.copyClassFilesToPod()
		self.excludePlistBeforePackage()
		self.copyHeaderFilesToPodClass()
		self.package()
		self.copyExcludePlistAfterPackage()
		have = False
		if self.outLibrary is True:
			have = self.copyLibraryToPod()
		else:
			have = self.copyFramworkToPod()
		if have:
			self.copyThirdFrameworksAndOuterResouseToPod()
			self.copyPodSpecToPod()


	def copyClassFilesToPod(self):
		print "开始复制Classess文件到Pod目录中"
		removePath(self.podClassPath)
		makedir(self.podClassPath)
		for classFilePath in self.outerClassFilePaths:
			desPath = self.podClassPath + classFilePath
			sourcePath = self.outerClassPath + classFilePath
			shutil.copytree(sourcePath, desPath)


	def copyHeaderFilesToPodClass(self):
		print "开始整理Header文件"
		headerPath = self.podClassPath + 'Headers'
		os.makedirs(headerPath)
		for root, dirs, files in os.walk(self.podClassPath):
			for f in files:
				for x in self.publicHeaderFileNames:
					if x == f:
						fPath = os.path.join(root, f)
						desPath = os.path.join(headerPath, f)
						if fPath != desPath:
							shutil.copy(fPath, headerPath)
							removePath(fPath)
			for d in dirs:
				if d == 'PublicHeaders':
					srcPath = os.path.join(root, d)
					#current_foder是文件夹下所有子文件名组成的一个列表
					current_folder = os.listdir(srcPath)
					for x in current_folder:
						if x.endswith('.h'):
							fPath = srcPath + '/' + x
							shutil.copy(fPath, headerPath)
					removePath(srcPath)


	#打包前需要提前删除plist文件，否则会打包失败
	def excludePlistBeforePackage(self):
		print "开始删除Pod文件中的plist文件"
		excludePlistspath = self.podPath + 'excludePlists'
		removePath(excludePlistspath)
		makedir(excludePlistspath)
		i = 0
		for root, dirs, files in os.walk(self.podClassPath):
			for f in files:
				if f.endswith('.plist'):
					i = i + 1
					fPath = os.path.join(root, f)
					dPath = excludePlistspath + '/' + str(i) + f
					shutil.copyfile(fPath, dPath)
					self.excludeplists.append([dPath,fPath])
					os.remove(fPath)
			


	#打包成功后再把plist复制回去
	def copyExcludePlistAfterPackage(self):
		print "打包成功后再把plist复制回去"
		for ar in self.excludeplists:
			dPath = ar[0]
			fPath = ar[1]
			print fPath
			print dPath
			shutil.copyfile(dPath, fPath)
			excludePlistspath = self.podPath + 'excludePlists'


	def package(self):
		replacements = {'##PackageTag##':self.newVersion,'##PackageSourcePath##':self.podPath}
		packSepPath = self.podPath + 'packageSpec/'+ self.podName + '.podspec'
		podSepPath = self.podPath + self.podName  + '.podspec'
		podSepName = self.podName  + '.podspec'
		temPodSepPath = podSepPath + '1'
		inFile1 = open(packSepPath)
		tmpFile1 = open(temPodSepPath, 'w')
		for line1 in inFile1:
			for src1, target1 in replacements.iteritems():
				line1 = line1.replace(src1, target1)
			tmpFile1.write(line1)
		inFile1.close()
		tmpFile1.close()
		os.rename(temPodSepPath,podSepPath)
		print '开始执行git命令'
		initcmd = 'git init;'
		deletecmd = 'git tag -d ' + self.newVersion
		addcmd = 'git add .'
		commitcmd = 'git commit -m "' + self.newVersion + '"'
		tagcmd = 'git tag -a ' + self.newVersion + ' -m "' + self.newVersion + '"'
		sh(initcmd)
		sh(deletecmd)
		sh(addcmd)
		sh(commitcmd)
		sh(tagcmd)
		packagecmd = 'pod package '+ podSepName +' --force --no-mangle --exclude-deps'
		if self.outLibrary is True:
			packagecmd = packagecmd + ' --library'
		if self.localRepoPath is not None:
			packagecmd = packagecmd + ' --spec-sources=https://github.com/CocoaPods/Specs.git,' + self.localRepoPath
		print(packagecmd)
		sh(packagecmd)
		podpath = self.podPath + self.newVersion
		removePath(podpath)
		makedir(podpath)

	#复制打包成品到指定版本的文件夹中
	def copyFramworkToPod(self):
		print "检查SDK是否生成，并复制到成品文件夹中"
		productpath = self.podPath + self.podName  + '-' + self.newVersion
		productframworkpath = productpath + '/ios/' + self.podName + '.framework/Versions/Current' 
		podpath = self.podPath + self.newVersion
		vendorpath = podpath + '/Vendors'
		if os.path.exists(productframworkpath) is False:
			raise Exception('打包失败')
			return False
		desframworkpath = vendorpath + '/' + self.podName + '.framework'
		shutil.copytree(productframworkpath, desframworkpath)
		return True

	#复制打包成品到指定版本的文件夹中
	def copyLibraryToPod(self):
		print "检查SDK是否生成，并复制到成品文件夹中"
		productpath = self.podPath + self.podName  + '-' + self.newVersion
		productframworkpath = productpath + '/ios/lib' + self.podName + '.a' 
		podpath = self.podPath + self.newVersion
		vendorpath = podpath + '/Libs'
		makedir(vendorpath)
		if os.path.exists(productframworkpath) is False:
			raise Exception('打包失败')
			return False
		desframworkpath = vendorpath + '/lib' + self.podName + '.a'
		shutil.copy(productframworkpath, desframworkpath)
		headerPath = self.podClassPath + 'Headers'
		if os.path.exists(headerPath) is True:
			desHeaderPath = podpath + '/Headers'
			shutil.copytree(headerPath, desHeaderPath)
		return True

	#合并其他第三方库到指定文件中
	def copyThirdFrameworksAndOuterResouseToPod(self):
		print "开始复制第三方SDK和外部资源文件到成品文件夹中"
		podpath = self.podPath + self.newVersion
		vendorpath = podpath + '/Vendors/'
		libspath = podpath + '/Libs/'
		resourcepath = podpath + '/Resource/'
		makedir(libspath)
		for root, dirs, files in os.walk(self.podClassPath):
			#copy .a文件
			for f in files:
				if f.endswith('.a'):
					fPath = os.path.join(root, f)
					dPath = libspath + f
					shutil.copyfile(fPath, dPath)
			for d in dirs:
				if d.endswith('.framework'):
					fPath1 = os.path.join(root, d)
					dPath1 = vendorpath + d
					shutil.copytree(fPath1, dPath1)
		#复制外部资源
		for outerResouseFilePath in self.outerResouseFilePaths:
			sourcePath = self.outerResousePath + outerResouseFilePath
			desPath = resourcepath + outerResouseFilePath
			shutil.copytree(sourcePath, desPath)

	# 复制预定义podSpec文件	
	def copyPodSpecToPod(self):
		print "开始复制预定义podspec文件供外部工程引用"
		podpath = self.podPath + self.newVersion
		productSpecPath = self.podPath+'productSpec/'+self.podName+'.podspec'
		desPodSpecName =  self.productPodName
		desSpecPath = podpath+'/'+desPodSpecName+'.podspec'
		replacements = {'##PackageTag##':self.newVersion,"##PackageName##":desPodSpecName}
		temPodSepPath = productSpecPath + '1'
		inFile1 = open(productSpecPath)
		tmpFile1 = open(temPodSepPath, 'w')
		for line1 in inFile1:
			for src1, target1 in replacements.iteritems():
				line1 = line1.replace(src1, target1)
			tmpFile1.write(line1)
		inFile1.close()
		tmpFile1.close()
		shutil.move(temPodSepPath, desSpecPath)
		

print "导入基础模块成功"
