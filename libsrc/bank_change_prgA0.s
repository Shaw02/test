
	.export		Bank_Change_PrgA0

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	Bank_Change_Prg80(a);
;---------------------------------------------------------------
;	Summary :		PRG-ROMのバンク（A000h-BFFFh）を切り替えます。
;	Arguments :	a	Bank of A000h-BFFFh
;	Return :		None
;	Modifies :	ay	
;	Useage :		
;	Note:			A000h-BFFFh からは呼び出さないでください。
;===============================================================
.proc	Bank_Change_PrgA0

	ldy	#MMC3_BNK_PrgA0 + sysdef::MMC3_r0_set

	sty	MMC3_BNK_Reg	;PRG Bank設定
	sta	MMC3_BNK_Data	;
	sta	__MMC3_Pbank1	;

	rts
.endproc
