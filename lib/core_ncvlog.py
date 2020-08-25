#-----------------------------------------------------------------------------
# run ncvlog and return data formatted for the providelinter function 
#
# Input: file to lint.
#
# Example Output ( from ncvlog) :
#   
#   ncvlog: *E,EXPCOM (lint_test.sv,21|8): expecting a comma [3.2.1][6.1(IEEE)].
#
# Example Output to providelinter:
#
#  /home/abenson/.atom/packages/atom-ncvlog-linter/lib/lint_test.sv:21:Error:expecting a comma [3.2.1][6.1(IEEE)].
#
#-----------------------------------------------------------------------------


from __future__ import print_function
import sys
import subprocess

import os
import re


args = sys.argv
filelist=args[1:]
filelist[0] = os.path.abspath(filelist[0])
head_tail = os.path.split(filelist[0])
filepath = head_tail[0]

incdir_cmd = "+incdir+" + filepath

out = ""
#-----------------------------------------------------------------------------
# subroutine to extract data from the error line line provided from ncvlog
#-----------------------------------------------------------------------------

def process_line(msg_type,line):
    
    #print(msg_type)
    my_line = str(line)
    
    matches = re.search(r"\(([\w\.\/-]+),(\d*)\|\d*\):\s(.+\.$)", my_line)

    if (matches):
        file     = str(matches.group(1))
        line_num = str(matches.group(2))
        message  = str(matches.group(3))

        return file +":"+ line_num +":"+ msg_type +":"+ message + "\n\n"
    
    # if there no match something has gone wrong with the regex, put error on first line 
    else:    
        return str(filelist[0]) +":0:Error:"+ my_line + "\n\n" 
      
#-----------------------------------------------------------------------------
# run ncvlog on the current file
#
#-----------------------------------------------------------------------------

ncvlog_output = subprocess.run(["ncvlog", incdir_cmd, "-sv", "-logfile", "/tmp/logfile",str(filelist[0])], capture_output=True,universal_newlines=True)

lines = ncvlog_output.stdout

lines = lines.split("\n")

#print (lines) 

#-----------------------------------------------------------------------------
# parse each of the lines looking for the ncvlog info / warning / error codes
#
#----------------------------------------------------------------------------

for line in lines:

    if line.startswith("ncvlog: *E"):
            out += process_line("Error",line)

    if line.startswith("ncvlog: *W"):
            out += process_line("Warning",line)
            
    if line.startswith("ncvlog: *I"):
            out += process_line("Info",line)

    if line.startswith("ncvlog: *F"):
            out += process_line("Fatal",line)
#-----------------------------------------------------------------------------
# return formatted errors back to calling java script
#
#----------------------------------------------------------------------------

print(out)

exit(0)
