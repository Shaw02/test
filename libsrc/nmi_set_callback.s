
	.export		NMI_Set_Callback

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	NMI_Set_Callback(void* AX);
;---------------------------------------------------------------
;	Summary :		NMI�ł�PPU�̊G�惋�[�`�����w�肵�܂��B
;	Arguments :	AX	pointer of callback routine
;	Return :		None
;	Modifies :		None
;	Useage :		
;===============================================================
.proc	NMI_Set_Callback

	;�Z�b�g���鎞�́A�\���h�~�̂��߁ANMI���荞�݋֎~
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
