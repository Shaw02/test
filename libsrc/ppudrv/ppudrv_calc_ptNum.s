
	.export		ppudrv_calc_ptNum

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	int	ppudrv_calc_ptNum(char r2, char r3);
;---------------------------------------------------------------
;	Summary :		座標(r2,r3)から、VRAMアドレスを求めます。
;				（ax = 0x2000 + (r3<<5) + r2）
;
;	Arguments :	__r2	x座標 ( 00-1F)
;			__r3	y座標 (	00-1D:page 0 / 20-3D:page 1 /
;				...	40-5D:page 2 / 60-7D:page 3 )
;
;	Return :	AX	PPU VRAM Address
;
;	Modifies :	A X __r2-3
;
;	Useage :		ネームテーブルのアドレス計算用です
;===============================================================
.proc	ppudrv_calc_ptNum

	lda	#$00

	lsr	__r3		;
	ror	a		;
	lsr	__r3		;
	ror	a		;
	lsr	__r3		;
	ror	a		;

	adc	__r2		;※ c は確実に`0'
	sta	__r2		;
	lda	__r3		;
	adc	#$20		;
	tax			;
	lda	__r2		;ax <= VRAMアドレス

	rts
.endproc
