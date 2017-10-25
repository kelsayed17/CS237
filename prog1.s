*----------------------------------------------------------------------
* Programmer: Khaled Elsayed
* Class Account: cssc0672
* Assignment or Title: Program 1
* Filename: prog1.s
* Date completed: 10/11/2016
*----------------------------------------------------------------------
* Problem statement: Calculate user's age in 2016
* Input: Date of Birth (MM/DD/YYYY)
* Output: User's age in the year 2016
* Error conditions tested: None
* Included files: None
* Method and/or pseudocode: None
* References: None
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
* D0 is used for macros and holds result of 2016 - year born
* D1 holds 2016
* A0 holds address of age
* A1 holds address of stars+35
*
*----------------------------------------------------------------------
*
start:  initIO                  * Initialize (required for I/O)
        setEVT                  * Error handling routines
*       initF                   * For floating point macros only
        lineout         title
        lineout         skipline
        lineout         prompt
        linein          buffer          * Get input
        cvta2           buffer+6,#4     * Macro reads from D0
        move.w          #2016,D1
        sub.w           D0,D1
        move.w          D1,D0
        cvt2a           age,#3          * Macro reads from D0
        stripp          age,#3          * Length of string is returned to D0
        lea             age,A0          * Put address of age in A0
        adda.l          D0,A0           * Increments A0 by amount in D0
        move.b          #' ',(A0)+
        move.b          #'y',(A0)+
        move.b          #'e',(A0)+
        move.b          #'a',(A0)+
        move.b          #'r',(A0)+
        move.b          #'s',(A0)+
        move.b          #' ',(A0)+
        move.b          #'o',(A0)+
        move.b          #'l',(A0)+
        move.b          #'d',(A0)+
        move.b          #'.',(A0)+
        move.b          #' ',(A0)+
        move.b          #'*',(A0)+
        clr.b           (A0)            * Insert 0 byte at end of string
        lea             stars+35,A1
        adda.l          D0,A1
        clr.b           (A1)            * Insert 0 byte at end of string
        lineout         stars
        lineout         display
        lineout         stars
        move.b          #'*',(A1)       * Replaces the '*' that becomes null


        break                   * Terminate execution
*
*----------------------------------------------------------------------
*       Storage declarations
title:          dc.b    'Program #1, Khaled Elsayed, cssc0672',0
prompt:         dc.b    'Enter your date of birth (MM/DD/YYYY):',0
skipline:       dc.b    0
buffer:         ds.b    82
display:        dc.b    '* In 2016 you will be '
age:            ds.b    82
stars:          dcb.b   40,'*'
        end