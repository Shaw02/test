
	.export	IMUL

	.import	MUL_TABLE_L
	.import	MUL_TABLE_H

	.include	"ndk.inc"

.segment	"MATH_CODE"
;===============================================================
;	signed int	IMUL(signed char a, signed char x);
;---------------------------------------------------------------
;	Summary :		高速符号付き乗算（ AX = A * X ）
;
;	Arguments :	A	signed char num1   ( 8[bit])
;			X	signed char num2   ( 8[bit])
;
;	Return :	AX	signed int  result (16[bit])
;
;	Modifies :	A X Y __r0 - __r3
;
;	Useage :		
;
;	Note		1024[Byte]のテーブル（MUL_TABLE.s）を使用します。
;===============================================================
.proc	IMUL

	sta	__r0
	ldy	#0
	cmp	#0
	bpl	@L
	dey
@L:	sty	__r1	;__r0 ～ __r1 … num1(sword)

	stx	__r2

Plus_AB:
	cpx	#0
	bmi	@L00
	add	__r2
	bcc	@L01
	iny
	jmp	@L01
@L00:			;xが負数の場合
	add	__r2
	beq	M256	;加算結果が -256の場合
	bcs	@L01	;
	dey
@L01:
	cpy	#0
	beq	@L02
	eor	#$FF
	add	#1	;a = ABS(num1 + num2)
@L02:
	sta	__r3



Minus_AB:
	lda	__r0
	ldy	__r1
	cpx	#0
	bmi	@L00
	sub	__r2
	bcs	@L01
	dey
	jmp	@L01
@L00:
	sub	__r2
	bcc	@L01
	iny
@L01:
	cpy	#0
	beq	@L02
	eor	#$FF
	add	#1	;a = ABS(num1 - num2)
@L02:
	tay



Get_MUL:
	ldx	__r3
	lda	MUL_TABLE_L,x
	sub	MUL_TABLE_L,y
	sta	__r3

	lda	MUL_TABLE_H,x
	sbc	MUL_TABLE_H,y
	tax		;AX = (POWER(ABS(num1 + num2),2)/4) - (POWER(ABS(num1 - num2),2)/4)
	lda	__r3	;   = num1 * num2

	rts

M256:	;-128(0x80) * -128(0x80) = 16384 (0x4000)
	LDAX	#$4000
	rts

.endproc

