
	.export		ppudrv_set_palette2

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_palette2(void);
;---------------------------------------------------------------
;	Summary :		���ځA�p���b�g��ݒ肵�܂��B
;
;	Arguments :	AX	pointer of palette data (16Byte�̔z��)
;			Y	$00 = palette 1
;				$01 = palette 2
;
;	Return :	none	
;
;	Modifies :	A X Y __r0-1
;
;	Useage :		�Ăяo���O�ɗ\��PPU�̃����_�����O��off�ɂ��Ă��������B
;===============================================================
.proc	ppudrv_set_palette2

	STAX	__r0

	;-----------------------
	;VRAM Address �ݒ�
	lda	#$3F
	sta	PPU_VRAM_ADDR2

	tya
	and	#$01
	asl	a
	asl	a
	asl	a
	asl	a
	sta	PPU_VRAM_ADDR2

	;-----------------------
	;VRAM �]��
	ldx	#$10
	ldy	#$00
LOOP:
	lda	(__r0),y
	sta	PPU_VRAM_IO
	iny
	dex
	bne	LOOP

	rts
.endproc

