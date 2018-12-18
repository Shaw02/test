

.ifndef	__NDK_MACRO_INC__

.define	__NDK_MACRO_INC__


;---------------------------------------
;	�a�f�A�h���X�v�Z
;---------------------------------------
;	ptx	X ���W
;	pty	Y ���W
;	scn	�X�N���[���ԍ�
;---------------------------------------
.define	ADDR_BG(ptx,pty,scn)	$2000 + (ptx) + ((pty)*32) + ((scn)*$400)


;---------------------------------------
;	�X�v���C�g�A�h���X�v�Z
;---------------------------------------
;	number	�X�v���C�g�ԍ��i0�`63�j
;	member	�A�N�Z�X���郁���o�[
;		�@ptx	�w���W
;		�@pty	�x���W
;		�@num	�L�����N�^�[
;		�@att	�����i�p���b�g�┽�]�Ȃǁj
;---------------------------------------
.define	ADDR_SPR(number,member)	_ppu_sprite_buff + ((number)*4) + SPR_ONE::member


;---------------------------------------
;	VBLANK �҂�
;---------------------------------------
.macro	WAIT_VBLANK
	.local	Skip
Skip:	lda	PPU_STATUS
	bpl	Skip
.endmacro

;---------------------------------------
;	NMI ���荞�ݑ҂�
;---------------------------------------
.macro	WAIT_NMI
	.local	Skip
	lda	__cc
Skip:	cmp	__cc
	beq	Skip
.endmacro

;---------------------------------------
;	�W�����v
;---------------------------------------
.macro	JMP_AX
	STAX	_JMP_Address
	jmp	(_JMP_Address)
.endmacro

;---------------------------------------
;	�R�[��
;---------------------------------------
.macro	JSR_AX
	jsr	jsr_ax
.endmacro

;---------------------------------------
;	�o���N�ԃR�[��
;---------------------------------------
.macro	FARJSR	bank, adr
	LDAX	adr
	ldy	bank
	jsr	jsr_axy
.endmacro

;---------------------------------------
;	��ʕ\��
;	������������҂��ƁI�I
;---------------------------------------
.macro	DISP_SET
	sta	PPU_CTRL1
	sta	__Flag_2000
.endmacro

.macro	DISP_SET1
	sta	PPU_CTRL1
	sta	__Flag_2000
.endmacro

.macro	DISP_SET2
	sta	PPU_CTRL2
	sta	__Flag_2001
.endmacro
;---------------------------------------
;	��ʕ\��
;---------------------------------------
.macro	DISP_ON
	WAIT_VBLANK			;���������܂ő҂�
	lda	#sysdef::PPU_Ctrl1_set	;���荞�݂͊J�n����B
	sta	PPU_CTRL1
	sta	__Flag_2000
	lda	#sysdef::PPU_Ctrl2_set	;MMC3 IRQ�̏������̂��߂ɁA
	sta	__Flag_2001		;BG, Spr���ɕ\����on�ɂ���B
	sta	PPU_CTRL2		;
.endmacro

;---------------------------------------
;	��ʂ������܂��B
;	�i�����O�̏�Ԃ́A�ێ��j
;---------------------------------------
.macro	DISP_OFF
	lda	#%00000000
	sta	PPU_CTRL1
	sta	PPU_CTRL2
	WAIT_VBLANK			;��ʂ�������܂ő҂�
.endmacro

;---------------------------------------
;	��ʂ����ɖ߂��܂��B
;	�i�����O�̏�ԂɁA���A�j
;---------------------------------------
.macro	DISP_RET
	WAIT_VBLANK			;���������܂ő҂�
	lda	__Flag_2000
	sta	PPU_CTRL1
	lda	__Flag_2001
	sta	PPU_CTRL2
.endmacro

;---------------------------------------
;	�L�[�擾
;---------------------------------------
;�����݉�����Ă���L�[
.macro	GET_PAD0
	lda	__PAD0
.endmacro

.macro	GET_PAD1
	lda	__PAD1
.endmacro

;�������ꂽ�L�[
.macro	GET_PAD0_REMOVE
	lda	__PAD0_REL
.endmacro

.macro	GET_PAD1_REMOVE
	lda	__PAD1_REL
.endmacro

;�������ꂽ�L�[
.macro	GET_PAD0_PRESS
	lda	__PAD0_TRG
.endmacro

.macro	GET_PAD1_PRESS
	lda	__PAD1_TRG
.endmacro


.endif