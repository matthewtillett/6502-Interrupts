!to "interrupt.prg",cbm

*=$0801
!by $0c,$08,$0a,$00,$9e,$32,$30,$36,$34,$00,$00,$00,$00
*=$0810


; Clear all registers
  lda #00
  tay
  tax

; Turn off interrupts
  sei

; Disable CIA I, CIA II
  ldy #$7f  ; $7f = 01111111
  sty $dc0c
  sty $dc0d

; Enable raster interupts
  lda #$01
  sta $d01a

; Setup interrupt handler
  lda #<irq
  ldx #>irq
  sta $314
  stx $315

; Trigger interrupt to fire on raster line
  lda #$00
  sta $d012

; ???
  lda $d011
  and #$7f
  sta $d011

; Clear interrupt disable flag (enable)
  cli

; Infinite loop
loop:
  jmp loop


; Interrupt code
irq:
  dec $d019 ; Acknowledge IRQ

  ; ---
loop2:
  inc $d021
  ldx $d021
  cpx #$00
  bne loop2
  ldx #$00
  stx $d021
  ;inc $d021 ; increase background colour
  ;ldx $d021 ; load background colour in to X register
  ;ldx #00
  stx $0400 ; output to screen 0,0
  ; ---

  jmp $ea81 ; Return to kernal