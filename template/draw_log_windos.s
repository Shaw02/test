
	.export		draw_log_windos

	.import		ppudrv_print1
	.import		ppudrv_print2
	.import		ppudrv_set_attr

	.include	"ndk.inc"
	.include	"define.inc"

;===============================================================
;	void	draw_log_windos();
;---------------------------------------------------------------
;	Summary :		���W(1,20)�`(31,28)�ɃE�C���h�E���G�悵�܂��B
;	Arguments :		None
;	Return :		None
;	Modifies :	a x y __r0-7
;	Useage :		
;	Note			�G��ɂ́A�T�t���[���v���܂��B
;				�����W�́A�����e�[�u���̓s���B���W�͂S�̔{�������₷���B
;				�@�����̋N�_���O�ɂ��Ȃ����R�́A�s�u�̃t���[���ɔ�邩��B
;===============================================================


;=======================================
;�G��f�[�^
;---------------------------------------
.rodata		;�ǂ�����ł��Ăׂ�悤�ɌŒ�o���N�ɔz�u���܂��B

;�E�C���h�E��p�^�[��
window_01:	.byte	30
		.byte	$0C
		.res	28, $08
		.byte	$0D

;�E�C���h�E���p�^�[��
window_02:	.byte	30
		.byte	$0A
		.res	28, $20
		.byte	$0B

;�E�C���h�E���p�^�[��
window_03:	.byte	30
		.byte	$0E
		.res	28, $09
		.byte	$0F

;�E�C���h�E�̑����́A�p���b�g���O�ɐݒ�B
window_attr:	.res	24,$00



;=======================================
;�G��v���O�����{��
;---------------------------------------
.code		;�ǂ�����ł��Ăׂ�悤�ɌŒ�o���N�ɔz�u���܂��B

.proc	draw_log_windos

	;-----------------------
	;Windows Draw

	;1 Frame
	LDAX	#window_01
	STAX	__r0
	ldx	#1
	ldy	#20
	jsr	ppudrv_print1

	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#21
	jsr	ppudrv_print2

	;2 Frame
	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#22
	jsr	ppudrv_print1

	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#23
	jsr	ppudrv_print2

	;3 Frame
	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#24
	jsr	ppudrv_print1

	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#25
	jsr	ppudrv_print2

	;4 Frame
	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#26
	jsr	ppudrv_print1

	LDAX	#window_02
	STAX	__r0
	ldx	#1
	ldy	#27
	jsr	ppudrv_print2

	;5 Frame
	LDAX	#window_03
	STAX	__r0
	ldx	#1
	ldy	#28
	jsr	ppudrv_print1

	LDAX	#window_attr
	STAX	__r0
	lda	#24		; 24[Byte]�X�V
	ldx	#0		; x = 0 * 4 =  0
	ldy	#5		; y = 5 * 4 = 20
	jmp	ppudrv_set_attr

;	rts

.endproc

