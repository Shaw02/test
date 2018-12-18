
	.export		draw_log_windos

	.import		ppudrv_print1
	.import		ppudrv_print2
	.import		ppudrv_set_attr

	.include	"ndk.inc"
	.include	"define.inc"

;===============================================================
;	void	draw_log_windos();
;---------------------------------------------------------------
;	Summary :		座標(1,20)～(31,28)にウインドウを絵画します。
;	Arguments :		None
;	Return :		None
;	Modifies :	a x y __r0-7
;	Useage :		
;	Note			絵画には、５フレーム要します。
;				※座標は、属性テーブルの都合。座標は４の倍数がやりやすい。
;				　ｘ軸の起点を０にしない理由は、ＴＶのフレームに被るから。
;===============================================================


;=======================================
;絵画データ
;---------------------------------------
.rodata		;どこからでも呼べるように固定バンクに配置します。

;ウインドウ上パターン
window_01:	.byte	30
		.byte	$0C
		.res	28, $08
		.byte	$0D

;ウインドウ中パターン
window_02:	.byte	30
		.byte	$0A
		.res	28, $20
		.byte	$0B

;ウインドウ下パターン
window_03:	.byte	30
		.byte	$0E
		.res	28, $09
		.byte	$0F

;ウインドウの属性は、パレットを０に設定。
window_attr:	.res	24,$00



;=======================================
;絵画プログラム本体
;---------------------------------------
.code		;どこからでも呼べるように固定バンクに配置します。

.proc	draw_log_windos

	;-----------------------
	;Windows Draw

	;1 Frame
	LDAX	#window_01
	STAX	__r0
	ldx	#1
	ldy	#20
	jsr	ppudrv_print1

	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#21
	jsr	ppudrv_print2

	;2 Frame
	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#22
	jsr	ppudrv_print1

	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#23
	jsr	ppudrv_print2

	;3 Frame
	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#24
	jsr	ppudrv_print1

	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#25
	jsr	ppudrv_print2

	;4 Frame
	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#26
	jsr	ppudrv_print1

	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#27
	jsr	ppudrv_print2

	;5 Frame
	LDAX	#window_03
	STAX	__r0
	ldx	#1
	ldy	#28
	jsr	ppudrv_print1

	LDAX	#window_attr
	STAX	__r0
	lda	#24		; 24[Byte]更新
	ldx	#0		; x = 0 * 4 =  0
	ldy	#5		; y = 5 * 4 = 20
	jmp	ppudrv_set_attr

;	rts

.endproc

