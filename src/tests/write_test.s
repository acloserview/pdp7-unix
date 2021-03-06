" Test program for several system calls: open, read, write, close, exit
" Do:
"     ./as7 write_test.s > a.out
"     ./a7out -d a.out
main:
   " Test the lac, dac instructions
   lac in
   dac out

   " Write hello to fd1 i.e stdout
   lac d1
   sys write; hello; 7

   " Test if the assembler can dac into a mid-line label
   lac helloptr
   dac 1f
   lac d1
   sys write; 1:0; 7

   " Try to open file fred
   sys open; fred; 0;

   " read 5 words into the buffer from stdin: type in 10 or more characters!
   lac d0
   sys read; buf; 5

   " Stop and dump memory, so you can see five words at location 0400
   " Comment out the hlt instruction to test close and exit
   hlt

   " close stdin
   lac d0
   sys close

   " exit
   sys exit

   " We should not get to the halt instruction
   hlt


" Some memory locations for lac and dac
. = 0100
in: 023

. = 0200
out: 0

" Hello, world\n, two ASCII chars per word
hello: <He>; <l 0154; 0157 ,>; 040; <wo>; <rl>; <d 012
helloptr: hello

" fred as a four word filename
fred: <fr>; <ed>; 040040; 040040

" Input buffer for read
. = 0400
buf: 0

d0: 0
d1: 1
