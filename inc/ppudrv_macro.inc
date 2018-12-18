
.ifndef	__PPUDRV_MACRO_INC__

.define	__PPUDRV_MACRO_INC__

;---------------------------------------
;	文字列定義用のマクロです。
;---------------------------------------
;.macro	PString	Arg
;	.byte	.strlen(Arg)
;	.string	Arg
;.endmacro

.macro  PString Arg
	.byte	.strlen(Arg), Arg
.endmacro

;---------------------------------------
;	スプライトDMA on
;---------------------------------------
.macro	SPR_DMA_ON
	lda	#>_ppu_sprite_buff
	sta	__PPUDRV_Sprite_Flag
.endmacro

;---------------------------------------
;	スプライトDMA off
;---------------------------------------
.macro	SPR_DMA_OFF
	lda	#0
	sta	__PPUDRV_Sprite_Flag
.endmacro

.endif
