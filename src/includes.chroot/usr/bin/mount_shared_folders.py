#!/usr/bin/python3
# -*- coding: utf-8 -*-

import subprocess
import os


# read list of shared folders

def get_shared_folders(only_automounted=False):

	result = []

	# get sharedfolder names from Virtual Box command line tool VBoxControl
	if only_automounted:
		lines = subprocess.check_output(['VBoxControl', '--nologo', 'sharedfolder', 'list', '-automount'])
	else:
		lines = subprocess.check_output(['VBoxControl', '--nologo', 'sharedfolder', 'list'])
	lines = lines.decode('utf-8').split("\n")

	prefix = ' - '

	i=0
	for line in lines:
		i+=1
		# ignore first two lines (status info) and last (empty) line and message if no folders available
		if i > 2 and line and not line=="No Shared Folders available.":
			# get only the shared folder name (after "number - ")
			# by cutting line until end position of first " - "
			sharedfolder = line[ line.find(prefix)+len(prefix) : ]
			
			result.append(sharedfolder)

	return result


def get_shared_folders_not_automounted():

	
	shared_folders = get_shared_folders(only_automounted=False)
	
	automounted = get_shared_folders(only_automounted=True)
	
	# delete automounted shared folders from list
	for folder in automounted:
		shared_folders.remove(folder)
	
	return shared_folders


def mount(sharedfolder):
	
	mountdir = '/media/sf_' + sharedfolder
	
	if not os.path.isdir(mountdir):
		os.mkdir(mountdir)
		
	result = subprocess.call(['mount','-t','vboxsf', sharedfolder, mountdir])

	return result


def mount_not_automounted_shared_folders():
	shared_folders = get_shared_folders_not_automounted()
	
	# mount each not automounted folder
	for shared_folder in shared_folders:
		
		#print "Mounting not automounted shared folder {}".format( folder )
		mount(shared_folder)


mount_not_automounted_shared_folders()
