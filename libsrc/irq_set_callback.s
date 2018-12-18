
	.export		IRQ_Set_Callback

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	IRQ_Set_Callback(void* AX);
;---------------------------------------------------------------
;	Summary :		IRQの割り込みルーチンを指定します。
;	Arguments :	AX	pointer of callback routine
;	Return :		None
;	Modifies :		None
;	Useage :		
;===============================================================
.proc	IRQ_Set_Callback

	;セットする時は、暴走防止のため、IRQ割り込み禁止
	php
	sei

	STAX	_NMI_CallBack

	plp

	rts
.endproc
