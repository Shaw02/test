
	.export		jsr_axy

	.import		Bank_Change_Prg

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	jsr_axy(ax,y);
;---------------------------------------------------------------
;	Summary :		�o���N�ԃT�u���[�`���R�[��
;	Arguments :	ax	�Ăяo����T�u���[�`���� Address
;			y	�Ăяo����T�u���[�`���� Bank
;	Return :	None
;	Modifies :	axy
;	Useage :		
;	Note:			
;===============================================================
.proc	jsr_axy

	STAX	_JMP_Address

	lda	__MMC3_Pbank0
	pha
	lda	__MMC3_Pbank1
	pha

	tya
	jsr	Bank_Change_Prg

	jsr	jmp_Func

	pla
	lda	__MMC3_Pbank1
	pla
	lda	__MMC3_Pbank0

	rts

.endproc

.proc	jmp_Func
	jmp	(_JMP_Address)
.endproc
