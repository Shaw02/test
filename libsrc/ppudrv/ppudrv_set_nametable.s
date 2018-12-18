
	.export		ppudrv_set_NameTable

	.import		ppudrv_set_stream1

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_NameTable(void);
;---------------------------------------------------------------
;	Summary :		ネーム＆属性テーブルへの転送を予約します。
;				画面を表示したまま、11フレームに分けてネームテーブルへ転送します。
;				（３ライン×10回 ＆ 属性テーブル×1回）
;				次回以降のNMI割り込み処理にて、VRAMへ転送します。
;				※前回の転送が終わってない場合は、終わるまで待ちます。
;
;	Arguments :	AX	転送元ネームテーブルのポインタ
;			Y	転送先スクリーン(0:page0 / 1:page1 / 2:page2 / 3:page3)
;
;	Return :	none	
;
;	Modifies :	A X Y __r0-3
;
;	Useage :		関数"ppudrv_main"が、NMIのコールバックに登録されている事。
;===============================================================
.proc	ppudrv_set_NameTable

	STAX	__r0

	;-----------------------
	;VRAM Address 設定
	tya				;
	and	#$03
	asl				;（先に計算しておく）
	asl				;
	ora	#$20			;a <= VRAM Address MSB
	sta	__r3
	lda	#0
	sta	__r2

	;-----------------------
	;VRAM 転送
	ldx	#10		;10回転送
LOOP:
	txa
	pha

	ldy	#$60		;96[Byte]
	LDAX	__r2
	jsr	ppudrv_set_stream1

	lda	__r0
	add	#$60
	sta	__r0
	bcc	@L0
	inc	__r1		; __r0::r1 += 96
@L0:

	lda	__r2
	add	#$60
	sta	__r2
	bcc	@L1
	inc	__r3
@L1:
	pla
	tax

	dex
	bne	LOOP

	;Attr table
	ldy	#$40		;64[Byte]
	LDAX	__r2		; ... 96 * 10 + 64 = 1024[Byte]
	jsr	ppudrv_set_stream1

	rts
.endproc

