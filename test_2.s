START:  mvt    sp, #0x10   // sp = 0x1000 = 4096
        mv    r4, =0x0F0F
		mv r2, =0x302
		mv r3, =0x24
        push  r4
		push r2
		push r3
        bl    SUBR
		pop r3
		pop r2
        pop   r4
END:    b     END

SUBR:   mv r4, =0x3000
		ld r2, [r4]
		mv r4, =0x1000
		st r2, [r4]
        mv    pc, lr
