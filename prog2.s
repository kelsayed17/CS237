*----------------------------------------------------------------------
* Programmer: Khaled Elsayed
* Class Account: cssc0672
* Assignment or Title: Program 2
* Filename: prog2.s
* Date completed: 10/26/2016
*----------------------------------------------------------------------
* Problem statement: Solve the given polynomial and display answer
* Input: None
* Output: Answer to the given polynomial
* Error conditions tested: None
* Included files: prog2.s, datafile.s
* Method and/or pseudocode:
* References: Riggins CS-237 Reader
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
* See comments below
*
*----------------------------------------------------------------------
*
a:      EQU     $6000           * datafile reference
b:      EQU     $6002
c:      EQU     $6004
d:      EQU     $6006
e:      EQU     $6008
f:      EQU     $600A
x:      EQU     $600C
y:      EQU     $600E
z:      EQU     $6010
start:  initIO                  * Initialize (required for I/O)
        setEVT                  * Error handling routines
*       initF                   * For floating point macros only

        lineout title
        lineout skipline

        ** D1 = aX^3
        move.w  x,D1            * D1 = 00000002
        muls    x,D1            * D1 = 00000004
        muls    x,D1            * D1 = 00000008
        muls    a,D1            * D1 = 00000010

        ** D2 = 2bY^3
        move.w  y,D2            * D2 = 00000003
        muls    y,D2            * D2 = 00000009
        muls    y,D2            * D2 = 0000001B
        muls    b,D2            * D2 = 00000051
        muls    #2,D2           * D2 = 000000A2

        ** D3 = cZ^2
        move.w  z,D3            * D3 = 00000008
        muls    z,D3            * D3 = 00000040
        muls    c,D3            * D3 = 00000100

        ** D4 = dX^2Y
        move.w  x,D4            * D4 = 00000002
        muls    x,D4            * D4 = 00000004
        muls    y,D4            * D4 = 0000000C
        muls    d,D4            * D4 = 0000003C

        ** D1 = D1 + D2 + D3 - D4
        add.w   D2,D1           * D1 = 000000B2
        add.w   D3,D1           * D1 = 000001B2
        sub.w   D4,D1           * D1 = 00000176

        ** D2 = dX^2
        move.w  x,D2            * D2 = 00000002
        muls    x,D2            * D2 = 00000004
        muls    d,D2            * D2 = 00000014

        ** D3 = eY^2
        move.w  y,D3            * D3 = 00000003
        muls    y,D3            * D3 = 00000009
        muls    e,D3            * D3 = 00000036

        ** D4 = fXb
        move.w  x,D4            * D4 = 00000002
        muls    b,D4            * D4 = 00000006
        muls    f,D4            * D4 = 0000002A

        ** D2 = D2 + D3 + D4
        add.w   D3,D2           * D2 = 0000004A
        add.w   D4,D2           * D2 = 00000074

        ** D3 = 3Z^2
        move.w  z,D3            * D3 = 00000008
        muls    z,D3            * D3 = 00000040
        muls    #3,D3           * D3 = 000000C0

        ** D4 = 2ad
        move.w  a,D4            * D4 = 00000002
        muls    d,D4            * D4 = 0000000A
        muls    #2,D4           * D4 = 00000014

        ** D3 = D3 - D4
        sub.w   D4,D3           * D3 = 000000AC

        ** D1 = D1 / D2
        ext.l   D1              * D1 = 00000176
        divs    D2,D1           * D1 = 001A0003
        ext.l   D1              * D1 = 00000003

        ** D1 = D1 + D3
        add.w   D3,D1           * D1 = 000000AF

        ** D1 = D1 % 100
        ext.l   D1              * D1 = 000000AF
        divs    #100,D1         * D1 = 004B0001
        swap    D1              * D1 = 0001004B
        ext.l   D1              * D1 = 0000004B
        move.w  D1,D0

        ** Output
        cvt2a   answer,#6       * '000075' 30 30 30 30 37 35
        stripp  answer,#6       * '750075' 37 35 30 30 37 35
        lea     answer,A1
        adda.l  D0,A1
        clr.b   (A1)            * '75'     37 35 00 30 37 35
        lineout output

        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:          dc.b    '* Program #2, Khaled Elsayed, cssc0672 *',0
skipline:       dc.b    0
output:         dc.b    'The answer is: '
answer:         ds.b    10
        end