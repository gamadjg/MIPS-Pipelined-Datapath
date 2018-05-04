# MIPS-Pipelined-Datapath
CSU Sacramento CSC 142, Term Project

![alt text](https://github.com/gamadjg/MIPS-Pipelined-Datapath/blob/master/Final_datapath_F2017.png "142 Datapath")

Control + General TT			0: Use source from Register File          1: Use Sign Extended Value		00:{8’b0, constant} 01: SE immd                      10: SE op2                     11: Sign extend op1	00: Don't write/read Mem                        01: Write/Read word                                              10: Store/ Load concatenated byte		00: No writing                 01: Write to reg1 only                   10: Write reg 1 & 2	0: NoMem to Reg       1: MemToReg	0: No Write         1: Write to R15	0: Use Regular PC   1: Use new PC	00: Default, do nothing                    01: Branch less              10: Branch greater          11: Branch on equal
												
|Instruction | Opcode | ALUop | ALUsrc1 | ALUsrc2 | SE_Sel | memWrite | memRead | regWrite | memToReg | WriteR15 | ChangePC | Comparator|
|add | 1111 | 0000 | 0 | 0 | 00 | 00 | 00 | 01 | 0 | 0 | 0 | 00 |
|sub | 1111 | 0001 | 0 | 0 | 00 | 00 | 00 | 01 | 0 | 0 | 0 | 00 |
|mul | 1111 | 0100 | 0 | 0 | 00 | 00 | 00 | 10 | 0 | 1 | 0 | 00 |
|div | 1111 | 0101 | 0 | 0 | 00 | 00 | 00 | 01 | 0 | 1 | 0 | 00 |
|move| 1111 | 0111 | 0 | 0 | 00 | 00 | 00 | 01 | 0 | 0 | 0 | 00 |
|SWAP| 1111 | 1000 | 0 | 0 | 00 | 00 | 00 | 10 | 0 | 0 | 0 | 00 |
|andi| 1000 | N/A  | 0 | 1 | 00 | 00 | 00 | 01 | 0 | 0 | 0 | 00 |
|ori | 1001 | N/A  | 0 | 1 | 00 | 00 | 00 | 01 | 0 | 0 | 0 | 00 |
|lbu | 1010 | N/A  | 1 | 0 | 01 | 00 | 10 | 01 | 1 | 0 | 0 | 00 |
|sb	 | 1011 | N/A  | 1 | 0 | 01 | 10 | 00 | 00 | 0 | 0 | 0 | 00 |
|lw	 | 1100 | N/A  | 1 | 0 | 01 | 00 | 01 | 01 | 1 | 0 | 0 | 00 |
|sw	 | 1101 | N/A  | 1 | 0 | 01 | 01 | 00 | 00 | 0 | 0 | 0 | 00 |
|blt | 0101 | N/A  | 0 | 0 | 10 | 00 | 00 | 00 | 0 | 0 | 1 | 01 |
|bgt | 0100 | N/A  | 0 | 0 | 10 | 00 | 00 | 00 | 0 | 0 | 1 | 10 |
|beq | 0110 | N/A  | 0 | 0 | 10 | 00 | 00 | 00 | 0 | 0 | 1 | 11 |
|jmp | 0001 | N/A  | 0 | 0 | 11 | 00 | 00 | 00 | 0 | 0 | 1 | 00 |
|halt| 0000 | N/A  | 0 | 0 | 00 | 00 | 00 | 00 | 0 | 0 | 0 | 00 |

| Tables| Are| Cool  |
|sdfsdf|sdf|ddddd|
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |
