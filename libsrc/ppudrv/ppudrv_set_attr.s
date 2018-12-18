
	.export		ppudrv_set_attr

	.import		ppudrv_set_stream3

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_palette()
;---------------------------------------------------------------
;	Summary :		�����e�[�u���̐ݒ��NMI�G�惋�[�`���ɗ\�񂵂܂��B
;				�����NMI���荞�ݏ����ɂāAVRAM�֓]�����܂��B
;				���O��̓]�����I����ĂȂ��ꍇ�́A�I���܂ő҂��܂��B

;	Arguments :	A	length (bit7 = dir)
;			X	x(00-07)
;			Y	y(00-07:page 0 / 08-0F:page 1 / 10-17:page 2 / 18-1F:page 3)
;			__r0	pointer of stream data
;
;	Return :	none	
;
;	Modifies :	A X Y __r0 - r3
;
;	Useage :		�֐�"ppudrv_main"���ANMI�̃R�[���o�b�N�ɓo�^����Ă��鎖�B
;===============================================================
.proc	ppudrv_set_attr

	sta	__r3
	stx	__r2
	tya

	;y�� %000xx000 �����́A�y�[�W�I��
	and	#$18
	lsr	a
	add	#$23
	tax			; x <= VRAM Address MSB

	;y�� %00000xxx �����́Ay���W
	tya
	ldy	__r3
	and	#$07
	asl	a
	asl	a
	asl	a
	adc	#$C0
	add	__r2		; a <= VRAM Address LSB

	ldy	__r3

	jmp	ppudrv_set_stream3
;	rts
.endproc
