# Assembly Programming
This is a repository for various assembly programming Experiments, primarily written in x86 assembly language.

## Getting Started
To get started with this repository, you will need to have an understanding of assembly language and access to an assembler or an emulator that can run assembly language code.

The code in this repository is organized into directories based on Experiments.

## Running the Programs
To execute the programs create a bash file (.sh extension) and paste the commands given below. Save this bash file in the same directory as the Program files.
```bash
#!/usr/bin/bash

nasm -f elf32 $1.asm
ld -m elf_i386 -s -o $1 $1.o
./$1
```
Command to run the bash file
```bash
bash bash_file.sh file_name
```

## Course Topics
The following is a list of topics covered in this repository:

- Basic I/O Operations
- Basic Mathematical Operations
- Control Flow Statements
- Various looping techniques
- Usage of Macros

## Contributing
Contributions to this repository are welcome. If you find an error or have a suggestion, please open an issue or submit a pull request.
