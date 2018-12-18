
	.export		ppudrv_main

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;			ppudrv_main(void);
;---------------------------------------------------------------
;	Summary :		デフォルトのNMI絵画ルーチンです。
;	Arguments :		None
;	Return :		None
;	Modifies :		None
;	Useage :		NMI_Set_Callback()関数に、本関数へのポインターを登録してください。
;				※ ↑ ppudrv_init()関数でやっていますので、それを呼ぶだけです。
;===============================================================
.proc	ppudrv_main

	;-------------------------------
	;Sprite DMA
	;-------------------------------
PPU_Sprite:
	lda	__PPUDRV_Sprite_Flag
	beq	@skip
	sta	APU_SPR_DMA
@skip:



	;-------------------------------
	;Stream 0　（ネームテーブル用１）
	;-------------------------------
PPU_Steram0:
	lda	__PPUDRV_T0_Cnt
	beq	@skip			;転送有り？

	asl	a			;
	adc	#0			;Cy <- A bit 7
	lsr	a			;A  <- A AND 0x7F
	tax				;X  <- A　（書き込みサイズ）

	lda	__Flag_2000		;書き込み方向の設定
	bcc	@V
	ora	#PPU_CTRL1_INC32
	bne	@Set
@V:	and	#<~PPU_CTRL1_INC32
@Set:	sta	PPU_CTRL1

	lda	__PPUDRV_D0_Pt + 1	;書き込み先のPPUアドレス設定
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D0_Pt
	sta	PPU_VRAM_ADDR2

	ldy	#$0
@Loop:	lda	(__PPUDRV_S0_Pt),y	;書き込み
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@Loop
	stx	__PPUDRV_T0_Cnt		;flag clear

@skip:



	;-------------------------------
	;Stream 1　（ネームテーブル用２）（※16dot スクロールとかの為に？）
	;-------------------------------
PPU_Steram1:

	lda	__PPUDRV_T1_Cnt
	beq	@skip			;転送有り？

	asl	a			;
	adc	#0			;Cy <- A bit 7
	lsr	a			;A  <- A AND 0x7F
	tax				;X  <- A　（書き込みサイズ）

	lda	__Flag_2000		;書き込み方向の設定
	bcc	@V
	ora	#PPU_CTRL1_INC32
	bne	@Set
@V:	and	#<~PPU_CTRL1_INC32
@Set:	sta	PPU_CTRL1

	lda	__PPUDRV_D1_Pt + 1		;書き込み先のPPUアドレス設定
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D1_Pt
	sta	PPU_VRAM_ADDR2

	ldy	#$0
@Loop:	lda	(__PPUDRV_S1_Pt),y		;書き込み
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@Loop
	stx	__PPUDRV_T1_Cnt		;flag clear

@skip:



	;-------------------------------
	;Stream 2　（属性テーブル用）
	;-------------------------------
PPU_Steram2:
	lda	__PPUDRV_T2_Cnt
	beq	@skip			;転送有り？

	ldy	#0
	asl	a			;
	adc	#0			;Cy <- A bit 7
	lsr	a			;A  <- A AND 0x7F
	tax				;X  <- A　（書き込みサイズ）
	bcc	@V

	;縦方向にVRAM更新(8byte毎)
@H:	
@H_L:	
	lda	__PPUDRV_D2_Pt + 1
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D2_Pt
	sta	PPU_VRAM_ADDR2
	add	#8
	sta	__PPUDRV_D2_Pt
;	bcs	@L2			;
;	inc	__PPUDRV_D2_Pt + 1		;（属性テーブルなので、上位アドレスの繰り上がりは無いハズ）
;@L2:					;
	lda	(__PPUDRV_S2_Pt),y
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@H_L
	beq	@exit

	;横方向にVRAM更新(1Byte毎)
@V:	lda	__Flag_2000
	and	#<~PPU_CTRL1_INC32
	sta	PPU_CTRL1

	lda	__PPUDRV_D2_Pt + 1
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D2_Pt
	sta	PPU_VRAM_ADDR2

