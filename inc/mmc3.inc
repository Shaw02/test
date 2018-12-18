
.ifndef	__MMC3_INC__

.define	__MMC3_INC__

;Register define
MMC3_BNK_Reg		= $8000
MMC3_BNK_Data		= $8001
MMC3_Mirror		= $A000
MMC3_RAM		= $A001
MMC3_IRQ_Counter	= $C000
MMC3_IRQ_Preset		= $C001
MMC3_IRQ_Disable	= $E000
MMC3_IRQ_Enable		= $E001


MMC3_ChrSeg		= $80
MM3C_PrgMode		= $40

MMC3_BNK_Chr00		= $00
MMC3_BNK_Chr08		= $01
MMC3_BNK_Chr10		= $02
MMC3_BNK_Chr14		= $03
MMC3_BNK_Chr18		= $04
MMC3_BNK_Chr1C		= $05
MMC3_BNK_Prg80		= $06
MMC3_BNK_PrgA0		= $07

.endif
