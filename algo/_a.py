import os
import shutil

dirpath = '.'
for file in os.listdir(dirpath):
	if file.find('%2F') >= 0:
		newfile = dirpath + "/" + file.replace("%2F", '_')
		print file, newfile
		shutil.move(dirpath + "/" + file, newfile)