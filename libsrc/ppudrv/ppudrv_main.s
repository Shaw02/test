
	.export		ppudrv_main

	.include	"ndk.inc"

.segment	"PPUDRV_CODE"
;===============================================================
;			ppudrv_main(void);
;---------------------------------------------------------------
;	Summary :		�f�t�H���g��NMI�G�惋�[�`���ł��B
;	Arguments :		None
;	Return :		None
;	Modifies :		None
;	Useage :		NMI_Set_Callback()�֐��ɁA�{�֐��ւ̃|�C���^�[��o�^���Ă��������B
;				�� �� ppudrv_init()�֐��ł���Ă��܂��̂ŁA������ĂԂ����ł��B
;===============================================================
.proc	ppudrv_main

	;-------------------------------
	;Sprite DMA
	;-------------------------------
PPU_Sprite:
	lda	__PPUDRV_Sprite_Flag
	beq	@skip
	sta	APU_SPR_DMA
@skip:



	;-------------------------------
	;Stream 0�@�i�l�[���e�[�u���p�P�j
	;-------------------------------
PPU_Steram0:
	lda	__PPUDRV_T0_Cnt
	beq	@skip			;�]���L��H

	asl	a			;
	adc	#0			;Cy <- A bit 7
	lsr	a			;A  <- A AND 0x7F
	tax				;X  <- A�@�i�������݃T�C�Y�j

	lda	__Flag_2000		;�������ݕ����̐ݒ�
	bcc	@V
	ora	#PPU_CTRL1_INC32
	bne	@Set
@V:	and	#<~PPU_CTRL1_INC32
@Set:	sta	PPU_CTRL1

	lda	__PPUDRV_D0_Pt + 1	;�������ݐ��PPU�A�h���X�ݒ�
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D0_Pt
	sta	PPU_VRAM_ADDR2

	ldy	#$0
@Loop:	lda	(__PPUDRV_S0_Pt),y	;��������
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@Loop
	stx	__PPUDRV_T0_Cnt		;flag clear

@skip:



	;-------------------------------
	;Stream 1�@�i�l�[���e�[�u���p�Q�j�i��16dot �X�N���[���Ƃ��ׂ̈ɁH�j
	;-------------------------------
PPU_Steram1:

	lda	__PPUDRV_T1_Cnt
	beq	@skip			;�]���L��H

	asl	a			;
	adc	#0			;Cy <- A bit 7
	lsr	a			;A  <- A AND 0x7F
	tax				;X  <- A�@�i�������݃T�C�Y�j

	lda	__Flag_2000		;�������ݕ����̐ݒ�
	bcc	@V
	ora	#PPU_CTRL1_INC32
	bne	@Set
@V:	and	#<~PPU_CTRL1_INC32
@Set:	sta	PPU_CTRL1

	lda	__PPUDRV_D1_Pt + 1		;�������ݐ��PPU�A�h���X�ݒ�
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D1_Pt
	sta	PPU_VRAM_ADDR2

	ldy	#$0
@Loop:	lda	(__PPUDRV_S1_Pt),y		;��������
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@Loop
	stx	__PPUDRV_T1_Cnt		;flag clear

@skip:



	;-------------------------------
	;Stream 2�@�i�����e�[�u���p�j
	;-------------------------------
PPU_Steram2:
	lda	__PPUDRV_T2_Cnt
	beq	@skip			;�]���L��H

	ldy	#0
	asl	a			;
	adc	#0			;Cy <- A bit 7
	lsr	a			;A  <- A AND 0x7F
	tax				;X  <- A�@�i�������݃T�C�Y�j
	bcc	@V

	;�c������VRAM�X�V(8byte��)
@H:	
@H_L:	
	lda	__PPUDRV_D2_Pt + 1
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D2_Pt
	sta	PPU_VRAM_ADDR2
	add	#8
	sta	__PPUDRV_D2_Pt
;	bcs	@L2			;
;	inc	__PPUDRV_D2_Pt + 1		;�i�����e�[�u���Ȃ̂ŁA��ʃA�h���X�̌J��オ��͖����n�Y�j
;@L2:					;
	lda	(__PPUDRV_S2_Pt),y
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@H_L
	beq	@exit

	;��������VRAM�X�V(1Byte��)
@V:	lda	__Flag_2000
	and	#<~PPU_CTRL1_INC32
	sta	PPU_CTRL1

	lda	__PPUDRV_D2_Pt + 1
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D2_Pt
	sta	PPU_VRAM_ADDR2

@V_L:	lda	(__PPUDRV_S2_Pt),y
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@V_L
@exit:
	stx	__PPUDRV_T2_Cnt

@skip:



	;-------------------------------
	;Stream 3�@�i�p���b�g�p�j
	;-------------------------------
PPU_Steram3:

	ldx	__PPUDRV_T3_Cnt
	beq	@skip			;�]���L��H

	lda	__Flag_2000		;�������ݕ����̐ݒ�
	and	#<~PPU_CTRL1_INC32
	sta	PPU_CTRL1

	lda	__PPUDRV_D3_Pt + 1		;�������ݐ��PPU�A�h���X�ݒ�
	sta	PPU_VRAM_ADDR2
	lda	__PPUDRV_D3_Pt
	sta	PPU_VRAM_ADDR2

	ldy	#$0
@Loop:	lda	(__PPUDRV_S3_Pt),y		;��������
	sta	PPU_VRAM_IO
	iny
	dex
	bne	@Loop
	stx	__PPUDRV_T3_Cnt		;flag clear

@skip:



	;-------------------------------
	;�X�N���[���ݒ�
	;-------------------------------
Scroll:
	lda	__PPUDRV_Scroll_x
	sta	PPU_VRAM_ADDR1
	lda	__PPUDRV_Scroll_y
	sta	PPU_VRAM_ADDR1



	;-------------------------------
	;��ʊG�惂�[�h�����ɖ߂��B
	;-------------------------------
Display:
	lda	__Flag_2000
	sta	PPU_CTRL1
	lda	__Flag_2001
	sta	PPU_CTRL2



	;-------------------------------
	;MMC3�ݒ�iCHR���j
	;-------------------------------
MMC3_BANK:
	ldx	#MMC3_BNK_Chr00 + sysdef::MMC3_r0_set

	lda	__PPUDRV_Cbank0	;CHR 0000-07FF
	ldy	__PPUDRV_Cbank1	;CHR 0800-0FFF
	stx	MMC3_BNK_Reg
	sta	MMC3_BNK_Data
	inx	
	stx	MMC3_BNK_Reg
	sty	MMC3_BNK_Data
	inx	

	lda	__PPUDRV_Cbank2	;CHR 1000-13FF
	ldy	__PPUDRV_Cbank3	;CHR 1400-17FF
	stx	MMC3_BNK_Reg
	sta	MMC3_BNK_Data
	inx	
	stx	MMC3_BNK_Reg
	sty	MMC3_BNK_Data
	inx	

	lda	__PPUDRV_Cbank4	;CHR 1800-1BFF
	ldy	__PPUDRV_Cbank5	;CHR 1C00-1FFF
	stx	MMC3_BNK_Reg
	sta	MMC3_BNK_Data
	inx	
	stx	MMC3_BNK_Reg
	sty	MMC3_BNK_Data



	;-------------------------------
	;�X�L�������C�����荞�݂̐ݒ�
	;-------------------------------
MMC3_IRQ:
	ldy	__PPUDRV_IRQ_Line
	beq	@skip

	;IRQ�J�E���^�[���Z�b�g
	lda	#$FF
	sta	MMC3_IRQ_Counter	;�������ԍ��@�Z�b�g
	sta	MMC3_IRQ_Preset		;�������ԍ��@���[�h

	;PPU��A12������������
	ldx	#5
	lda	#$00
@loop:
	sta	PPU_VRAM_ADDR2	;��U�A��ʂ�������IRQ���~������������
	sta	PPU_VRAM_ADDR2	;�ēx�AMMC3�̃X�L�������C���̃^�C�}�[IRQ�g�����́A
	eor	#$10		;�܂��APPU��A12�𓮂����Ȃ��Ƃ����Ȃ��炵���B
	dex
	bne	@loop

	;�p���b�g�ւ̓]���́APPU��A12�M�����ω����āA�J�E���^�[���i��ł��܂��̂�
	;�p���b�g�]���I����ɂh�q�p��ݒ肷��B
	sty	MMC3_IRQ_Counter	;�������ԍ��@�Z�b�g
	sty	MMC3_IRQ_Preset		;�������ԍ��@���[�h
	sty	MMC3_IRQ_Disable	;IRQ����
	sty	MMC3_IRQ_Enable		;IRQ�L��

@skip:




	rts
.endproc
