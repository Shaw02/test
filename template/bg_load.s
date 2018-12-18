
	.export		BG_Load

	.import		ppudrv_set_NameTable
	.import		ppudrv_set_NameTable2
	.import		ppudrv_set_palette
	.import		ppudrv_set_palette2

	.import		Bank_Change_Prg
	.import		Bank_Change_Prg2

	.include	"ndk.inc"
	.include	"define.inc"


;===============================================================
;	ＢＧデータの情報
;---------------------------------------------------------------
.rodata

;
;	※ネームテーブルと、パレット情報は、同じバンクにおいてください。
;

;-------------------------------
;ネームテーブルのオフセットアドレス
BG_TBL_Offset:
	.addr	0					; 00h



;-------------------------------
;パレット情報のオフセットアドレス
BG_PAL_Offset:
	.addr	0					; 00h



;-------------------------------
;スプライト情報のオフセットアドレス
; -1 で
BG_SPR_Offset:
	.addr	$FFFF					; 00h



;-------------------------------
;ネームテーブルのバンク
BG_BNK:
	;	PRG			CHR
;	.byte	<PBNK_NameTable0,	<CBNK_ASCII	; 00h



;===============================================================
;	void	BG_Load(char no);
;---------------------------------------------------------------
;	Summary :		BG Display
;	Arguments :	A	BG number
;	Return :		None
;	Modifies :	A X Y __r0
;	Useage :		指定の画面を表示します。
;	Note			この関数は、上位アドレスに配置します。
;				※0x8000-0xBFFFのバンクを切り替えるため。
;===============================================================
.code
.proc	BG_Load

	asl
	sta	__r0

	;---------------
	;Bank Save
	lda	__MMC3_Pbank0
	pha
	lda	__MMC3_Pbank1
	pha			;現在のバンクを退避

Bank_Change_PRG:
	ldy	__r0
	lda	BG_BNK + 0,y
	jsr	Bank_Change_Prg

	;-----------------------
	;表示を消す
	DISP_OFF

	;---------------
	;Bank Change
Bank_Change_CHR:
	ldy	__r0
	ldx	BG_BNK + 1,y
	stx	__PPUDRV_Cbank0
	inx
	inx
	stx	__PPUDRV_Cbank1

	;---------------
	;Set name table
	lda	BG_PAL_Offset,y
	pha
	lda	BG_PAL_Offset + 1,y
	pha

Set_NameTable:
	lda	BG_TBL_Offset + 0,y
	ldx	BG_TBL_Offset + 1,y
	ldy	#0
	jsr	ppudrv_set_NameTable2	; ※ __r0-1 破壊

	;---------------
	;Set pallete
Set_Pallete:
	pla
	tax
	pla
	ldy	#0
	jsr	ppudrv_set_palette2	; ※ __r0-1 破壊

Exit:
	;-----------------------
	;表示を戻す
	DISP_RET

	;---------------
	;Bankを元に戻す
	pla
	tax
	pla
	jsr	Bank_Change_Prg2

	rts
.endproc

