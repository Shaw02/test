
	.export		Bank_Change_PrgA0

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	Bank_Change_Prg80(a);
;---------------------------------------------------------------
;	Summary :		PRG-ROM�̃o���N�iA000h-BFFFh�j��؂�ւ��܂��B
;	Arguments :	a	Bank of A000h-BFFFh
;	Return :		None
;	Modifies :	ay	
;	Useage :		
;	Note:			A000h-BFFFh ����͌Ăяo���Ȃ��ł��������B
;===============================================================
.proc	Bank_Change_PrgA0

	ldy	#MMC3_BNK_PrgA0 + sysdef::MMC3_r0_set

	sty	MMC3_BNK_Reg	;PRG Bank�ݒ�
	sta	MMC3_BNK_Data	;
	sta	__MMC3_Pbank1	;

	rts
.endproc
