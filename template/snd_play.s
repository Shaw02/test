
	.export		snd_play

	.import		Bank_Change_Prg
	.import		Bank_Change_Prg2

	.include	"ndk.inc"
	.include	"define.inc"

;===============================================================
;	曲データの情報
;---------------------------------------------------------------

.rodata
	.import		_MUS00_DPCMinfo
	.import		_MUS00_BGM0

	.import		_SE_SE0
	.import		_SE_SE1



;-------------------------------
;曲データがあるアドレス
BGM_TBL_Offset:
	.addr	_MUS00_BGM0		;00h	オープニング


;-------------------------------
;曲データがあるバンク（セグメント）
BGM_TBL_Segment:
	;	曲のバンク	⊿PCMinfo構造体（BGM_TBL_DPCMinfo）
	.byte	<PBNK_MUS0,	0	;00h	オープニング


;-------------------------------
;⊿PCM info構造体があるアドレス（各バンク）
BGM_TBL_DPCMinfo:	
	.addr	_MUS00_DPCMinfo		;00h 


;-------------------------------
SE_TBL_Offset:
	.addr	_SE_SE0			;00h	カーソル
	.addr	_SE_SE1			;00h	カーソル


;-------------------------------
SE_TBL_Segment:
	.byte	<PBNK_SE,	0	;00h	決定
	.byte	<PBNK_SE,	0	;01h	カーソル



;===============================================================
;	void	snd_play(char no);
;---------------------------------------------------------------
;	Summary :		Start play bgm
;	Arguments :	A	Number (BGM:00h- / SE:80h- )
;	Return :		None
;	Modifies :	A X Y __r0
;	Useage :		ＢＧＭ／効果音を再生する時に呼びます。
;===============================================================
.code
.proc	snd_play

	;---------------
	;save BGM/SE number
	tay

	;---------------
	;Sound Drv 割り込み無効化
	lda	__flag
	ora	#nsd_flag::Disable
	sta	__flag

	;---------------
	;Bank Save
	lda	__MMC3_Pbank0
	pha
	lda	__MMC3_Pbank1
	pha			;現在のバンクを退避

	;---------------
	;calc BGM/SE number
	tya
	asl
	tay
	sta	__r0
	bcs	SE



BGM:	;=======================

	;---------------
	;Bank Change
	lda	BGM_TBL_Segment,y
	sta	__MusBank	;バンク number
	jsr	Bank_Change_Prg


	;---------------
	;⊿PCMの設定
	ldy	__r0
	lda	BGM_TBL_Segment + 1,y
	bmi	@nodpcm

	asl
	tay
	lda	BGM_TBL_DPCMinfo + 0, y
	ldx	BGM_TBL_DPCMinfo + 1, y
	jsr	_nsd_set_dpcm

@nodpcm:

	;---------------
	;再生
	ldy	__r0
	lda	BGM_TBL_Offset + 0, y
	ldx	BGM_TBL_Offset + 1, y
	jsr	_nsd_play_bgm
	jmp	Exit



SE:	;=======================

	;---------------
	;Bank Change
	lda	SE_TBL_Segment,y
	sta	__SeBank	;バンク number
	jsr	Bank_Change_Prg

	;---------------
	;再生
	ldy	__r0
	lda	SE_TBL_Offset + 0, y
	ldx	SE_TBL_Offset + 1, y
	jsr	_nsd_play_se



Exit:	;=======================

	;---------------
	;Bankを元に戻す
	pla
	tax
	pla
	jsr	Bank_Change_Prg2

	;---------------
	;Sound Drv 割り込み有効化
	lda	__flag
	and	#<~nsd_flag::Disable
	sta	__flag

	rts
.endproc
