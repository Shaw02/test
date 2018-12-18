
	.export	DIVW

	.include	"ndk.inc"

.segment	"MATH_CODE"
;===============================================================
;	unsigned int	DIVW(unsigned int dividend, unsigned int divisor);
;---------------------------------------------------------------
;	Summary :		�񕜌^���Z�@��������16bit
;
;	Arguments :	__r0-1	unsigned char dividend  [�폜��] (16[bit])
;			__r4-5	unsigned char divisor   [����]   (16[bit]) * no break
;
;	Return :	__r0-1	unsigned char quotient  [��]     (16[bit])
;			__r2-3	unsigned char remainder [��]]   (16[bit])
;
;				<<Memo>>
;				quotient  = INT( dividend / divisor )
;				remainder = dividend % divisor
;
;	Modifies :	A X Y __r0 - __r3
;
;	Useage :		
;===============================================================
.proc	DIVW

	ldy	#0	;[2]	remainder = dividend;
	sty	__r2	;[3]	quotient  = 0;
	sty	__r3	;[3]	���V�t�g�̍H�������炷���߁A__r0-3�ɂ܂Ƃ߂ē���Ă���B

	ldy	#16	;[2]	y  =  16;	//16[bit]�̏��Z
Loop:
	rol	__r0	;[5]	while( y > 0 ){
	rol	__r1	;[5]	
	rol	__r2	;[5]	    y--;
	rol	__r3	;[5]	

	lda	__r2	;[3]	    if( remainder  > (divisor << y) ){
	sub	__r4	;[4]	
	tax		;[2]	        remainder -= (divisor << y);
	lda	__r3	;[3]	
	sbc	__r5	;[3]	         quotient |= (0x0001  << y);
	bcc	NoSub	;	
	stx	__r2	;[3]	    }
	sta	__r3	;[3]	
NoSub:
	dey		;[2]	�� No change "Cy flag"
	bne	Loop	;	}

	rol	__r0	;[5]
	rol	__r1	;[5]

	rts
.endproc
