!to "hiscore.prg",cbm

*=$0801
!by $0c,$08,$0a,$00,$9e,$32,$30,$36,$34,$00,$00,$00,$00
*=$0810

; ==[ GLOBAL VARIABLES ]========================================================
      score_numbers = 6

; ==[ INITIALISATION ]==========================================================

      jsr init_p1_score

; --[ main loop ]--
main_loop:
      jsr enemy1_hit
      jsr print_score


      lda #1
      sta $0409

      ;lda p1_score+6
      ;sta $0420

      rts


; ==[ SUBROUTINES ]=============================================================

; --[ clear player 1 score ]--
init_p1_score:
      ldy #0
      lda #0

score_loop:
      sta p1_score,y
      iny
      cpy #score_numbers
      bne #score_loop
      rts


; -- output score to screen --
print_score:
      ldx #0
score_out_loop:
      lda p1_score, x
      tay
      lda string_numbers, y
      sta $0400, x
      inx
      cpx #score_numbers
      bne score_out_loop
      rts


; -- enemy hit score points --
enemy1_hit:
      lda p1_score+4  ; get digit value
      clc             ; clear carry flag to stop addind to itself, then adding new value: (A += A) + A
      adc #05         ; add points to digit
      sta p1_score+4
      rts


; ==[ ALLOCATED MEMORY ]========================================================

; --[ player 1 score data ]--
p1_score:
!fill score_numbers,0

string_numbers:
!scr "0123456789",0



      