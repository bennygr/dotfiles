#!/bin/bash
#
# A simple script to generate the .clang_complete file for a project
# which contains the include path of the project
#
exec make CXX='~/.vim/bin/cc_args.py g++' -B
