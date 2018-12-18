
	.export		Bank_Change_Prg
	.export		Bank_Change_Prg2

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	Bank_Change_Prg(a);
;---------------------------------------------------------------
;	Summary :		PRG-ROM�̃o���N�i8000h-BFFFh�j��؂�ւ��܂��B
;				8000h-9FFFh = a
;				A000h-BFFFh = a + 1
;
;	Arguments :	a	Bank
;	Return :		None
;	Modifies :	axy	
;	Useage :		
;	Note:			8000h-BFFFh ����͌Ăяo���Ȃ��ł��������B
;===============================================================
.proc	Bank_Change_Prg

	tax
	inx
;	jsr	Bank_Change_Prg2
;	rts				;���̉��ɂ��̊֐�������B

.endproc
;===============================================================
;	void	Bank_Change_Prg2(a,x);
;---------------------------------------------------------------
;	Summary :		PRG-ROM�̃o���N�i8000h-BFFFh�j��؂�ւ��܂��B
;
;	Arguments :	a	Bank of 8000h-9FFFh
;			x	Bank of A000h-BFFFh
;
;	Return :		None
;	Modifies :	axy	
;	Useage :		
;	Note:			8000h-BFFFh ����͌Ăяo���Ȃ��ł��������B
;===============================================================
.proc	Bank_Change_Prg2

	ldy	#MMC3_BNK_Prg80 + sysdef::MMC3_r0_set

	sty	MMC3_BNK_Reg	;PRG Bank�ݒ�
	sta	MMC3_BNK_Data	;
	sta	__MMC3_Pbank0	;

	iny			;
	sty	MMC3_BNK_Reg	;
	stx	MMC3_BNK_Data	;
	stx	__MMC3_Pbank1	;

	rts
.endproc
