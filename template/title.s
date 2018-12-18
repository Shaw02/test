
	.export		title

	.import		draw_log_windos

	.import		ppudrv_set_stream1
	.import		ppudrv_set_stream2
	.import		ppudrv_set_stream3

	.import		ppudrv_print1
	.import		ppudrv_print2
	.import		ppudrv_set_palette
	.import		ppudrv_clear
	.import		snd_play
	.import		jsr_ax
	.import		jsr_axy

	.include	"ndk.inc"
	.include	"define.inc"

;=======================================================================
;	Zeropage works
;-----------------------------------------------------------------------
.segment	"Title_ZP"	:Zeropage

Cursol:	.byte	0



;=======================================================================
;	Non Zeropage works
;-----------------------------------------------------------------------
.segment	"Title_BSS"





;=======================================================================
;	Const Datas
;-----------------------------------------------------------------------
.segment	"Title_DATA"

msg_00:		PString	" << Drawing Test >> "

msg_01:		PString	"Hello World"
msg_02:		PString	"Direction test."

msg_10:		PString	"1 Player"
msg_11:		PString	"2 Players"

msg_20:		PString	"MMC3 Sample Program"
msg_21:		PString	"Programmed by S.W."



text_pallet:

        .byte   $0f     ; 0 black
        .byte   $08     ; 4 BG
        .byte   $2d     ; 3 gray
        .byte   $30     ; 1 white

        .byte   $38     ; 7 yellow
        .byte   $2d     ; b dark grey
        .byte   $22     ; e light blue
        .byte   $04     ; 2 red

        .byte   $18     ; 8 orange
        .byte   $08     ; 9 brown
        .byte   $35     ; a light red
        .byte   $01     ; 6 blue

        .byte   $10     ; c middle grey
        .byte   $2b     ; d light green
        .byte   $3d     ; f light gray
        .byte   $1a     ; 5 green



;===============================================================
;	void	title();
;---------------------------------------------------------------
;	Summary :		�^�C�g�����
;	Arguments :		None
;	Return :		None
;	Modifies :	a x y __r0-7
;	Useage :		
;	Note			
;===============================================================

;-----------------------
; ��Ԗ��̂Ƃѐ�A�h���X
.segment	"Title_DATA"
JMP_TBL:
	.addr	title_init		; 00h	�^�C�g����� ������
	.addr	title_main		; 01h	�^�C�g����� ���C��


;-----------------------
; ��Ԃɉ���������
.segment	"Title_CODE"
.proc	title

	lda	_state_sub
	asl
	tay

	lda	JMP_TBL,y
	ldx	JMP_TBL + 1,y
	JMP_AX

.endproc



