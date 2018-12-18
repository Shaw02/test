
	.export		ppudrv_print1

	.import		ppudrv_set_stream1
	.import		ppudrv_calc_ptNum

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_print1(char* r0, char r2, char r3, char A)
;---------------------------------------------------------------
;	Summary :		座標(X,Y)のVRAMに、ポインタr0-1が示す
;				PStringの転送をNMI絵画ルーチンに予約します。
;				次回のNMI割り込み処理にて、VRAMへ転送します。
;				※前回の転送が終わってない場合は、終わるまで待ちます。
;
;	Arguments :	X	x座標 (00-1F)
;			Y	y座標 (00-1D:page 0 / 20-3D:page 1)
;			__r0-1	pointer of PString data
;
;	Return :	none	
;
;	Modifies :	A X Y __r2-3
;
;	Useage :		関数"ppudrv_main"が、NMIのコールバックに登録されている事。
;===============================================================
.proc	ppudrv_print1

	stx	__r2
	sty	__r3

	ldy	#0
	lda	(__r0),y
	tay
	INCW	__r0

	jsr	ppudrv_calc_ptNum		; ax <- ppu vram address

	jmp	ppudrv_set_stream1
;	rts
.endproc
