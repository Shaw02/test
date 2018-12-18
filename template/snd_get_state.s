
	.export		snd_get_state

	.include	"nsd.inc"

;===============================================================
;		Get Sound State
;---------------------------------------------------------------
;  << Summary >>
;	Get the state of Music and SE
;  << Input >>
;	None
;  << Output >>
;	A	bit 0	BGM Status (0:Stop / 1:Play)
;		bit 1	SE  Status (0:Stop / 1:Play)
;  << Modifies >>
;	A X Y
;===============================================================
.proc	snd_get_state

BGM_Check:
	lda	#0
	ldx	#nsd::TR_BGM1

LOOP_BGM:
	ora	__Sequence_ptr + 1,x
	inx
	inx
	cpx	#nsd::TR_BGM1 + nsd::BGM_Track * 2
	bcc	LOOP_BGM

	cmp	#$00
	beq	@L
	lda	#$01
@L:	pha


SE_Check:
	lda	#0
	ldx	#nsd::TR_SE1
LOOP_SE:
	ora	__Sequence_ptr + 1,x
	inx
	inx
	cpx	#nsd::TR_SE1 + nsd::SE_Track * 2
	bcc	LOOP_SE

	tax
	pla
	cpx	#$00
	beq	@L
	ora	#$02
@L:
	rts
.endproc

