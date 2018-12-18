
	.export	DIV

	.include	"ndk.inc"

.segment	"MATH_CODE"
;===============================================================
;	unsigned char	DIV(unsigned char a, unsigned char x);
;---------------------------------------------------------------
;	Summary :		回復型除算　符号無し8bit
;
;	Arguments :	A	unsigned char dividend  [被除数] (8[bit])
;			X	unsigned char divisor   [除数]   (8[bit])
;
;	Return :	A	unsigned char quotient  [商]     (8[bit])
;			X	unsigned char remainder [剰余]   (8[bit])
;
;				<<Memo>>
;				quotient  = INT( dividend / divisor )
;				remainder = dividend % divisor
;
;	Modifies :	A X Y __r0 - __r1
;
;	Useage :		
;===============================================================
.proc	DIV

	sta	__r0	;[3]	remainder = dividend;
	stx	__r1	;[3]	quotient  = 0;
	lda	#0	;[2]	※シフトの工数を減らすため、__r0-1にまとめて入れている。

	ldy	#8	;[2]	y = 8;	//リピート回数（8bit分）
Loop:
	rol	__r0	;[5]	while(y>0){
	rol	a	;[2]	    y--;
	cmp	__r1	;[3]	
	bcc	NoSub	;	    if( remainder >  (divisor << y) ){
	sbc	__r1	;[3]	        remainder -= (divisor << y);
NoSub:			;	        quotient  |= (0x0001  << y);
	dey		;[2]	    }
	bne	Loop	;	}

	tax		;[2]
	lda	__r0	;[3]
	rol	a	;[2]

	rts		;
.endproc
