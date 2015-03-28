# Functions and alias - From my .bash_profile
# ===========================================
#
# .. note:: Most of this commands are only testedd under Mac OS, but
#  most of the will run under other unix
#
# Features:
#  - Launch search services: google, wikipedia
#  - Translate (english to spanish) using google translate wordreference ...
#  - Open files graficaly (only mac, gnome)
#  - Play icat.cat radio station using mplayer
#  - And maybe others
#
# Installation:
#  Copy to your .bash_rc, or bash_profile or add the next line::
#
#       source path_to_various.sh

#  Where path_to_various.sh is the path, and filename, to this file

#  o - OPEN (Mac and Gnome)
# --------------------------

o(){ # open current dir if no args or open arg $1
    local runner="xdg-open"
    if [[ 'Darwin' == `uname` ]]; then
        runner="open"
    fi
    if [[ $1 != '' ]]; then
        $runner "$1"
    else
        $runner .
    fi
}

# cd to the directory of a file
# ------------------------------
#
#  .. FIXME:: support for paths with spaces
cdd(){
    echo "cd to the dirname of: $1"
    cd `dirname "$1"`
}

# HELPER function: htmlize
# ------------------------
# Prints input in a html friendly format, usin perl
htmlize(){
    echo "$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$1")"
}

# Search engines
# --------------
# .. TODO:: enhance multilanguage support

# 1. Google
g(){
    o https://encrypted.google.com/search?q=$1
}
# 2. Google translate
gtr() {
 local plus=""
 local sep=""
 for a in "$@"
 do
    plus=$plus$sep"$a"
    sep="+"
 done
 open 'http://translate.google.es/#en/es/'"$plus"
}

# 3. RAE (Real Academia Española) - Spanish dictionary
rae(){

    # Version 1 code
    #o http://buscon.rae.es/draeI/SrvltGUIBusUsual?LEMA=$1\&origen=RAE\&TIPO_BUS=3
    # Version 2, fixes encoding and uses the new uri
        # Version 3, simplifies encoding conversion

    local encoded=`echo $1 | iconv --to-code=ISO-8859-1 --from-code=UTF-8`
    local key=`htmlize $encoded`
    o http://www.rae.es/drae/srv/search?type=3\&val=$key\&val_aux=\&origen=RAE
}

# 4. DIEC (Diccionari de l'Institut d'Estudis Catalans) - Catalan Dictionary
diec(){
    o http://dlc.iec.cat/results.asp?txtEntrada=$1\&operEntrada=0
}

# 5. Wikipedia (WARNING this overrides the command *w* - who)
w(){
    local lang='es'
    if [[ $2 != '' ]]; then
        lang=$2
    fi
    o https://secure.wikimedia.org/wikipedia/$lang/w/index.php?search="$1"
}

# 6. Wordreference (english to spanish)
wr(){
    o http://www.wordreference.com/es/translation.asp?tranword=$1\&dict=enes\&B10=Search
}


# Verb forms - Conjugaciones
# --------------------------
# Spanish using: RAE (FIXME hardcoded path to projects/scripts/rae/rae.py)
# Catalan using: dicccionari.cat
conjuga(){
    if [[ $2 = 'ca' ]]; then
        o http://www.diccionari.cat/cgi-bin/AppDLC3.exe?APP=CONJUGA\&GECART=$1
    else
        o `$HOME/projects/scripts/rae/rae.py $1`
    fi
}


###############
# Shortcuts
###############

# icat.cat radio station
alias icat='mplayer http://tv3catwmlive.fplive.net/tv3cat-live/stream_iCatFM_WM -prefer-ipv4'
#Sublime Text 2 (runner only for mac)
alias slt='open -a "Sublime Text 2"'
#Remove .DS_Store
alias rmds="find . -name '*.DS_Store' -type f -delete"
