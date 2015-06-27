	.section .rodata
result:
	.asciz "For the  approximation factor %d  number of matches are %d\n" 
string:
	.asciz "chimb chyme crime grime prime slime" @enter the the string
word:
	.asciz "clime" @enter the patern here
worring:
	.asciz"The approximation factor is greater then or equal to the length of the patern\n"
	

	.text
	.global main
main:
	sub sp,sp,#8
	str lr, [sp, #4]
	str r0, [sp, #0] @load the value to the stuck
	
	ldr r4, =string @load the string and patern
	ldr r5, =word
	mov r6,#2		@enter the approximation factor here
	
	@ chacking the inputs
	mov r7,#-1
chck:
	add r7,r7,#1
	ldrb r8,[r5,r7]
	cmp r8,#0
	bne chck
	sub r7,r7,#1
	cmp r7,r6
	bge crrct
	ldr r0, =worring
	bl printf
	b over

@ String Matching 	
crrct:
	mov r0,r4
	mov r1,r6
	mov r2,r5
	bl match

	@printing the outputs
	mov r2,r0
	ldr r0, =result
	bl printf
	
	
over:	@end the main  program
	ldr lr, [sp, #4]
	ldr r0, [sp, #0]
	
	add sp,sp, #8
	
	mov r0, #0
	mov pc, lr
	
match: @ identifing the String Matching and count the matchings
	sub sp, sp, #4  @loading the return address for main function
	str lr, [sp, #0]  
	
	mov r4,r0  @the address of the string 
	mov r5,r2  @the address of the word
	
	
	
	mov r6, #-1  @the cunter of the string
	mov r7,#0	 @@the cunter of the recognized patern
	mov r8, #0  @the cunter of the string
	
loop1: @if a patern is not recognized
	sub r6,r6,r8
	add r6 ,r6, #1
loop11:	@if a patern is recognized
	mov r8, #0
	mov r9,#0
	
loop2:
	ldrb r10,[r4,r6]  @compair the elements one by one
	ldrb r11,[r5,r8]
	
	cmp r10,#0 @when the string is over
	beq lcont
	
	cmp r11,#0	@when the patern is over
	beq cont
	
	cmp r10,r11  @when string elements not match
	bne wrng
	
	
nxt:	@ go to next loop
	add r6,r6,#1
	add r8,r8,#1
	
	b loop2
	
cont:  @ count the number of paterns recognized
	cmp r1,r9
	blt loop1
	add r7,r7,#1
	b loop11
	
wrng:	@ count the number dismatching situations
	add r9,r9,#1
	b nxt
	
	


lcont:	@when the string chacking is over 
	cmp r11,#0	
	bne exit
	cmp r1,r9
	blt exit
	add r7,r7,#1
	b exit
	

	
exit: @exit from the second function
	
	ldr lr,[sp, #0]
	add sp,sp ,#4

	mov r0, r7
	mov pc, lr
	

	