
	.exportzp	__PPUDRV_S0_Pt
	.exportzp	__PPUDRV_D0_Pt
	.exportzp	__PPUDRV_S1_Pt
	.exportzp	__PPUDRV_D1_Pt
	.exportzp	__PPUDRV_S2_Pt
	.exportzp	__PPUDRV_D2_Pt
	.exportzp	__PPUDRV_S3_Pt
	.exportzp	__PPUDRV_D3_Pt
	
	.exportzp	__PPUDRV_T0_Cnt
	.exportzp	__PPUDRV_T1_Cnt
	.exportzp	__PPUDRV_T2_Cnt
	.exportzp	__PPUDRV_T3_Cnt
	
	.exportzp	__PPUDRV_Sprite_Flag
	.exportzp	__PPUDRV_IRQ_Line
	.exportzp	__PPUDRV_Scroll_x
	.exportzp	__PPUDRV_Scroll_y

	.exportzp	__PPUDRV_Cbank0
	.exportzp	__PPUDRV_Cbank1
	.exportzp	__PPUDRV_Cbank2
	.exportzp	__PPUDRV_Cbank3
	.exportzp	__PPUDRV_Cbank4
	.exportzp	__PPUDRV_Cbank5

;=======================================================================
;	Zeropage works
;-----------------------------------------------------------------------
.segment	"PPUDRV_ZP":zeropage

__PPUDRV_S0_Pt:		.word	0		;= $60	;PPU�]�����A�h���X1	(name table 1)
__PPUDRV_D0_Pt:		.word	0		;= $62	;PPU�]����A�h���X1	
__PPUDRV_S1_Pt:		.word	0		;= $64	;PPU�]�����A�h���X2	(name table 2)
__PPUDRV_D1_Pt:		.word	0		;= $66	;PPU�]����A�h���X2	
__PPUDRV_S2_Pt:		.word	0		;= $68	;PPU�]�����A�h���X3	(attr)
__PPUDRV_D2_Pt:		.word	0		;= $6A	;PPU�]����A�h���X3	
__PPUDRV_S3_Pt:		.word	0		;= $6C	;PPU�]�����A�h���X4	(palette)
__PPUDRV_D3_Pt:		.word	0		;= $6E	;PPU�]����A�h���X4	

__PPUDRV_T0_Cnt:	.byte	0		;= $70	;PPU�]���T�C�Y1		(name table 1)
__PPUDRV_T1_Cnt:	.byte	0		;= $71	;PPU�]���T�C�Y2		(name table 2)
__PPUDRV_T2_Cnt:	.byte	0		;= $72	;PPU�]���T�C�Y3		(attr)
__PPUDRV_T3_Cnt:	.byte	0		;= $73	;PPU�]���T�C�Y4		(palette)

__PPUDRV_Sprite_Flag:	.byte	0		;= $74	;�X�v���C�gDMA�̃X�C�b�`�i��ʃA�h���X������Ƌ쓮�j
__PPUDRV_IRQ_Line:	.byte	0		;= $75	;IRQ�������C��
__PPUDRV_Scroll_x:	.byte	0		;= $76	;x���W
__PPUDRV_Scroll_y:	.byte	0		;= $77	;y���W

;-----------------------------------------------------------------------
;�}�b�p�[�֘A
__PPUDRV_Cbank0:	.byte	0		;= $78	;
__PPUDRV_Cbank1:	.byte	0		;= $79	;
__PPUDRV_Cbank2:	.byte	0		;= $7A	;
__PPUDRV_Cbank3:	.byte	0		;= $7B	;
__PPUDRV_Cbank4:	.byte	0		;= $7C	;
__PPUDRV_Cbank5:	.byte	0		;= $7D	;

