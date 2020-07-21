## ncvlog-linter package


systemverilog linter forked from :  https://github.com/KoenGoe/atom-vcs-linter)

Requires 'ncvlog' (Cadence Incisive) to compile a single verilog file, that gives more insightful error messages than VCS. 

Keeping the ncvlog compile to a single file keeps run time super speedy, and therefore the linter can work in-line during editing  ( you might want https://atom.io/packages/autosave-onchange)

This downside to this approach, is that project-wide dependencies such as  'include filepaths , and module instantiations may give false positives / false negatives.

### Dependencies :

1. 'ncvlog' available in your path
1.https://atom.io/packages/linter

### Under the hood

ncvlog-linter runs the following command line each time the current file is saved:

```
ncvlog -sv +incdir+<pwd> <myfile>
```
Each of the error messages are then parsed , and reformatted before being passed back to the linter package. 

```
lint_test.sv:14:Error:expecting an identifier [9.2(IEEE)].
```

### ToDo

Add menu item so that additional command line options can be passed to ncvlog, such as additional files or include directories. 


