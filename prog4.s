*----------------------------------------------------------------------
* Programmer: Khaled Elsayed
* Class Account: cssc0672
* Assignment or Title: Program 4
* Filename: prog4.s
* Date completed: 12/12/2016
*----------------------------------------------------------------------
* Problem statement: Calculate a given Fibonacci number
* Input: User inputted integer
* Output: Fibonacci number of input
* Error conditions tested: N/A
* Included files: prog4.s fib.s
* Method and/or pseudocode: N/A
* References: Riggins Reader
*----------------------------------------------------------------------
*
        ORG     $0
        DC.L    $3000           * Stack pointer value after a reset
        DC.L    start           * Program counter value after a reset
        ORG     $3000           * Start at location 3000 Hex
*
*----------------------------------------------------------------------
*
#minclude /home/cs/faculty/riggins/bsvc/macros/iomacs.s
#minclude /home/cs/faculty/riggins/bsvc/macros/evtmacs.s
*
*----------------------------------------------------------------------
*
* Register use
*
*----------------------------------------------------------------------
*
fib:    equ     $7000           * fib.s
start:  initIO                  * Initialize (required for I/O)
        setEVT                  * Error handling routines
*       initF                   * For floating point macros only

        lineout title
        lineout skipline
        lineout prompt
        linein  buffer
        stripp  buffer,D0
        cvta2   buffer,D0

        move.w  D0,-(SP)        * Push parameter onto stack
        jsr     fib             * Jump to subroutine
        adda.l  #2,SP           * Pop parameter off stack

        cvt2a   buffer,#4
        stripp  buffer,#4
        lea     buffer,A1
        adda.l  D0,A1           * Sets A1 to end of string
        clr.b   (A1)            * Terminates the string

        lineout skipline
        lineout output

        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:          dc.b    '* Program #4, Khaled Elsayed, cssc0672 *',0
prompt:         dc.b    'Enter a number:',0
skipline:       dc.b    0
output:         dc.b    'The fibonacci number is '
buffer:         ds.b    80
        end