
	.export		jsr_ax

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	jsr_ax(ax);
;---------------------------------------------------------------
;	Summary :		サブルーチンコール（バンク内）
;	Arguments :	ax	呼び出し先サブルーチンの Address
;	Return :	None
;	Modifies :	None
;	Useage :		
;	Note:			
;===============================================================
.proc	jsr_ax
	JMP_AX
.endproc
