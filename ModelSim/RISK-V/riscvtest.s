# riscvtest.s
# Sarah.Harris@unlv.edu
# David.Harris@hmc.edu
# 27 Oct 2020

# Test the RISC-V processor:
# add, sub, and, or, slt, addi, lw, sw, beq, jal
# If successful, it should write the value 25 to address 100
#
#   RISC-V Assembly        Description                     Address    Machine Code
#
main:  addi x2, x0, 5      # x2 = 5                          0         00500113
       addi x3, x0, 9      # x3 = 9                          4         00900193
       sub  x4, x2, x3     # x4 = (12 - 9) = 3               8         40F282B3
       or   x5, x3, x4     # x5 = (3 OR 9) = 7               C         0042B2B3
       add  x6, x3, x4     # x6 = 9 + 4 = 11                 10        0051B33
       and  x7, x5, x3     # x7 = (7 AND 9) = 1              14        004323B3
       beq  x4, x7, end    # shouldn't be taken              18        02728363
       slt  x8, x4, x5     # x8 = (12 < 9) = 0               1C        00F3C33
       lw   x9, 100(x0)    # load 100 into x9                20        0x64
       sw   x2, 100(x0)    # store 5 into 100                24        0x10402823
around: addi x4, x4, 1     # x4 = (3 + 1) = 4                28        00200293
       sub  x1, x2, x3     # x1 = (12 - 9) = 3               30        40500033
       add  x2, x2, x4     # shouldn't be taken              34        4220033
       beq  x1, x0, around # infinite loop                   38        00208663
       add  x9, x7, x5     # shouldn't execute               3C        0104A933
       jal  x5, end        # x9 = x2 + 9                     44        0032A833
end:    add x0, x2, x9     # [100] = 25                      48        00218823
done:   beq x2, x0, done   # infinite loop                   50        0012063
