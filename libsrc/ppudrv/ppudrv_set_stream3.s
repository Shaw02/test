
	.export		ppudrv_set_stream3

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_stream3(char* r0, char* AX, char Y)
;---------------------------------------------------------------
;	Summary :		�p���b�g�p �G��\�񃋁[�`��
;				�|�C���^r0�̓��e��Y�o�C�g�A
;				PPU�̃A�h���XAX�֓]�����܂��B
;				NMI���荞�ݏ����ɂāAVRAM�֓]�����܂��B
;				���O��̓]�����I����ĂȂ��ꍇ�́A�I���܂ő҂��܂��B
;
;	Arguments :	AX	Address of PPU
;			Y	size & flag of stream (bit7 = dir)
;			__r0-1	pointer of stream data (word)
;
;	Return :	none
;
;	Modifies :	A	�iX,Y �͔j�󂵂܂���B�j
;
;	Useage :		�֐�"ppudrv_main"���ANMI�̃R�[���o�b�N�ɓo�^����Ă��鎖�B
;===============================================================
.proc	ppudrv_set_stream3

	pha
@L1:	lda	__PPUDRV_T2_Cnt
	bne	@L1			;��ɂȂ�܂ő҂�
	pla

	STAX	__PPUDRV_D2_Pt		;�������ݐ��PPU�A�h���X��ۑ�

	LDAX	__r0
	STAX	__PPUDRV_S2_Pt

	sty	__PPUDRV_T2_Cnt		;�t���O�Z�b�g

	rts
.endproc
