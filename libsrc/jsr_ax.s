
	.export		jsr_ax

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	jsr_ax(ax);
;---------------------------------------------------------------
;	Summary :		�T�u���[�`���R�[���i�o���N���j
;	Arguments :	ax	�Ăяo����T�u���[�`���� Address
;	Return :	None
;	Modifies :	None
;	Useage :		
;	Note:			
;===============================================================
.proc	jsr_ax
	JMP_AX
.endproc
