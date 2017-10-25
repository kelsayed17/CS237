*----------------------------------------------------------------------
* Programmer: Khaled Elsayed
* Class Account: cssc0672
* Assignment or Title: Program 4
* Filename: fib.s
* Date completed: 12/12/2016
*----------------------------------------------------------------------
* Problem statement: N/A
* Input: N/A
* Output: N/A
* Error conditions tested: N/A
* Included files: prog4.s fib.s
* Method and/or pseudocode: N/A
* References: Riggins Reader
*----------------------------------------------------------------------
        ORG     $7000           * Start at location 7000 Hex
fib:    link    A6,#0           * Push old A6 onto stack
        movem.l D1/D2,-(SP)     * Push registers onto stack

        move.w  8(A6),D1        * n -> D1

        cmpi.w  #0,D1
        bne     elif            * if (n != 0)
        move.w  #0,D0           * return 0
        bra     if              * if (n == 0)

elif:   cmpi.w  #1,D1
        bne     else            * if (n != 1)
        move.w  #1,D0           * return 1
        bra     if              * if (n == 1)

else:   move.w  D1,D2           * n -> D2

        subq.w  #1,D2           * n - 1 -> D2
        move.w  D2,-(SP)        * Push parameter onto stack
        jsr     fib             * Recursion
        adda.l  #2,SP           * Pop parameter off stack

        move.w  D0,D1

        subq.w  #1,D2           * n - 2 -> D2
        move.w  D2,-(SP)        * Push parameter onto stack
        jsr     fib             * Recursion
        adda.l  #2,SP           * Pop parameter off stack

        add.w   D1,D0           * fib(n - 1) + fib(n - 2)

if:     movem.l (SP)+,D1/D2     * Pop registers off stack
        unlk    A6              * Pop old A6 off stack
        rts                     * Pop return address off stack
        end