
	.export		ppudrv_set_palette

	.import		ppudrv_set_stream4

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_palette()
;---------------------------------------------------------------
;	Summary :		パレットの設定をNMI絵画ルーチンに予約します。
;				次回のNMI割り込み処理にて、VRAMへ転送します。
;				※前回の転送が終わってない場合は、終わるまで待ちます。

;	Arguments :	AX	pointer of palette data (16Byteの配列)
;			Y	$00 = palette 1
;				$01 = palette 2
;
;	Return :	none	
;
;	Modifies :	A X Y __r0
;
;	Useage :		関数"ppudrv_main"が、NMIのコールバックに登録されている事。
;===============================================================
.proc	ppudrv_set_palette

	STAX	__r0

	;Select Palette
	tya
	and	#$01
	asl	a
	asl	a
	asl	a
	asl	a
	ldx	#$3F
	ldy	#$10

	jmp	ppudrv_set_stream4
;	rts
.endproc
