.define HEX_ADDRESS 0x2000
.define LED_ADDRESS 0x1000
.define SW_ADDRESS 0x3000
// subroutine that displays register r0 (in hex) on HEX3-0

mv r4, =LED_ADDRESS
mv r3, =SW_ADDRESS
mv r0, #0 // store the count in r0
mv sp, =0x1000
mv r2, #0 // r2 will store the score

LOOP: st r2, [r4]
bl REG

ld r1, [r3] // get whatever is stored in the switches

cmp r1, #8
beq KEY_3

cmp r1, #16
beq KEY_4

cmp r1, #32
beq KEY_5

cmp r1, #64
beq KEY_6

b ORDER

KEY_3: cmp r0, #0x8
beq INC_SCORE
b ORDER

KEY_4: cmp r0, #0x15
beq INC_SCORE
b ORDER

KEY_5: cmp r0, #0x23
beq INC_SCORE
b ORDER

KEY_6: cmp r0, #0x17
beq INC_SCORE
b ORDER

INC_SCORE: add r2, #1

ORDER: ld r1, [r3]
lsr r1, #2 // make the 3rd bit the lsb
and r1, #1 // only get the lsb
cmp r1, #1 // check if the lsb is 1
beq REVERSE // loop reverse instead of forwards
b FORWARDS // loop forwards

REVERSE: cmp r0, #0
beq	RESET_LOW
sub r0, #1
b CONTINUE

FORWARDS: mv r1, =1023
cmp r0, r1
beq RESET_HIGH
add r0, #1

CONTINUE: bl DELAY

b LOOP

RESET_HIGH:	mv r0, #0
b CONTINUE

RESET_LOW:	mv r0, =1023
b CONTINUE

// subroutine to create a delay
DELAY: push r1
push r3

mv r1, =0xff // load the initial value to count down from for the delay
mv r3, =SW_ADDRESS
ld r3, [r3] // get the actual value from the switches

and r3, #1 // get the lsb
cmp r3, #1 // check if SW0 is high
beq FAST // if the lsb is one make the counter faster

mv r3, =SW_ADDRESS
ld r3, [r3]
lsr r3, #1 // make the 2nd bit the lsb
and r3, #1 // only get the lsb
cmp r3, #1 // check if the lsb is 1
beq SLOW

b DELAY_LOOP

FAST: lsr r1, #3
b DELAY_LOOP

SLOW: lsl r1, #3

DELAY_LOOP: sub r1, #1
cmp r1, #0
bne DELAY_LOOP

pop r3
pop r1
mv pc, lr

// subroutine to display r0 on the HEX displays 3-0
REG:
push r2
push r3
mv r2, =HEX_ADDRESS // point to HEX0
mv r3, #0 // used to shift digits
DIGIT: mv r1, r0 // the register to be displayed
lsr r1, r3 // isolate digit
and r1, #0xF // " " " "
add r1, #SEG7 // point to the codes
ld r1, [r1] // get the digit code
st r1, [r2]
add r2, #1 // point to next HEX display
add r3, #4 // for shifting to the next digit
cmp r3, #16 // done all digits?
bne DIGIT
pop r3
pop r2
mv pc, lr
SEG7: .word 0b00111111 // ’0’
.word 0b00000110 // ’1’
.word 0b01011011 // ’2’
.word 0b01001111 // ’3’
.word 0b01100110 // ’4’
.word 0b01101101 // ’5’
.word 0b01111101 // ’6’
.word 0b00000111 // ’7’
.word 0b01111111 // ’8’
.word 0b01100111 // ’9’
.word 0b01110111 // ’A’ 1110111
.word 0b01111100 // ’b’ 1111100
.word 0b00111001 // ’C’ 0111001
.word 0b01011110 // ’d’ 1011110
.word 0b01111001 // ’E’ 1111001
.word 0b01110001 // ’F’ 1110001