
	.export		ppudrv_set_attr

	.import		ppudrv_set_stream3

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_palette()
;---------------------------------------------------------------
;	Summary :		属性テーブルの設定をNMI絵画ルーチンに予約します。
;				次回のNMI割り込み処理にて、VRAMへ転送します。
;				※前回の転送が終わってない場合は、終わるまで待ちます。

;	Arguments :	A	length (bit7 = dir)
;			X	x(00-07)
;			Y	y(00-07:page 0 / 08-0F:page 1 / 10-17:page 2 / 18-1F:page 3)
;			__r0	pointer of stream data
;
;	Return :	none	
;
;	Modifies :	A X Y __r0 - r3
;
;	Useage :		関数"ppudrv_main"が、NMIのコールバックに登録されている事。
;===============================================================
.proc	ppudrv_set_attr

	sta	__r3
	stx	__r2
	tya

	;yの %000xx000 部分は、ページ選択
	and	#$18
	lsr	a
	add	#$23
	tax			; x <= VRAM Address MSB

	;yの %00000xxx 部分は、y座標
	tya
	ldy	__r3
	and	#$07
	asl	a
	asl	a
	asl	a
	adc	#$C0
	add	__r2		; a <= VRAM Address LSB

	ldy	__r3

	jmp	ppudrv_set_stream3
;	rts
.endproc
