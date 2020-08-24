## ncvlog-linter package


SystemVerilog linter forked from :  https://github.com/KoenGoe/atom-vcs-linter)

Requires 'ncvlog' (Cadence Incisive) to compile the current verilog file. Cadence Incisive , seems to give the most "incisive"  error messages - hence the fork from atom-vcs-linter

Keeping the ncvlog compile to a single file keeps run time super speedy, and therefore the linter can work in-line during editing  ( you might want https://atom.io/packages/autosave-onchange)

This downside to this approach, is that project-wide dependencies such as  'include filepaths , and module instantiations may give false positives / false negatives.

### Dependencies :

1. 'ncvlog' available in your path
1. https://atom.io/packages/linter

### Under the hood

ncvlog-linter runs the following command line each time the current file (i.e. lint_test.v) is saved

```
ncvlog -sv +incdir+. -work mylib -logfile /tmp/logfile lint_test.v
```

mylib is set through the following 2 files :

```
#cds.lib
 DEFINE mylib /tmp/mylib 
```

```
#hdl.var
DEFINE WORK mylib 
```


Each of the error messages are then parsed , and reformatted before being passed back to the linter package. I.e. :  

Output from ncvlog 

```
ncvlog: 15.20-s060: (c) Copyright 1995-2018 Cadence Design Systems, Inc.
endmodule 
        |
ncvlog: *E,EXPLPA (lint_test.v,6|8): expecting a left parenthesis ('(') [12.1.2][7.1(IEEE)].
```

input to Atom linter

```
lint_test.sv:14:Error:expecting an identifier [9.2(IEEE)].
```

### ToDo

Add menu item so that additional command line options can be passed to ncvlog, such as additional files or include directories. 
