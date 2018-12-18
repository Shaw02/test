
	.export		ppudrv_set_NameTable2

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_NameTable2(void);
;---------------------------------------------------------------
;	Summary :		���ځA�l�[���������e�[�u���֓]�����܂��B
;
;	Arguments :	AX	�]�����l�[���e�[�u���̃|�C���^
;			Y	�]����X�N���[��(0:page0 / 1:page1 / 2:page2 / 3:page3)
;
;	Return :	none	
;
;	Modifies :	A X Y __r0-1
;
;	Useage :		�Ăяo���O�ɗ\��PPU�̃����_�����O��off�ɂ��Ă��������B
;===============================================================
.proc	ppudrv_set_NameTable2

	STAX	__r0

	;-----------------------
	;VRAM Address �ݒ�
	tya				;
	and	#$03
	asl				;�i��Ɍv�Z���Ă����j
	asl				;
	ora	#$20			;a <= VRAM Address MSB
	sta	PPU_VRAM_ADDR2
	lda	#0
	sta	PPU_VRAM_ADDR2

	;-----------------------
	;VRAM �]��
	ldx	#4
	ldy	#0
LOOP:
	lda	(__r0),y
	sta	PPU_VRAM_IO
	iny
	bne	LOOP

	inc	__r0 + 1
	dex
	bne	LOOP


	rts
.endproc

