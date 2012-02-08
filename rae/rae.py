#!/usr/bin/python2.5
# encoding: utf-8
"""
rae.py

Created by Ariel von Barnekow on 2010-12-24.
Copyright (c) 2010 arielvb. All rights reserved.
"""

import sys
import getopt
import urllib


help_message = '''
Busca la url de la conjugación de un verbo en la web de la RAE
Usage:
	rae [-v] verbo
'''
tag = 'IDVERBO='


class Usage(Exception):
	def __init__(self, msg):
		self.msg = msg


def main(argv=None):
	verbose = False
	if argv is None:
		argv = sys.argv
	try:
		try:
			opts, args = getopt.getopt(argv[1:], "ho:v", ["help", "output="])
		except getopt.error, msg:
			raise Usage(msg)
		if len(args) == 0:
			raise Usage(help_message)
		
		# option processing
		for option, value in opts:
			if option == "-v":
				verbose = True
			if option in ("-h", "--help"):
				raise Usage(help_message)
			if option in ("-o", "--output"):
				output = value
	except Usage, err:
		print >> sys.stderr, sys.argv[0].split("/")[-1] + ": " + str(err.msg)
		print >> sys.stderr, "\t for help use --help"
		return 2
	try:
		if verbose:
			print "Recuperando identificador verbo...",
		data = urllib.urlopen("http://buscon.rae.es/draeI/SrvltGUIBusUsual?origen=RAE&LEMA="+args[0])
		text = data.read();
		pos = text.find(tag);
		if pos < 0 :
			if verbose: 
				print "error"
			raise Usage("Verbo no encontrado")
		if verbose:
			print "hecho"
		pos += len(tag)
		'''	i = text.find('"', pos, 15)
		'''
	except Usage, err:
		print >> sys.stderr, sys.argv[0].split("/")[-1] + ": " + str(err.msg)
		return -1

	for i in range(0,15):
		if text[pos+i] == '"':
			break
	idverbo = text[pos:pos+i]
	if verbose:
		print "Url: ",
	print "http://buscon.rae.es/draeI/SrvltGUIVerbos?origen=RAE&IDVERBO=" + idverbo


	
if __name__ == "__main__":
	sys.exit(main())
