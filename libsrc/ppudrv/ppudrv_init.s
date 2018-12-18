
	.export		ppudrv_init

	.import		ppudrv_main
	.import		ppudrv_clear
	.import		NMI_Set_Callback

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_init(void);
;---------------------------------------------------------------
;	Summary :		ＰＰＵドライバーを初期化します。
;	Arguments :	none	
;	Return :	none	
;	Modifies :	A X Y	
;	Useage :		基本的には、電源投入時・リセット時に１回だけ呼び出します
;				もしくは、他の絵画システムからPPUDRVに戻す際に呼び出します。
;===============================================================
.proc	ppudrv_init

	;-----------------------
	;コールバックを一時無しに
	LDAX	#0			;
	jsr	NMI_Set_Callback	;

	lda	#sysdef::PPU_Ctrl1_set	;割り込みは開始する。
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
	;MMC3 バンクの初期化
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
	lda	#sysdef::PPU_Ctrl2_set	;MMC3 IRQの初期化のために、
	sta	__Flag_2001		;BG, Spr共に表示をonにする。
	sta	PPU_CTRL2		;

	STA	MMC3_IRQ_Disable	 ;MMC3 IRQ Disable
	lda	PPU_STATUS		;
	lda	#$10			;
	tax				;
@L:					;
	sta	PPU_VRAM_ADDR2		;PPUのA12を動かして、MMC3のタイマーを初期化する。
	sta	PPU_VRAM_ADDR2		; ＃ 表示がonでないと、PPUのアドレスラインが動かない。
	eor	#$10			; ＃ また、BG=0x0000, Spr=0x1000の状態にしておく。
	dex				;
	bne	@L			;

	;-----------------------
	;コールバック設定
	LDAX	#ppudrv_main		;
	jsr	NMI_Set_Callback	;コールバックの設定

	rts
.endproc

