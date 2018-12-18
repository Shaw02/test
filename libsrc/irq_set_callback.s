
	.export		IRQ_Set_Callback

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	IRQ_Set_Callback(void* AX);
;---------------------------------------------------------------
;	Summary :		IRQ�̊��荞�݃��[�`�����w�肵�܂��B
;	Arguments :	AX	pointer of callback routine
;	Return :		None
;	Modifies :		None
;	Useage :		
;===============================================================
.proc	IRQ_Set_Callback

	;�Z�b�g���鎞�́A�\���h�~�̂��߁AIRQ���荞�݋֎~
	php
	sei

	STAX	_NMI_CallBack

	plp

	rts
.endproc
