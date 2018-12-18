
	.export		ppudrv_set_palette

	.import		ppudrv_set_stream4

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_palette()
;---------------------------------------------------------------
;	Summary :		�p���b�g�̐ݒ��NMI�G�惋�[�`���ɗ\�񂵂܂��B
;				�����NMI���荞�ݏ����ɂāAVRAM�֓]�����܂��B
;				���O��̓]�����I����ĂȂ��ꍇ�́A�I���܂ő҂��܂��B

;	Arguments :	AX	pointer of palette data (16Byte�̔z��)
;			Y	$00 = palette 1
;				$01 = palette 2
;
;	Return :	none	
;
;	Modifies :	A X Y __r0
;
;	Useage :		�֐�"ppudrv_main"���ANMI�̃R�[���o�b�N�ɓo�^����Ă��鎖�B
;===============================================================
.proc	ppudrv_set_palette

	STAX	__r0

	;Select Palette
	tya
	and	#$01
	asl	a
	asl	a
	asl	a
	asl	a
	ldx	#$3F
	ldy	#$10

	jmp	ppudrv_set_stream4
;	rts
.endproc
