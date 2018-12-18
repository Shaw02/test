
	.export		ppudrv_clear

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_clear(void);
;---------------------------------------------------------------
;	Summary :		ネーム＆属性テーブル、スプライトをクリアします。
;				ＢＧ、スプライト共に非表示にします。
;	Arguments :	none	
;	Return :	none	
;	Modifies :	A X Y	
;	Useage :		
;===============================================================
.proc	ppudrv_clear

	;-----------------------
	;Flag clear
	lda	#0
	sta	__PPUDRV_T0_Cnt
	sta	__PPUDRV_T1_Cnt
	sta	__PPUDRV_T2_Cnt
	sta	__PPUDRV_T3_Cnt
	sta	__PPUDRV_IRQ_Line
	sta	__PPUDRV_Scroll_x
	sta	__PPUDRV_Scroll_y

	;-----------------------
	;表示を消す
	DISP_OFF

	;-----------------------
	;Clear 0x2000 - 0x2FFF of PPU address
NameTable:
	ldy	#$20
	sty	PPU_VRAM_ADDR2
	lda	#$00
	sta	PPU_VRAM_ADDR2
	tax
	ldy	#$10
@L:	
	sta	PPU_VRAM_IO
	inx
	bne	@L
	dey
	bne	@L

	;-----------------------
	;Clear Sprite Buff
Sprite:
	ldx	#$00
@L:	
	lda	#$EF
	sta	_ppu_sprite_buff,x
	inx
	lda	#$00
	sta	_ppu_sprite_buff,x
	inx
	sta	_ppu_sprite_buff,x
	inx
	sta	_ppu_sprite_buff,x
	inx
	bne	@L

	;-----------------------
	;画面設定を元に戻す。
	DISP_RET

	rts
.endproc

