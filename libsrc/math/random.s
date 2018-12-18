
	.export		Randomize
	.export		Random

	.include	"ndk.inc"

;=======================================================================
;	Non Zeropage works
;-----------------------------------------------------------------------
.bss

_Rand:		.word	0

.segment	"MATH_CODE"

;===============================================================
;	void	Randomize();
;---------------------------------------------------------------
;	Summary :		クロサワ式乱数
;	Arguments :	AX	乱数の種
;	Return :	
;	Modifies :	
;	Useage :	
;	Note		
;===============================================================
.proc	Randomize

	STAX	_Rand
	rts

.endproc
;===============================================================
;	void	Random();
;---------------------------------------------------------------
;	Summary :		クロサワ式乱数
;	Arguments :	
;	Return :	AX	乱数
;	Modifies :	
;	Useage :	
;	Note		
;===============================================================
.proc	Random

	lda	_Rand + 1
	eor	#$96
	sta	_Rand + 1
	tax
	lda	_Rand
	eor	#$30
	sta	_Rand

	SUBW	#$6553
	STAX	_Rand

	lda	#0
	asl	_Rand
	rol	_Rand + 1
	rol	a
	asl	_Rand
	rol	_Rand + 1
	rol	a
	ora	_Rand
	sta	_Rand
	ldx	_Rand + 1

	rts
.endproc

