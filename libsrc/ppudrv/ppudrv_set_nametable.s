
	.export		ppudrv_set_NameTable

	.import		ppudrv_set_stream1

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;	void	ppudrv_set_NameTable(void);
;---------------------------------------------------------------
;	Summary :		�l�[���������e�[�u���ւ̓]����\�񂵂܂��B
;				��ʂ�\�������܂܁A11�t���[���ɕ����ăl�[���e�[�u���֓]�����܂��B
;				�i�R���C���~10�� �� �����e�[�u���~1��j
;				����ȍ~��NMI���荞�ݏ����ɂāAVRAM�֓]�����܂��B
;				���O��̓]�����I����ĂȂ��ꍇ�́A�I���܂ő҂��܂��B
;
;	Arguments :	AX	�]�����l�[���e�[�u���̃|�C���^
;			Y	�]����X�N���[��(0:page0 / 1:page1 / 2:page2 / 3:page3)
;
;	Return :	none	
;
;	Modifies :	A X Y __r0-3
;
;	Useage :		�֐�"ppudrv_main"���ANMI�̃R�[���o�b�N�ɓo�^����Ă��鎖�B
;===============================================================
.proc	ppudrv_set_NameTable

	STAX	__r0

	;-----------------------
	;VRAM Address �ݒ�
	tya				;
	and	#$03
	asl				;�i��Ɍv�Z���Ă����j
	asl				;
	ora	#$20			;a <= VRAM Address MSB
	sta	__r3
	lda	#0
	sta	__r2

	;-----------------------
	;VRAM �]��
	ldx	#10		;10��]��
LOOP:
	txa
	pha

	ldy	#$60		;96[Byte]
	LDAX	__r2
	jsr	ppudrv_set_stream1

	lda	__r0
	add	#$60
	sta	__r0
	bcc	@L0
	inc	__r1		; __r0::r1 += 96
@L0:

	lda	__r2
	add	#$60
	sta	__r2
	bcc	@L1
	inc	__r3
@L1:
	pla
	tax

	dex
	bne	LOOP

	;Attr table
	ldy	#$40		;64[Byte]
	LDAX	__r2		; ... 96 * 10 + 64 = 1024[Byte]
	jsr	ppudrv_set_stream1

	rts
.endproc

