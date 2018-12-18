
	.export		main

	.import		Randomize
	.import		Bank_Change_Prg2

	.import		title

	.import		__START__

	.include	"ndk.inc"
	.include	"define.inc"

;===============================================================
;	void	Call_ChangeProc();
;---------------------------------------------------------------
;	Summary :		プロセス呼び出し用
;	Arguments :	a	プロセスの番号
;	Return :		None
;	Modifies :		None
;	Useage :		
;	Note			指定のプロセスに、バンク切り替えし、
;				呼び出し先のアドレスを登録します。
;===============================================================
.rodata
;-----------------------
; 呼び出し先のアドレス
STG_Offset:
	.addr	NullProc		; 00h	Null
	.addr	title			; 01h	Title
;	.addr	stage			; 02h	Stage

;-----------------------
; 呼び出し先のバンク
STG_Bank:	;CODE Bank		DATA Bank
	.byte	0,			0
	.byte	<PBNK_Title_CODE,	<PBNK_Title_DATA	; 01h	Title
;	.byte	<PBNK_Stage_CODE,	<PBNK_Stage_DATA	; 02h	Stage

.code
.proc	Call_ChangeProc

	asl
	tay

	;---------------
	;Set address for process
	lda	STG_Offset,y
	ldx	STG_Offset + 1,y
	STAX	_ptMainProc

	;---------------
	;Bank change for process
	lda	STG_Bank,y
	ldx	STG_Bank + 1,y
	jsr	Bank_Change_Prg2

	;---------------
	;0初期化
	lda	#0
	sta	_state
	sta	_state_sub	;プロセス切り替えの際は、サブも0にリセット

	rts
.endproc
;===============================================================
;	void	Call_MainProc();
;---------------------------------------------------------------
;	Summary :		プロセス呼び出し用
;	Arguments :		None
;	Return :		None
;	Modifies :		None
;	Useage :		
;	Note			
;===============================================================
.bss
_ptMainProc:	.word	0

.code
.proc	Call_MainProc
	jmp	(_ptMainProc)
.endproc

;---------------------------------------------------------------
.proc	NullProc
	rts
.endproc

;===============================================================
;	void	Main();
;---------------------------------------------------------------
;	Summary :		メインループです。
;	Arguments :		None
;	Return :		None
;	Modifies :		None
;	Useage :		
;	Note			初期化後、最初に呼び出されます。
;===============================================================
.code
.proc	main

	;---------------
	;乱数初期化
	LDAX	#$6502
	jsr	Randomize

	;---------------
	;Start setting
	lda	#STATE_TITLE		;電源投入後・リセット後の初期状態
	jsr	Call_ChangeProc

LOOP:
	lda	__cc			;←この変数は、フレーム毎にカウントアップする。
	pha				;現在のフレームを取得
					;（ある程度だけ、フレームオーバーを回避する）

	;---------------
	;Call each Main Process
	jsr	Call_MainProc

	;---------------
	;Change process?
	lda	_state
	beq	@NO_Change
	jsr	Call_ChangeProc
@NO_Change:

	pla				;ループ開始時のフレームカウント値を取得

	;---------------
	;フレーム更新待ち
Wait_Next_Flame:
	cmp	__cc
	bne	LOOP			;次のフレームになったら先頭へ
	beq	Wait_Next_Flame

.endproc
