
	.export		ppudrv_clear_sprite

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_clear(void);
;---------------------------------------------------------------
;	Summary :		スプライトをクリアします。
;				
;	Arguments :	none	
;	Return :	none	
;	Modifies :	A X Y	
;	Useage :		
;===============================================================
.proc	ppudrv_clear_sprite

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

	rts
.endproc

