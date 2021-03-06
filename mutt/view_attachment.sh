#!/bin/bash
#
# Author:  Simon Podhajsky, based on a script by Eric Gebhart
#
# Purpose:  To be called by mutt as indicated by .mailcap to send mail 
#           attachments to Chrome in ChromeOS/crouton.
#            
# Function: Copy the given file to a temporary directory so mutt
#           Won't delete it before it is read by the application.
#
#           Along the way, discern the file type or use the type 
#           That is given.
#
#           Finally use croutonurlhandler to open the file.
#
# Arguments:
#
#     $1 is the file
#     $2 is the type - for those times when file magic isn't enough.
#                      I frequently get html mail that has no extension
#                      and file can't figure out what it is.
#    
#                      Set to '-' if you don't want the type to be discerned.
#                      Many applications can sniff out the type on their own.
#                      And they do a better job of it too.
#                      
#                      Open Office and MS Office for example.
#                      
#     $3 is open with.  as in open -a 'open with this .app' foo.xls
#
# Debugging:  If you have problems set debug to 'yes'.  That will cause a debug file
#             be written to /tmp/mutt_attach/debug so you can see what is going on.
#
# See Also:  The man pages for open, file, basename

# the tmp directory to use.
tmpdir="$HOME/Downloads/mutt"

# the name of the debug file if debugging is turned on.
debug_file=$tmpdir/debug

# debug.  yes or no.  
debug="no"
#debug="yes"

type=$2
open_with=$3

# make sure the tmpdir exists.
mkdir -p $tmpdir

# Mutt puts everything in /tmp by default. 
# This gets the basic filename from the full pathname.
filename=`basename $1`

# get rid of the extension and save the name for later.
file=`echo $filename | cut -d"." -f1`

if [ $debug = "yes" ]; then
    echo "1:" $1 " 2:" $2 " 3:" $3 > $debug_file
    echo "Filename:"$filename >> $debug_file
    echo "File:"$file >> $debug_file
    echo "===========================" >> $debug_file
fi

# if the type is empty then try to figure it out.
if [ -z $type ]; then
    type=`file -bi $1 | cut -d"/" -f2`
fi

# if the type is '-' then we don't want to mess with type.
# Otherwise we are rebuilding the name.  Either from the
# type that was passed in or from the type we discerned.
if [ $type = "-" ]; then
    newfile=$filename
else
    newfile=$file.$type
fi

fullpath=$tmpdir/$newfile

# Copy the file to our new spot so mutt can't delete it
# before the app has a chance to view it.
cp $1 $fullpath

if [ $debug = "yes" ]; then
    echo "File:" $file "TYPE:" $type >> $debug_file
    echo "Newfile:" $fullpath >> $debug_file
    echo "Open With:" $open_with >> $debug_file
fi

if [[  "$OSTYPE" =~ darwin* ]]; then
    if [ -z $open_with ]; then
        open $fullpath
    else
        open -a "$open_with" $fullpath
    fi
else
    if [ command -v croutonurlhandler >/dev/null 2>&1 ]; then
        # Throw the file at Chrome -- it will handle it
        croutonurlhandler -n "file:///home/chronos/user/Downloads/mutt/$newfile"
    else
        xdg-open $fullpath
    fi
fi
