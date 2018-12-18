
;===============================================================
;	ワークの外部宣言
;---------------------------------------------------------------

	.import		_state
	.import		_state_sub



;===============================================================
;	ＰＲＧ－ＲＯＭ　バンク定義
;---------------------------------------------------------------
; バンク番号は、リンカーのコンフィグファイルにて定義。
; ここでは、シンボルをインポート

	.import		PBNK_SE
	.import		PBNK_MUS0
	.import		PBNK_MUS1
	.import		PBNK_MUS2
	.import		PBNK_MUS3

	.import		PBNK_Logo_CODE
	.import		PBNK_Logo_DATA
	.import		PBNK_Title_CODE
	.import		PBNK_Title_DATA
	.import		PBNK_Credit_CODE
	.import		PBNK_Credit_DATA
	.import		PBNK_Stage_CODE
	.import		PBNK_Stage_DATA
	.import		PBNK_Ending_CODE
	.import		PBNK_Ending_DATA

	.import		PBNK_DPCM
	.import		PBNK_BIOS


;===============================================================
;	ＣＨＲ－ＲＯＭ　バンク定義
;---------------------------------------------------------------
; バンク番号は、リンカーのコンフィグファイルにて定義。
; ここでは、シンボルをインポート

	.import		CBNK_ASCII
	.import		CBNK_LOGO_BG
	.import		CBNK_LOGO_SPR

;===============================================================
;	状態定義
;---------------------------------------------------------------

STATE_NULL	= $00
STATE_TITLE	= $01
STATE_STAGE	= $02


;===============================================================
;	曲定義
;---------------------------------------------------------------

MUS_Opening	= $00

SE_Enter	= $80
SE_Cursol	= $81
