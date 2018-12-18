
	.export		ppudrv_print1

	.import		ppudrv_set_stream1
	.import		ppudrv_calc_ptNum

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_print1(char* r0, char r2, char r3, char A)
;---------------------------------------------------------------
;	Summary :		���W(X,Y)��VRAM�ɁA�|�C���^r0-1������
;				PString�̓]����NMI�G�惋�[�`���ɗ\�񂵂܂��B
;				�����NMI���荞�ݏ����ɂāAVRAM�֓]�����܂��B
;				���O��̓]�����I����ĂȂ��ꍇ�́A�I���܂ő҂��܂��B
;
;	Arguments :	X	x���W (00-1F)
;			Y	y���W (00-1D:page 0 / 20-3D:page 1)
;			__r0-1	pointer of PString data
;
;	Return :	none	
;
;	Modifies :	A X Y __r2-3
;
;	Useage :		�֐�"ppudrv_main"���ANMI�̃R�[���o�b�N�ɓo�^����Ă��鎖�B
;===============================================================
.proc	ppudrv_print1

	stx	__r2
	sty	__r3

	ldy	#0
	lda	(__r0),y
	tay
	INCW	__r0

	jsr	ppudrv_calc_ptNum		; ax <- ppu vram address

	jmp	ppudrv_set_stream1
;	rts
.endproc
