#==============================================================================
#;		Make file
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

#---------------
#; プロジェクト名
MAIN_PROJ  =	temp.nes

#---------------
#; リンカーの設定
CFG_FILE   =	temp.cfg
MAP_FILE   =	temp.map

#---------------
#; ソースファイル
MAIN_FILES =	ines.o			\
		bg_load.o		\
		snd_play.o		\
		snd_get_state.o		\
		draw_log_windos.o	\
		title.o			\
		work.o			\
		main.o			



CHR_FILES  =	chr\ascii.o

MML_FILES  =	mml\se.o		\
		mml\mus00.o




#---------------------------------------
#;	Header files
#---------------------------------------
#;
#;	ビルドに依存するヘッダーファイルは、ここに書いてください。
#;

#---------------
#; アセンブリ言語用ヘッダー
INC_FILES =	define.inc

#---------------
#; Ｃ言語用ヘッダー
H_FILES  =	

#---------------
#; ⊿ＰＣＭファイル
DMC_FILES =	




#---------------------------------------
#;	Library files
#---------------------------------------
#;
#;	ビルドに依存するライブラリファイルは、ここに書いてください。
#;

LIB_FILES =	

NDK_FILES  =	$(LIB_PASS)crt0.o	\
		$(LIB_PASS)ndk.lib	\
		$(LIB_PASS)nsd.lib





########################################
#;	Build process
########################################

.PHONY: all clean

#---------------
#; Default Target（ここに、ビルドするプロジェクトの一覧を記述する。）
all: $(MAIN_PROJ)


#---------------
#; build of main program
$(MAIN_PROJ) : $(MAIN_FILES) $(CHR_FILES) $(MML_FILES) $(NDK_FILES) $(LIB_FILES)
	@echo [Link] : $@ >>$(ERRLOG_FILE)
	$(LINKER) $(LDFLAGS) $@ $^ 1>>$(LOG_FILE) 2>>$(ERRLOG_FILE)

#---------------
#; Crean up
clean:
#	@$(RM) *.nes		#NESファイルは、消さないでおく。
	@$(RM) *.bak
	@$(RM) *.map
	@$(RM) *.lst
	@$(RM) *.o

	@$(RM) mml\*.lib
	@$(RM) mml\*.bak
	@$(RM) mml\*.lst
	@$(RM) mml\*.s
	@$(RM) mml\*.o

	@$(RM) chr\*.lib
	@$(RM) chr\*.bak
	@$(RM) chr\*.lst
	@$(RM) chr\*.o

	@$(RM) $(LOG_FILE)
	@$(RM) $(ERRLOG_FILE)
	@$(RM) $(BLDLOG_FILE)
