
	.export		ppudrv_set_NameTable2

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_NameTable2(void);
;---------------------------------------------------------------
;	Summary :		直接、ネーム＆属性テーブルへ転送します。
;
;	Arguments :	AX	転送元ネームテーブルのポインタ
;			Y	転送先スクリーン(0:page0 / 1:page1 / 2:page2 / 3:page3)
;
;	Return :	none	
;
;	Modifies :	A X Y __r0-1
;
;	Useage :		呼び出し前に予めPPUのレンダリングはoffにしてください。
;===============================================================
.proc	ppudrv_set_NameTable2

	STAX	__r0

	;-----------------------
	;VRAM Address 設定
	tya				;
	and	#$03
	asl				;（先に計算しておく）
	asl				;
	ora	#$20			;a <= VRAM Address MSB
	sta	PPU_VRAM_ADDR2
	lda	#0
	sta	PPU_VRAM_ADDR2

	;-----------------------
	;VRAM 転送
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

