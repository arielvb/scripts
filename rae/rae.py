#!/usr/bin/env python
# encoding: utf-8
"""
rae.py
======
:Description: Spanish verb conjugator uri generator for www.rae.es
:Version: 1.1
:Author: Ariel von Barnekow

Changelog
---------

1.1 (2012-11-09)
................

- Update rae uri to: rae.es/dra/srv
- Now uses regex to find the verb id.

1.0 (2010-12-24)
................

- First version

"""

import sys
import getopt
import urllib2
import re


HELP = '''
Busca la url de la conjugación de un verbo en la web de la RAE
Usage:
    rae [-v] verbo
'''
URI_LEMA = ("http://www.rae.es/drae/srv/search?type=3&val="
            "%s&val_aux=&origen=RAE")
URI_VERBO = 'http://www.rae.es/drae/srv/search?id=%s'
VERBOSE = False


class Usage(Exception):
    def __init__(self, msg):
        self.msg = msg


def verbosity(msg):
    """Prints msg, if verbose mode is enabled"""
    if VERBOSE:
        print msg


def main(argv=None):
    """Main function"""
    global VERBOSE

    if argv is None:
        argv = sys.argv
    try:
        try:
            opts, args = getopt.getopt(argv[1:], "ho:v", ["help", "output="])
        except getopt.error, msg:
            raise Usage(msg)
        if len(args) == 0:
            raise Usage(HELP)

        # option processing
        for option, value in opts:
            if option == "-v":
                VERBOSE = True
            if option in ("-h", "--help"):
                raise Usage(HELP)
            if option in ("-o", "--output"):
                output = value
    except Usage, err:
        print >> sys.stderr, sys.argv[0].split("/")[-1] + ": " + str(err.msg)
        print >> sys.stderr, "\t for help use --help"
        return 2

    verbosity("Buscando el verbo...")
    term = args[0]  # the search term
    data = urllib2.urlopen(URI_LEMA % term)
    text = data.read()
    verbosity("Recuperando identificador conjugación...")

    idverbo = re.findall('\<a href="search\?id=([^\"]*)" target="_self">'
                         '<img alt="Ver conjugación"', text)
    if not len(idverbo):
        verbosity("error")
        raise Usage("Verbo %s no encontrado" + term)
    else:
        idverbo = idverbo[0]

    print URI_VERBO % idverbo


if __name__ == "__main__":
    sys.exit(main(sys.argv))
