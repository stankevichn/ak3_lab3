.global lab3
.syntax unified
#define A #2
#define B #3
#define C #3

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	data: .asciz "kernel started\n"
	final: .asciz "Value in r3: "

__kernel_reset__:
        ldr r0, =data
    	bl dbgput_line
	
	mov r0, A
	mov r1, B
	mov r2, C
	mul r3, r0, r1
	cmp r3, #10
	ITE GE
	orrGE r3, r0, r1
	andLT r3, r0, r1
	mul r3, r2
	ldr r0, =final
	bl dbgput
	mov r0, r3
	bl dbgput_num

task_end:
        b task_end
