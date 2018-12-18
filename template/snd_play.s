
	.export		snd_play

	.import		Bank_Change_Prg
	.import		Bank_Change_Prg2

	.include	"ndk.inc"
	.include	"define.inc"

;===============================================================
;	�ȃf�[�^�̏��
;---------------------------------------------------------------

.rodata
	.import		_MUS00_DPCMinfo
	.import		_MUS00_BGM0

	.import		_SE_SE0
	.import		_SE_SE1



;-------------------------------
;�ȃf�[�^������A�h���X
BGM_TBL_Offset:
	.addr	_MUS00_BGM0		;00h	�I�[�v�j���O


;-------------------------------
;�ȃf�[�^������o���N�i�Z�O�����g�j
BGM_TBL_Segment:
	;	�Ȃ̃o���N	��PCMinfo�\���́iBGM_TBL_DPCMinfo�j
	.byte	<PBNK_MUS0,	0	;00h	�I�[�v�j���O


;-------------------------------
;��PCM info�\���̂�����A�h���X�i�e�o���N�j
BGM_TBL_DPCMinfo:	
	.addr	_MUS00_DPCMinfo		;00h 


;-------------------------------
SE_TBL_Offset:
	.addr	_SE_SE0			;00h	�J�[�\��
	.addr	_SE_SE1			;00h	�J�[�\��


;-------------------------------
SE_TBL_Segment:
	.byte	<PBNK_SE,	0	;00h	����
	.byte	<PBNK_SE,	0	;01h	�J�[�\��



;===============================================================
;	void	snd_play(char no);
;---------------------------------------------------------------
;	Summary :		Start play bgm
;	Arguments :	A	Number (BGM:00h- / SE:80h- )
;	Return :		None
;	Modifies :	A X Y __r0
;	Useage :		�a�f�l�^���ʉ����Đ����鎞�ɌĂт܂��B
;===============================================================
.code
.proc	snd_play

	;---------------
	;save BGM/SE number
	tay

	;---------------
	;Sound Drv ���荞�ݖ�����
	lda	__flag
	ora	#nsd_flag::Disable
	sta	__flag

	;---------------
	;Bank Save
	lda	__MMC3_Pbank0
	pha
	lda	__MMC3_Pbank1
	pha			;���݂̃o���N��ޔ�

	;---------------
	;calc BGM/SE number
	tya
	asl
	tay
	sta	__r0
	bcs	SE



BGM:	;=======================

	;---------------
	;Bank Change
	lda	BGM_TBL_Segment,y
	sta	__MusBank	;�o���N number
	jsr	Bank_Change_Prg


	;---------------
	;��PCM�̐ݒ�
	ldy	__r0
	lda	BGM_TBL_Segment + 1,y
	bmi	@nodpcm

	asl
	tay
	lda	BGM_TBL_DPCMinfo + 0, y
	ldx	BGM_TBL_DPCMinfo + 1, y
	jsr	_nsd_set_dpcm

@nodpcm:

	;---------------
	;�Đ�
	ldy	__r0
	lda	BGM_TBL_Offset + 0, y
	ldx	BGM_TBL_Offset + 1, y
	jsr	_nsd_play_bgm
	jmp	Exit



SE:	;=======================

	;---------------
	;Bank Change
	lda	SE_TBL_Segment,y
	sta	__SeBank	;�o���N number
	jsr	Bank_Change_Prg

	;---------------
	;�Đ�
	ldy	__r0
	lda	SE_TBL_Offset + 0, y
	ldx	SE_TBL_Offset + 1, y
	jsr	_nsd_play_se



Exit:	;=======================

	;---------------
	;Bank�����ɖ߂�
	pla
	tax
	pla
	jsr	Bank_Change_Prg2

	;---------------
	;Sound Drv ���荞�ݗL����
	lda	__flag
	and	#<~nsd_flag::Disable
	sta	__flag

	rts
.endproc
