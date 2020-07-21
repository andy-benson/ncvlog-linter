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
import shutil
import uuid

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

    file     = str(matches.group(1))
    line_num = str(matches.group(2))
    message  = str(matches.group(3))

    return file +":"+ line_num +":"+ msg_type +":"+ message + "\n\n"

#-----------------------------------------------------------------------------
# run ncvlog on the current file
#-----------------------------------------------------------------------------

ncvlog_output = subprocess.run(["ncvlog", incdir_cmd, "-sv", str(filelist[0])],capture_output=True,universal_newlines=True)

lines = ncvlog_output.stdout


lines = lines.split("\n")

#-----------------------------------------------------------------------------
# parse each of the lines looking for the ncvlog info / warning / error codes
#
# also can filter out certain error codes if required
# TODO : could 
#----------------------------------------------------------------------------


for line in lines:

    if line.startswith("ncvlog: *E"):
            out += process_line("Error",line)

    if line.startswith("ncvlog: *W"):
            out += process_line("Warning",line)
            
    if line.startswith("ncvlog: *I"):
            out += process_line("Info",line)

#-----------------------------------------------------------------------------
# clean up intermediate files and return output to providelinter function 
#-----------------------------------------------------------------------------        

if os.path.isfile("ncvlog.log"):
    os.remove("ncvlog.log")

# getting some weird error "Directroy not empty when running shutil.rmtree("INCA_libs")
# only when executed by the atom-ncvlog-linter.js. Think it is to do with process
# permissions ? anyway brute force with platfrom specific code
# subprocess.run(["rm", "-fr", "INCA_libs"])
# update
# this still causes problems ( see below) so as another brute force approach mv the pesky 
# directory into /tmp with a unique identifier. 

if os.path.isdir("INCA_libs"):
    shutil.move("INCA_libs","/tmp/" + str(uuid.uuid1))

print(out)

sys.exit(0)

#-----------------------------------------------------------------------------
# ncvlog errors
#-----------------------------------------------------------------------------


# csi-ncvlog - CSI: Command line:
# ncvlog
#     +incdir+/home/abenson/.atom/packages/atom-ncvlog-linter/lib
#     -sv
#     /home/abenson/.atom/packages/atom-ncvlog-linter/lib/muscab2_uvm_tb_top.sv
#     /home/abenson/.atom/packages/atom-ncvlog-linter/lib
# 
# csi-ncvlog - CSI: *F,INTERR: INTERNAL EXCEPTION
# -----------------------------------------------------------------
# The tool has encountered an unexpected condition and must exit.
# Contact Cadence Design Systems customer support about this
# problem and provide enough information to help us reproduce it,
# including the logfile that contains this error message.
#   TOOL:	ncvlog	15.20-s060
#   HOSTNAME: login18.euhpc.arm.com
#   OPERATING SYSTEM: Linux 3.10.0-957.1.3.el7.x86_64 #1 SMP Thu Nov 15 17:36:42 UTC 2018 x86_64
#   MESSAGE: xdlib_openPakLib: failed to seek end of bfp of library 'worklib'
# -----------------------------------------------------------------
# 
# csi-ncvlog - CSI: Cadence Support Investigation, recording details
# csi-ncvlog - CSI: investigation complete took 0.000 secs, send this file to Cadence Support




