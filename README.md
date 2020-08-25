## ncvlog-linter package


SystemVerilog linter forked from :  https://github.com/KoenGoe/atom-vcs-linter)

Requires 'ncvlog' (Cadence Incisive) to compile the current verilog file. Cadence Incisive , seems to give the most "incisive"  error messages - hence the fork from atom-vcs-linter

Keeping the ncvlog compile to a single file keeps run time super speedy, and therefore the linter can work in-line during editing  ( you might want https://atom.io/packages/autosave-onchange)

This downside to this approach, is that project-wide dependencies such as  'include filepaths , and module instantiations may give false positives / false negatives.

### Dependencies :

1. 'ncvlog' available in your path
1. https://atom.io/packages/linter

### Under the hood

ncvlog-linter runs the following command line each time the current file is saved ( in this example lint_test.v)

```
ncvlog -sv +incdir+. -logfile /tmp/logfile lint_test.v
```



Each of the error messages are then parsed , and reformatted before being passed back to the linter package. I.e. :  

* Output from ncvlog 

```
ncvlog: 15.20-s060: (c) Copyright 1995-2018 Cadence Design Systems, Inc.
endmodule 
        |
ncvlog: *E,EXPLPA (lint_test.v,6|8): expecting a left parenthesis ('(') [12.1.2][7.1(IEEE)].
```

* input to Atom linter

```
lint_test.sv:6:Error:expecting a left parenthesis ('(') [12.1.2][7.1(IEEE)].
```

* linter message in Atom

![ncvlog-linter-screenshot](https://user-images.githubusercontent.com/68588485/91172343-ed2f2800-e6d3-11ea-8c56-accab977e416.png)

### ToDo

1. Add menu item so that additional command line options can be passed to ncvlog, such as additional files or include directories.
2. Clean up INCA_libs , harder than first appears ( when run as part of atom package), tricky to delete, tricky to map work dir to alternative location, i.e.  /tmp
There might be some more atom linter utils that could help with removing temp files. 
