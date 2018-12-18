
	.export		NMI_Set_Callback

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	NMI_Set_Callback(void* AX);
;---------------------------------------------------------------
;	Summary :		NMIでのPPUの絵画ルーチンを指定します。
;	Arguments :	AX	pointer of callback routine
;	Return :		None
;	Modifies :		None
;	Useage :		
;===============================================================
.proc	NMI_Set_Callback

	;セットする時は、暴走防止のため、NMI割り込み禁止
	pha
	lda	__Flag_2000
	and	#<~PPU_CTRL1_VBLANK
	sta	PPU_CTRL1
	pla

	STAX	_NMI_CallBack

	lda	__Flag_2000
	sta	PPU_CTRL1

	rts
.endproc
