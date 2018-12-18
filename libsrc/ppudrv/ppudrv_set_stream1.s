
	.export		ppudrv_set_stream1

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_stream1(char* r0, char* AX, char Y)
;---------------------------------------------------------------
;	Summary :		ネームテーブル用 絵画予約ルーチン
;				ポインタr0の内容をYバイト、
;				PPUのアドレスAXへ転送します。
;				NMI割り込み処理にて、VRAMへ転送します。
;;				※前回の転送が終わってない場合は、終わるまで待ちます。

;	Arguments :	AX	Address of PPU
;			Y	size & flag of stream (bit7 = dir)
;			__r0-1	pointer of stream data (word)
;
;	Return :	none
;
;	Modifies :	A	（X,Y は破壊しません。）
;
;	Useage :		関数"ppudrv_main"が、NMIのコールバックに登録されている事。
;===============================================================
.proc	ppudrv_set_stream1

	pha
@L1:	lda	__PPUDRV_T0_Cnt
	bne	@L1			;空になるまで待つ
	pla

	STAX	__PPUDRV_D0_Pt		;書き込み先のPPUアドレスを保存

	LDAX	__r0
	STAX	__PPUDRV_S0_Pt

	sty	__PPUDRV_T0_Cnt		;フラグセット

	rts
.endproc
