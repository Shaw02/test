
;===============================================================
;	���[�N�̊O���錾
;---------------------------------------------------------------

	.import		_state
	.import		_state_sub



;===============================================================
;	�o�q�f�|�q�n�l�@�o���N��`
;---------------------------------------------------------------
; �o���N�ԍ��́A�����J�[�̃R���t�B�O�t�@�C���ɂĒ�`�B
; �����ł́A�V���{�����C���|�[�g

	.import		PBNK_SE
	.import		PBNK_MUS0
	.import		PBNK_MUS1
	.import		PBNK_MUS2
	.import		PBNK_MUS3

	.import		PBNK_Logo_CODE
	.import		PBNK_Logo_DATA
	.import		PBNK_Title_CODE
	.import		PBNK_Title_DATA
	.import		PBNK_Credit_CODE
	.import		PBNK_Credit_DATA
	.import		PBNK_Stage_CODE
	.import		PBNK_Stage_DATA
	.import		PBNK_Ending_CODE
	.import		PBNK_Ending_DATA

	.import		PBNK_DPCM
	.import		PBNK_BIOS


;===============================================================
;	�b�g�q�|�q�n�l�@�o���N��`
;---------------------------------------------------------------
; �o���N�ԍ��́A�����J�[�̃R���t�B�O�t�@�C���ɂĒ�`�B
; �����ł́A�V���{�����C���|�[�g

	.import		CBNK_ASCII
	.import		CBNK_LOGO_BG
	.import		CBNK_LOGO_SPR

;===============================================================
;	��Ԓ�`
;---------------------------------------------------------------

STATE_NULL	= $00
STATE_TITLE	= $01
STATE_STAGE	= $02


;===============================================================
;	�Ȓ�`
;---------------------------------------------------------------

MUS_Opening	= $00

SE_Enter	= $80
SE_Cursol	= $81