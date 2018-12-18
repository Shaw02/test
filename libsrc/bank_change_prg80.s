
	.export		Bank_Change_Prg80

	.include	"ndk.inc"

.segment	"LOWCODE"
;===============================================================
;	void	Bank_Change_Prg80(a);
;---------------------------------------------------------------
;	Summary :		PRG-ROMのバンク（8000h-9FFFh）を切り替えます。
;	Arguments :	a	Bank of 8000h-9FFFh
;	Return :		None
;	Modifies :	ay	
;	Useage :		
;	Note:			8000h-9FFFh からは呼び出さないでください。
;===============================================================
.proc	Bank_Change_Prg80

	ldy	#MMC3_BNK_Prg80 + sysdef::MMC3_r0_set

	sty	MMC3_BNK_Reg	;PRG Bank設定
	sta	MMC3_BNK_Data	;
	sta	__MMC3_Pbank0	;

	rts
.endproc
