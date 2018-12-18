

.ifndef	__NDK_MACRO_INC__

.define	__NDK_MACRO_INC__


;---------------------------------------
;	ＢＧアドレス計算
;---------------------------------------
;	ptx	X 座標
;	pty	Y 座標
;	scn	スクリーン番号
;---------------------------------------
.define	ADDR_BG(ptx,pty,scn)	$2000 + (ptx) + ((pty)*32) + ((scn)*$400)


;---------------------------------------
;	スプライトアドレス計算
;---------------------------------------
;	number	スプライト番号（0～63）
;	member	アクセスするメンバー
;		　ptx	Ｘ座標
;		　pty	Ｙ座標
;		　num	キャラクター
;		　att	属性（パレットや反転など）
;---------------------------------------
.define	ADDR_SPR(number,member)	_ppu_sprite_buff + ((number)*4) + SPR_ONE::member


;---------------------------------------
;	VBLANK 待ち
;---------------------------------------
.macro	WAIT_VBLANK
	.local	Skip
Skip:	lda	PPU_STATUS
	bpl	Skip
.endmacro

;---------------------------------------
;	NMI 割り込み待ち
;---------------------------------------
.macro	WAIT_NMI
	.local	Skip
	lda	__cc
Skip:	cmp	__cc
	beq	Skip
.endmacro

;---------------------------------------
;	ジャンプ
;---------------------------------------
.macro	JMP_AX
	STAX	_JMP_Address
	jmp	(_JMP_Address)
.endmacro

;---------------------------------------
;	コール
;---------------------------------------
.macro	JSR_AX
	jsr	jsr_ax
.endmacro

;---------------------------------------
;	バンク間コール
;---------------------------------------
.macro	FARJSR	bank, adr
	LDAX	adr
	ldy	bank
	jsr	jsr_axy
.endmacro

;---------------------------------------
;	画面表示
;	※垂直同期を待つこと！！
;---------------------------------------
.macro	DISP_SET
	sta	PPU_CTRL1
	sta	__Flag_2000
.endmacro

.macro	DISP_SET1
	sta	PPU_CTRL1
	sta	__Flag_2000
.endmacro

.macro	DISP_SET2
	sta	PPU_CTRL2
	sta	__Flag_2001
.endmacro
;---------------------------------------
;	画面表示
;---------------------------------------
.macro	DISP_ON
	WAIT_VBLANK			;垂直同期まで待つ
	lda	#sysdef::PPU_Ctrl1_set	;割り込みは開始する。
	sta	PPU_CTRL1
	sta	__Flag_2000
	lda	#sysdef::PPU_Ctrl2_set	;MMC3 IRQの初期化のために、
	sta	__Flag_2001		;BG, Spr共に表示をonにする。
	sta	PPU_CTRL2		;
.endmacro

;---------------------------------------
;	画面を消します。
;	（消す前の状態は、維持）
;---------------------------------------
.macro	DISP_OFF
	lda	#%00000000
	sta	PPU_CTRL1
	sta	PPU_CTRL2
	WAIT_VBLANK			;画面が消えるまで待つ
.endmacro

;---------------------------------------
;	画面を元に戻します。
;	（消す前の状態に、復帰）
;---------------------------------------
.macro	DISP_RET
	WAIT_VBLANK			;垂直同期まで待つ
	lda	__Flag_2000
	sta	PPU_CTRL1
	lda	__Flag_2001
	sta	PPU_CTRL2
.endmacro

;---------------------------------------
;	キー取得
;---------------------------------------
;●現在押されているキー
.macro	GET_PAD0
	lda	__PAD0
.endmacro

.macro	GET_PAD1
	lda	__PAD1
.endmacro

;●離されたキー
.macro	GET_PAD0_REMOVE
	lda	__PAD0_REL
.endmacro

.macro	GET_PAD1_REMOVE
	lda	__PAD1_REL
.endmacro

;●押されたキー
.macro	GET_PAD0_PRESS
	lda	__PAD0_TRG
.endmacro

.macro	GET_PAD1_PRESS
	lda	__PAD1_TRG
.endmacro


.endif
