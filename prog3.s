*----------------------------------------------------------------------
* Programmer: Khaled Elsayed
* Class Account: cssc0672
* Assignment or Title: Program 3
* Filename: prog3.s
* Date completed: 11/14/2016
*----------------------------------------------------------------------
* Problem statement:
* Input: User inputted integer
* Output: Roman numeral conversion
* Error conditions tested: digit length, invalid characters, number range
* Included files: prog3.s
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
start:  initIO                  * Initialize (required for I/O)
        setEVT                  * Error handling routines
*       initF                   * For floating point macros only

        lineout title
        lineout skipline
        bra     begin
bad:
        lineout skipline
        lineout invalid
begin:
        lineout prompt
        linein  buffer
        stripp  buffer,D0
        lea     buffer,A0

        cmpi.b  #4,D0
        bhi     bad             * Check if length > 4
        move.l  D0,D1
        tst.w   D1
        beq     bad             * Check if length == 0
        subq.w  #1,D1           * Decrement length by 1
check:
        cmpi.b  #'0',(A0)
        blo     bad             * Check if ascii character < 0
        cmpi.b  #'9',(A0)+
        bhi     bad             * Check if ascii character > 9
        dbra    D1,check

        cvta2   buffer,D0       * Convert to 2's compliment

        cmpi.l  #1,D0
        blo     bad             * Check if number < 1
        cmpi.l  #3999,D0
        bhi     bad             * Check if number > 3999

        lea     answer,A1
one_thou
        cmpi.l  #1000,D0
        blt     nine_hun
        move.b  #'M',(A1)+
        sub.l   #1000,D0
        bra     one_thou
nine_hun:
        cmpi.l  #900,D0
        blt     five_hun
        move.b  #'C',(A1)+
        move.b  #'M',(A1)+
        sub.l   #900,D0
        bra     nine_hun
five_hun:
        cmpi.l  #500,D0
        blt     four_hun
        move.b  #'D',(A1)+
        sub.l   #500,D0
        bra     five_hun
four_hun:
        cmpi.l  #400,D0
        blt     one_hun
        move.b  #'C',(A1)+
        move.b  #'D',(A1)+
        sub.l   #400,D0
        bra     four_hun
one_hun:
        cmpi.l  #100,D0
        blt     ninety
        move.b  #'C',(A1)+
        sub.l   #100,D0
        bra     one_hun
ninety:
        cmpi.l  #90,D0
        blt     fifty
        move.b  #'X',(A1)+
        move.b  #'C',(A1)+
        sub.l   #90,D0
        bra     ninety
fifty:
        cmpi.l  #50,D0
        blt     forty
        move.b  #'L',(A1)+
        sub.l   #50,D0
        bra     fifty
forty:
        cmpi.l  #40,D0
        blt     ten
        move.b  #'X',(A1)+
        move.b  #'L',(A1)+
        sub.l   #40,D0
        bra     forty
ten:
        cmpi.l  #10,D0
        blt     nine
        move.b  #'X',(A1)+
        sub.l   #10,D0
        bra     ten
nine:
        cmpi.l  #9,D0
        blt     five
        move.b  #'I',(A1)+
        move.b  #'X',(A1)+
        sub.l   #9,D0
        bra     nine
five:
        cmpi.l  #5,D0
        blt     four
        move.b  #'V',(A1)+
        subq.l  #5,D0
        bra     five
four:
        cmpi.l  #4,D0
        blt     one
        move.b  #'I',(A1)+
        move.b  #'V',(A1)+
        subq.l  #4,D0
        bra     four
one:
        cmpi.l  #1,D0
        blt     done
        move.b  #'I',(A1)+
        subq.l  #1,D0
        bra     one
done:
        clr.b   (A1)
        lineout skipline
        lineout output
redo:
        lineout skipline
        lineout reprompt
        linein  buffer
        lea     buffer,A2

        cmpi.b  #'Y',(A2)
        beq     begin           * Check if ascii character == 'Y'
        cmpi.b  #'y',(A2)
        beq     begin           * Check if ascii character == 'y'
        cmpi.b  #'N',(A2)
        beq     finish          * Check if ascii character == 'N'
        cmpi.b  #'n',(A2)
        bne     redo            * Check if ascii character != 'n'
finish:
        lineout final
        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:          dc.b    '* Program #3, Khaled Elsayed, cssc0672 *',0
prompt:         dc.b    'Enter a number in the range 1 . . 3999',0
buffer:         ds.b    80
invalid:        dc.b    'The number you entered is invalid,',0
reprompt:       dc.b    'Do you want to convert another number?',0
final:          dc.b    'Program terminated.',0
skipline:       dc.b    0
output:         dc.b    'The roman numeral equivalent is '
answer:         ds.b    80
        end