;-----------------------
; 00h	�^�C�g����� ������
.proc	title_init

	;-----------------------
	;��ʃN���A
	jsr	ppudrv_clear

	;-----------------------
	;��ʃ��[�h
	lda	#PPU_CTRL1_VBLANK | PPU_CTRL1_SPTBL
	DISP_SET
	lda	#PPU_CTRL2_SPDISP | PPU_CTRL2_BGDISP | PPU_CTRL2_SPCLIP | PPU_CTRL2_BGCLIP
	DISP_SET2

	;-----------------------
	;CHR-BNK �`�F���W BG
	ldx	#<CBNK_ASCII
	stx	__PPUDRV_Cbank0
	inx
	inx
	stx	__PPUDRV_Cbank1

	;CHR-BNK �`�F���W SPR
	ldx	#<CBNK_ASCII
	stx	__PPUDRV_Cbank2
	inx
	stx	__PPUDRV_Cbank3
	inx
	stx	__PPUDRV_Cbank4
	inx
	stx	__PPUDRV_Cbank5

	;-----------------------
	;BG �̃p���b�g�ݒ�
	LDAX	#text_pallet
	ldy	#0		;BG palette
	jsr	ppudrv_set_palette

	LDAX	#text_pallet
	ldy	#1		;SPR palette
	jsr	ppudrv_set_palette

	jsr	draw_log_windos

	;-----------------------
	;locate(10,10) : Print "Hello"
	LDAX	#msg_00
	STAX	__r0
	ldx	#6
	ldy	#1
	jsr	ppudrv_print1

	LDAX	#msg_01 + 1
	STAX	__r0
	lda	msg_01
	ora	#$80	;�c�����̊G��
	tay
	LDAX	#$2000 + 10 + (5*32)
	jsr	ppudrv_set_stream1

	;locate(17,10) : Print "World"
	LDAX	#msg_02 + 1
	STAX	__r0
	lda	msg_02
	ora	#$80	;�c�����̊G��
	tay
	LDAX	#$2000 + 16 + (3*32)
	jsr	ppudrv_set_stream2

	;locate(10,10) : Print "1 Player"
	LDAX	#msg_10
	STAX	__r0
	ldx	#8		; x = 10
	ldy	#22		; y = 10
	jsr	ppudrv_print1

	;locate(17,10) : Print "2 Players"
	LDAX	#msg_11
	STAX	__r0
	ldx	#8		; x = 17
	ldy	#24		; y = 10
	jsr	ppudrv_print2

	;locate(10,10) : Print "1 Player"
	LDAX	#msg_20
	STAX	__r0
	ldx	#6		; x = 10
	ldy	#26		; y = 10
	jsr	ppudrv_print1

	;locate(17,10) : Print "2 Players"
	LDAX	#msg_21
	STAX	__r0
	ldx	#7		; x = 17
	ldy	#27		; y = 10
	jsr	ppudrv_print2


	;-----------------------
	;BGM�Đ��J�n
	lda	#MUS_Opening
	jsr	snd_play


	;-----------------------
	;�J�[�\���ʒu������
	lda	#0
	sta	Cursol

	;-----------------------
	;�X�v���C�g�ݒ�
	;����
	;76543210
	;||||||||
	;||||||++- Palette (4 to 7) of sprite
	;|||+++--- Unimplemented
	;||+------ Priority (0: in front of background; 1: behind background)
	;|+------- Flip sprite horizontally
	;+-------- Flip sprite vertically
	lda	#0	;pallette = 0 / 
	sta	_ppu_sprite_buff + SPR_ONE::att

	;�\���L�����N�^
	lda	#$2A
	sta	_ppu_sprite_buff + SPR_ONE::num

	jsr	Cursol_to_Sprite

	;-----------------------
	;���̏�Ԃ�
	inc	_state_sub


	rts
.endproc



;-----------------------
; 01h	�^�C�g����� ���C��
.proc	title_main

	;�p�b�h���̓`�F�b�N
	GET_PAD0_PRESS

Up_Check:	;��{�^���`�F�b�N
	ldx	#PAD_UP
	stx	__r0
	bit	__r0
	beq	@exit
	lda	Cursol
	beq	@exit
	dec	Cursol
	jsr	Cursol_Move
@exit:

Down_Check:	;���{�^���`�F�b�N
	ldx	#PAD_DOWN
	stx	__r0
	bit	__r0
	beq	@exit
	lda	Cursol
	cmp	#1
	beq	@exit
	inc	Cursol
	jsr	Cursol_Move
@exit:

A_Check:	;�`�{�^���`�F�b�N
	ldx	#PAD_A | PAD_START
	stx	__r0
	bit	__r0
	beq	@exit
	lda	#SE_Enter
	jsr	snd_play

	lda	#STATE_TITLE
	sta	_state
	lda	#0
	sta	_state_sub

@exit:

	rts
.endproc


;===============================================================
;	void	Cursol_Move();
;---------------------------------------------------------------
;	Summary :		�J�[�\���ʒu���X�V �� ���ʉ���炵�܂��B
;	Arguments :		None
;	Return :		None
;	Modifies :	x y
;	Useage :		
;	Note			
;===============================================================
.proc	Cursol_Move
	pha
	lda	#SE_Cursol
	jsr	snd_play
;	jsr	Cursol_to_Sprite
	pla
;	rts

.endproc
;===============================================================
;	void	Cursol_Move();
;---------------------------------------------------------------
;	Summary :		�J�[�\���ʒu���X�V���܂��B
;	Arguments :		None
;	Return :		None
;	Modifies :	a x y
;	Useage :		
;	Note			
;===============================================================
.proc	Cursol_to_Sprite

	pha
	;�x���W�̍X�V
	lda	Cursol
	asl	
	asl	
	asl	
	asl	
	add	#22*8
	sta	_ppu_sprite_buff + SPR_ONE::pty

	;�w���W�̍X�V
	lda	#6*8
	sta	_ppu_sprite_buff + SPR_ONE::ptx

	pla

	rts
.endproc

