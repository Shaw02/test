
	.export	MUL

	.import	MUL_TABLE_L
	.import	MUL_TABLE_H

	.include	"ndk.inc"

.segment	"MATH_CODE"
;===============================================================
;	unsigned int	MUL(unsigned char a, unsigned char x);
;---------------------------------------------------------------
;	Summary :		高速符号無し乗算（ AX = A * X ）
;
;	Arguments :	A	unsigned char num1   ( 8[bit])
;			X	unsigned char num2   ( 8[bit])
;
;	Return :	AX	unsigned int  result (16[bit])
;
;	Modifies :	A X Y __r0 - __r2
;
;	Useage :		
;
;	Note		1024[Byte]のテーブル（MUL_TABLE.s）を使用します。
;===============================================================
.proc	MUL

	sta	__r0
	stx	__r2

Plus:
	add	__r2	;A = num1 + num2
	tax
	bcs	@C
	lda	MUL_TABLE_L,x
	ldy	MUL_TABLE_H,x
	bcc	@E
@C:
	lda	MUL_TABLE_L + 256,x
	ldy	MUL_TABLE_H + 256,x
@E:
	tax	;XY <= POWER((A + X),2) / 4


Minus:
	lda	__r0
	stx	__r0
	sub	__r2
	bcs	@C
	eor	#$FF
	adc	#1	
@C:
	tax		;X = ABS(num1 - num2)
	lda	__r0
	sub	MUL_TABLE_L,x
	sta	__r0
	tya
	sbc	MUL_TABLE_H,x
	tax		;AX = (POWER((num1 + num2),2)/4) - (POWER(ABS(num1 - num2),2)/4)
	lda	__r0	;   = num1 * num2

	rts
.endproc
