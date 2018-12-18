
	.export		main

	.import		Randomize
	.import		Bank_Change_Prg2

	.import		title

	.import		__START__

	.include	"ndk.inc"
	.include	"define.inc"

;===============================================================
;	void	Call_ChangeProc();
;---------------------------------------------------------------
;	Summary :		�v���Z�X�Ăяo���p
;	Arguments :	a	�v���Z�X�̔ԍ�
;	Return :		None
;	Modifies :		None
;	Useage :		
;	Note			�w��̃v���Z�X�ɁA�o���N�؂�ւ����A
;				�Ăяo����̃A�h���X��o�^���܂��B
;===============================================================
.rodata
;-----------------------
; �Ăяo����̃A�h���X
STG_Offset:
	.addr	NullProc		; 00h	Null
	.addr	title			; 01h	Title
;	.addr	stage			; 02h	Stage

;-----------------------
; �Ăяo����̃o���N
STG_Bank:	;CODE Bank		DATA Bank
	.byte	0,			0
	.byte	<PBNK_Title_CODE,	<PBNK_Title_DATA	; 01h	Title
;	.byte	<PBNK_Stage_CODE,	<PBNK_Stage_DATA	; 02h	Stage

.code
.proc	Call_ChangeProc

	asl
	tay

	;---------------
	;Set address for process
	lda	STG_Offset,y
	ldx	STG_Offset + 1,y
	STAX	_ptMainProc

	;---------------
	;Bank change for process
	lda	STG_Bank,y
	ldx	STG_Bank + 1,y
	jsr	Bank_Change_Prg2

	;---------------
	;0������
	lda	#0
	sta	_state
	sta	_state_sub	;�v���Z�X�؂�ւ��̍ۂ́A�T�u��0�Ƀ��Z�b�g

	rts
.endproc
;===============================================================
;	void	Call_MainProc();
;---------------------------------------------------------------
;	Summary :		�v���Z�X�Ăяo���p
;	Arguments :		None
;	Return :		None
;	Modifies :		None
;	Useage :		
;	Note			
;===============================================================
.bss
_ptMainProc:	.word	0

.code
.proc	Call_MainProc
	jmp	(_ptMainProc)
.endproc

;---------------------------------------------------------------
.proc	NullProc
	rts
.endproc

;===============================================================
;	void	Main();
;---------------------------------------------------------------
;	Summary :		���C�����[�v�ł��B
;	Arguments :		None
;	Return :		None
;	Modifies :		None
;	Useage :		
;	Note			��������A�ŏ��ɌĂяo����܂��B
;===============================================================
.code
.proc	main

	;---------------
	;����������
	LDAX	#$6502
	jsr	Randomize

	;---------------
	;Start setting
	lda	#STATE_TITLE		;�d��������E���Z�b�g��̏������
	jsr	Call_ChangeProc

LOOP:
	lda	__cc			;�����̕ϐ��́A�t���[�����ɃJ�E���g�A�b�v����B
	pha				;���݂̃t���[�����擾
					;�i������x�����A�t���[���I�[�o�[���������j

	;---------------
	;Call each Main Process
	jsr	Call_MainProc

	;---------------
	;Change process?
	lda	_state
	beq	@NO_Change
	jsr	Call_ChangeProc
@NO_Change:

	pla				;���[�v�J�n���̃t���[���J�E���g�l���擾

	;---------------
	;�t���[���X�V�҂�
Wait_Next_Flame:
	cmp	__cc
	bne	LOOP			;���̃t���[���ɂȂ�����擪��
	beq	Wait_Next_Flame

.endproc
