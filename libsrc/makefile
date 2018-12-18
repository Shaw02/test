#==============================================================================
#;		NES Development Kit & Libraly  Make file
#;				A.Waranabe
#==============================================================================

TOOL_PASS =	..\_tools\\
INC_PASS =	..\inc\\
LIB_PASS =	..\lib\\

include	$(INC_PASS)makefile.mk

########################################
#;	Siurce files
########################################
#;
#;	ソース追加時は、ファイル名を追加してください。
#;	それだけで、プロジェクトに追加されます。
#;

#---------------------------------------
#;NDK Start Up
CRT_PROJ  =	crt0.o
CRT_FILES =	crt0.s

#---------------------------------------
#;NDK Libraly
SYS_PROJ  =	ndk.lib
SYS_FILES =	ndk_work.o		\
		ppu_sprite_buff.o	\
		nmi_main.o		\
		nmi_set_callback.o	\
		irq_main.o		\
		irq_set_callback.o	\
		jsr_ax.o		\
		jsr_axy.o		\
		bank_change_prg.o	\
		bank_change_prg80.o	\
		bank_change_prgA0.o	\
		ppudrv\ppudrv_main.o		\
		ppudrv\ppudrv_work.o		\
		ppudrv\ppudrv_init.o		\
		ppudrv\ppudrv_clear.o		\
		ppudrv\ppudrv_clear_sprite.o	\
		ppudrv\ppudrv_set_stream1.o	\
		ppudrv\ppudrv_set_stream2.o	\
		ppudrv\ppudrv_set_stream3.o	\
		ppudrv\ppudrv_set_stream4.o	\
		ppudrv\ppudrv_calc_ptNum.o	\
		ppudrv\ppudrv_print1.o		\
		ppudrv\ppudrv_print2.o		\
		ppudrv\ppudrv_set_attr.o	\
		ppudrv\ppudrv_set_palette.o	\
		ppudrv\ppudrv_set_palette2.o	\
		ppudrv\ppudrv_set_nametable.o	\
		ppudrv\ppudrv_set_nametable2.o	\
		math\MUL.o			\
		math\IMUL.o			\
		math\MUL_TABLE.o		\
		math\DIV.o			\
		math\DIVW.o			\
		math\hex2ascii10.o		\
		math\hex2ascii16.o		\
		math\random.o


#---------------------------------------
#;	Header files
#---------------------------------------
#;
#;	ビルドに依存するヘッダーファイルは、ここに書いてください。
#;

#---------------
#; アセンブリ言語用ヘッダー
INC_FILES =	$(INC_PASS)nes.inc		\
		$(INC_PASS)mmc3.inc		\
		$(INC_PASS)macro.inc		\
		$(INC_PASS)ndk.inc		\
		$(INC_PASS)ndk_work.inc		\
		$(INC_PASS)ndk_struct.inc	\
		$(INC_PASS)ndk_macro.inc	\
		$(INC_PASS)ppudrv.inc		\
		$(INC_PASS)ppudrv_macro.inc	\
		$(INC_PASS)nsd.inc		\
		$(INC_PASS)nsddef.inc

#---------------
#; Ｃ言語用ヘッダー
H_FILES  =	





########################################
#;	Build process
########################################

.PHONY: all clean

#---------------
#; Default Target（ここに、ビルドするプロジェクトの一覧を記述する。）
all: $(CRT_PROJ) $(SYS_PROJ)
	$(CP) $(CRT_PROJ) ..\lib
	$(CP) $(SYS_PROJ) ..\lib

#---------------
#; build of NDK start up
$(CRT_PROJ) : $(CRT_FILES)

#; build of NDK library
$(SYS_PROJ) : $(SYS_FILES)
	@echo [Archive] : $@ >>$(ERRLOG_FILE)
	$(AR) $(ARFLAGS) $@ $^ 1>>$(LOG_FILE) 2>>$(ERRLOG_FILE)



#---------------
#; Crean up
clean:
	@$(RM) $(LOG_FILE)
	@$(RM) $(ERRLOG_FILE)
	@$(RM) $(BLDLOG_FILE)

	@$(RM) *.lib
	@$(RM) *.bak
	@$(RM) *.lst
	@$(RM) *.o

	@$(RM) ppudrv\*.bak
	@$(RM) ppudrv\*.lst
	@$(RM) ppudrv\*.o

	@$(RM) math\*.bak
	@$(RM) math\*.lst
	@$(RM) math\*.o

