
	.export		ppudrv_init

	.import		ppudrv_main
	.import		ppudrv_clear
	.import		NMI_Set_Callback

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_init(void);
;---------------------------------------------------------------
;	Summary :		�o�o�t�h���C�o�[�����������܂��B
;	Arguments :	none	
;	Return :	none	
;	Modifies :	A X Y	
;	Useage :		��{�I�ɂ́A�d���������E���Z�b�g���ɂP�񂾂��Ăяo���܂�
;				�������́A���̊G��V�X�e������PPUDRV�ɖ߂��ۂɌĂяo���܂��B
;===============================================================
.proc	ppudrv_init

	;-----------------------
	;�R�[���o�b�N���ꎞ������
	LDAX	#0			;
	jsr	NMI_Set_Callback	;

	lda	#sysdef::PPU_Ctrl1_set	;���荞�݂͊J�n����B
	sta	PPU_CTRL1
	sta	__Flag_2000

	lda	#%00000000
	sta	PPU_CTRL2
	sta	__Flag_2001

	;-----------------------
	;Clear
	SPR_DMA_ON

	jsr	ppudrv_clear

	;-----------------------
	;MMC3 �o���N�̏�����
	lda	#$00			;CHR 0000-07FF
	sta	__PPUDRV_Cbank0		;
	lda	#$02			;CHR 0800-0FFF
	sta	__PPUDRV_Cbank1		;

	lda	#$00			;CHR 1000-13FF
	sta	__PPUDRV_Cbank2		;
	lda	#$01			;CHR 1400-17FF
	sta	__PPUDRV_Cbank3		;
	lda	#$02			;CHR 1800-1BFF
	sta	__PPUDRV_Cbank4		;
	lda	#$03			;CHR 1C00-1FFF
	sta	__PPUDRV_Cbank5		;

	;-----------------------
	lda	#sysdef::PPU_Ctrl2_set	;MMC3 IRQ�̏������̂��߂ɁA
	sta	__Flag_2001		;BG, Spr���ɕ\����on�ɂ���B
	sta	PPU_CTRL2		;

	STA	MMC3_IRQ_Disable	 ;MMC3 IRQ Disable
	lda	PPU_STATUS		;
	lda	#$10			;
	tax				;
@L:					;
	sta	PPU_VRAM_ADDR2		;PPU��A12�𓮂����āAMMC3�̃^�C�}�[������������B
	sta	PPU_VRAM_ADDR2		; �� �\����on�łȂ��ƁAPPU�̃A�h���X���C���������Ȃ��B
	eor	#$10			; �� �܂��ABG=0x0000, Spr=0x1000�̏�Ԃɂ��Ă����B
	dex				;
	bne	@L			;

	;-----------------------
	;�R�[���o�b�N�ݒ�
	LDAX	#ppudrv_main		;
	jsr	NMI_Set_Callback	;�R�[���o�b�N�̐ݒ�

	rts
.endproc

