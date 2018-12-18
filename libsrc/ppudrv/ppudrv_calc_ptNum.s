
	.export		ppudrv_calc_ptNum

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	int	ppudrv_calc_ptNum(char r2, char r3);
;---------------------------------------------------------------
;	Summary :		���W(r2,r3)����AVRAM�A�h���X�����߂܂��B
;				�iax = 0x2000 + (r3<<5) + r2�j
;
;	Arguments :	__r2	x���W ( 00-1F)
;			__r3	y���W (	00-1D:page 0 / 20-3D:page 1 /
;				...	40-5D:page 2 / 60-7D:page 3 )
;
;	Return :	AX	PPU VRAM Address
;
;	Modifies :	A X __r2-3
;
;	Useage :		�l�[���e�[�u���̃A�h���X�v�Z�p�ł�
;===============================================================
.proc	ppudrv_calc_ptNum

	lda	#$00

	lsr	__r3		;
	ror	a		;
	lsr	__r3		;
	ror	a		;
	lsr	__r3		;
	ror	a		;

	adc	__r2		;�� c �͊m����`0'
	sta	__r2		;
	lda	__r3		;
	adc	#$20		;
	tax			;
	lda	__r2		;ax <= VRAM�A�h���X

	rts
.endproc
