!to "test.prg",cbm

*=$0801
!by $0c,$08,$0a,$00,$9e,$32,$30,$36,$34,$00,$00,$00,$00
*=$0810


  lda #04
  sta value

  lda #00

  lda value

  ldx <value
  ldy >value

  rts

;.align 256
value: