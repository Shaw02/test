
	.export		BG_Load

	.import		ppudrv_set_NameTable
	.import		ppudrv_set_NameTable2
	.import		ppudrv_set_palette
	.import		ppudrv_set_palette2

	.import		Bank_Change_Prg
	.import		Bank_Change_Prg2

	.include	"ndk.inc"
	.include	"define.inc"


;===============================================================
;	�a�f�f�[�^�̏��
;---------------------------------------------------------------
.rodata

;
;	���l�[���e�[�u���ƁA�p���b�g���́A�����o���N�ɂ����Ă��������B
;

;-------------------------------
;�l�[���e�[�u���̃I�t�Z�b�g�A�h���X
BG_TBL_Offset:
	.addr	0					; 00h



;-------------------------------
;�p���b�g���̃I�t�Z�b�g�A�h���X
BG_PAL_Offset:
	.addr	0					; 00h



;-------------------------------
;�X�v���C�g���̃I�t�Z�b�g�A�h���X
; -1 ��
BG_SPR_Offset:
	.addr	$FFFF					; 00h



;-------------------------------
;�l�[���e�[�u���̃o���N
BG_BNK:
	;	PRG			CHR
;	.byte	<PBNK_NameTable0,	<CBNK_ASCII	; 00h



;===============================================================
;	void	BG_Load(char no);
;---------------------------------------------------------------
;	Summary :		BG Display
;	Arguments :	A	BG number
;	Return :		None
;	Modifies :	A X Y __r0
;	Useage :		�w��̉�ʂ�\�����܂��B
;	Note			���̊֐��́A��ʃA�h���X�ɔz�u���܂��B
;				��0x8000-0xBFFF�̃o���N��؂�ւ��邽�߁B
;===============================================================
.code
.proc	BG_Load

	asl
	sta	__r0

	;---------------
	;Bank Save
	lda	__MMC3_Pbank0
	pha
	lda	__MMC3_Pbank1
	pha			;���݂̃o���N��ޔ�

Bank_Change_PRG:
	ldy	__r0
	lda	BG_BNK + 0,y
	jsr	Bank_Change_Prg

	;-----------------------
	;�\��������
	DISP_OFF

	;---------------
	;Bank Change
Bank_Change_CHR:
	ldy	__r0
	ldx	BG_BNK + 1,y
	stx	__PPUDRV_Cbank0
	inx
	inx
	stx	__PPUDRV_Cbank1

	;---------------
	;Set name table
	lda	BG_PAL_Offset,y
	pha
	lda	BG_PAL_Offset + 1,y
	pha

Set_NameTable:
	lda	BG_TBL_Offset + 0,y
	ldx	BG_TBL_Offset + 1,y
	ldy	#0
	jsr	ppudrv_set_NameTable2	; �� __r0-1 �j��

	;---------------
	;Set pallete
Set_Pallete:
	pla
	tax
	pla
	ldy	#0
	jsr	ppudrv_set_palette2	; �� __r0-1 �j��

Exit:
	;-----------------------
	;�\����߂�
	DISP_RET

	;---------------
	;Bank�����ɖ߂�
	pla
	tax
	pla
	jsr	Bank_Change_Prg2

	rts
.endproc

