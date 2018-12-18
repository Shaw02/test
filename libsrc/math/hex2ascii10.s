
	.export		hex2ascii10

	.include	"ndk.inc"

.segment	"MATH_CODE"

;===============================================================
;		hex2ascii10(char a)
;---------------------------------------------------------------
;  << Summary >>
;	1[Byte]の数値を、10進数のASCII文字列に変換します。
;  << Input >>
;	A	NUM	（0～99 まで対応）
;  << Output >>
;	A		下の桁
;	X		上の桁
;  << Modifies >>
;	A X Y
;===============================================================
.proc	hex2ascii10

;
;	２分岐で割り算をする。
;

L00:	;-------------------
	cmp	#40
	bcs	L40
	cmp	#20
	bcs	L20
	cmp	#10
	bcs	L10

	ldx	#$30
	bne	L
L10:	;-------------------
	sub	#10
	ldx	#$31
	bne	L
L20:	;-------------------
	cmp	#30
	bcs	L30

	sub	#20
	ldx	#$32
	bne	L
L30:	;-------------------
	sub	#30
	ldx	#$33
	bne	L
L40:	;-------------------
	cmp	#70
	bcs	L70
	cmp	#50
	bcs	L50

	sub	#40
	ldx	#$34
	bne	L
L50:	;-------------------
	cmp	#60
	bcs	L60

	sub	#50
	ldx	#$35
	bne	L
L60:	;-------------------
	sub	#60
	ldx	#$36
	bne	L

L70:	;-------------------
	cmp	#90
	bcs	L90
	cmp	#80
	bcs	L80

	sub	#70
	ldx	#$37
	bne	L
L80:	;-------------------
	sub	#80
	ldx	#$38
	bne	L

L90:	;-------------------
	sub	#99
	bcc	L99
	lda	#99
L99:
	ldx	#$39

L:	;-------------------
	ora	#$30

	rts
.endproc