@V_L:	lda	(__PPUDRV_S2_Pt),y
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@V_L
@exit:
	stx	__PPUDRV_T2_Cnt

@skip:



	;-------------------------------
	;Stream 3　（パレット用）
	;-------------------------------
PPU_Steram3:

	ldx	__PPUDRV_T3_Cnt
	beq	@skip			;転送有り？

	lda	__Flag_2000		;書き込み方向の設定
	and	#<~PPU_CTRL1_INC32
	sta	PPU_CTRL1

	lda	__PPUDRV_D3_Pt + 1		;書き込み先のPPUアドレス設定
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D3_Pt
	sta	PPU_VRAM_ADDR2

	ldy	#$0
@Loop:	lda	(__PPUDRV_S3_Pt),y		;書き込み
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@Loop
	stx	__PPUDRV_T3_Cnt		;flag clear

@skip:



	;-------------------------------
	;スクロール設定
	;-------------------------------
Scroll:
	lda	__PPUDRV_Scroll_x
	sta	PPU_VRAM_ADDR1
	lda	__PPUDRV_Scroll_y
	sta	PPU_VRAM_ADDR1



	;-------------------------------
	;画面絵画モードを元に戻す。
	;-------------------------------
Display:
	lda	__Flag_2000
	sta	PPU_CTRL1
	lda	__Flag_2001
	sta	PPU_CTRL2



	;-------------------------------
	;MMC3設定（CHR分）
	;-------------------------------
MMC3_BANK:
	ldx	#MMC3_BNK_Chr00 + sysdef::MMC3_r0_set

	lda	__PPUDRV_Cbank0	;CHR 0000-07FF
	ldy	__PPUDRV_Cbank1	;CHR 0800-0FFF
	stx	MMC3_BNK_Reg
	sta	MMC3_BNK_Data
	inx	
	stx	MMC3_BNK_Reg
	sty	MMC3_BNK_Data
	inx	

	lda	__PPUDRV_Cbank2	;CHR 1000-13FF
	ldy	__PPUDRV_Cbank3	;CHR 1400-17FF
	stx	MMC3_BNK_Reg
	sta	MMC3_BNK_Data
	inx	
	stx	MMC3_BNK_Reg
	sty	MMC3_BNK_Data
	inx	

	lda	__PPUDRV_Cbank4	;CHR 1800-1BFF
	ldy	__PPUDRV_Cbank5	;CHR 1C00-1FFF
	stx	MMC3_BNK_Reg
	sta	MMC3_BNK_Data
	inx	
	stx	MMC3_BNK_Reg
	sty	MMC3_BNK_Data



	;-------------------------------
	;スキャンライン割り込みの設定
	;-------------------------------
MMC3_IRQ:
	ldy	__PPUDRV_IRQ_Line
	beq	@skip

	;IRQカウンターリセット
	lda	#$FF
	sta	MMC3_IRQ_Counter	;走査線番号　セット
	sta	MMC3_IRQ_Preset		;走査線番号　ロード

	;PPUのA12を少し動かす
	ldx	#5
	lda	#$00
@loop:
	sta	PPU_VRAM_ADDR2	;一旦、画面を消してIRQを停止しちゃった後に
	sta	PPU_VRAM_ADDR2	;再度、MMC3のスキャンラインのタイマーIRQ使う時は、
	eor	#$10		;また、PPUのA12を動かさないといけないらしい。
	dex
	bne	@loop

	;パレットへの転送は、PPUのA12信号が変化して、カウンターが進んでしまうので
	;パレット転送終了後にＩＲＱを設定する。
	sty	MMC3_IRQ_Counter	;走査線番号　セット
	sty	MMC3_IRQ_Preset		;走査線番号　ロード
	sty	MMC3_IRQ_Disable	;IRQ無効
	sty	MMC3_IRQ_Enable		;IRQ有効

@skip:




	rts
.endproc
