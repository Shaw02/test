
	.export		ppudrv_set_palette2

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_palette2(void);
;---------------------------------------------------------------
;	Summary :		直接、パレットを設定します。
;
;	Arguments :	AX	pointer of palette data (16Byteの配列)
;			Y	$00 = palette 1
;				$01 = palette 2
;
;	Return :	none	
;
;	Modifies :	A X Y __r0-1
;
;	Useage :		呼び出し前に予めPPUのレンダリングはoffにしてください。
;===============================================================
.proc	ppudrv_set_palette2

	STAX	__r0

	;-----------------------
	;VRAM Address 設定
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
	;VRAM 転送
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

