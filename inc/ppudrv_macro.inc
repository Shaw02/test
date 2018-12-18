
.ifndef	__PPUDRV_MACRO_INC__

.define	__PPUDRV_MACRO_INC__

;---------------------------------------
;	�������`�p�̃}�N���ł��B
;---------------------------------------
;.macro	PString	Arg
;	.byte	.strlen(Arg)
;	.string	Arg
;.endmacro

.macro  PString Arg
	.byte	.strlen(Arg), Arg
.endmacro

;---------------------------------------
;	�X�v���C�gDMA on
;---------------------------------------
.macro	SPR_DMA_ON
	lda	#>_ppu_sprite_buff
	sta	__PPUDRV_Sprite_Flag
.endmacro

;---------------------------------------
;	�X�v���C�gDMA off
;---------------------------------------
.macro	SPR_DMA_OFF
	lda	#0
	sta	__PPUDRV_Sprite_Flag
.endmacro

.endif