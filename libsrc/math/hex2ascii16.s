
	.export		hex2ascii16

	.include	"ndk.inc"

.segment	"MATH_CODE"

;===============================================================
;		hex2ascii10(char a)
;---------------------------------------------------------------
;  << Summary >>
;	1[Byte]の数値を、16進数のASCII文字列に変換します。
;  << Input >>
;	A	NUM	（00～FF まで対応）
;  << Output >>
;	A		下の桁
;	X		上の桁
;  << Modifies >>
;	A X Y
;===============================================================
.proc	hex2ascii16

	pha
	lsr	a
	lsr	a
	lsr	a
	lsr	a
	cmp	#10
	bcc	@L1
	adc	#$36	;cy=`H'
	bne	@L2
@L1:	ora	#$30
@L2:	tax

	pla
	and	#$0F
	cmp	#10
	bcc	@L3
	adc	#$36	;cy=`H'
	bne	@L4
@L3:	ora	#$30
@L4:
	rts
.endproc

