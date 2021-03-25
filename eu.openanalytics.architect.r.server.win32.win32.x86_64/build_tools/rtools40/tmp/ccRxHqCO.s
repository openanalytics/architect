	.file	"uncmin.c"
	.text
	.p2align 4,,15
	.def	fstocd;	.scl	3;	.type	32;	.endef
	.seh_proc	fstocd
fstocd:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$168, %rsp
	.seh_stackalloc	168
	movaps	%xmm6, 48(%rsp)
	.seh_savexmm	%xmm6, 48
	movaps	%xmm7, 64(%rsp)
	.seh_savexmm	%xmm7, 64
	movaps	%xmm8, 80(%rsp)
	.seh_savexmm	%xmm8, 80
	movaps	%xmm9, 96(%rsp)
	.seh_savexmm	%xmm9, 96
	movaps	%xmm10, 112(%rsp)
	.seh_savexmm	%xmm10, 112
	movaps	%xmm11, 128(%rsp)
	.seh_savexmm	%xmm11, 128
	movaps	%xmm12, 144(%rsp)
	.seh_savexmm	%xmm12, 144
	.seh_endprologue
	movsd	280(%rsp), %xmm7
	movl	%ecx, %esi
	movq	%rdx, %rbx
	movq	%r8, %rdi
	movq	%r9, %rbp
	testl	%ecx, %ecx
	jle	.L1
	leal	-1(%rcx), %r15d
	xorl	%r12d, %r12d
	movsd	.LC0(%rip), %xmm10
	movsd	.LC1(%rip), %xmm9
	movq	.LC2(%rip), %xmm8
	leaq	32(%rsp), %r14
	leaq	40(%rsp), %r13
	jmp	.L3
	.p2align 4,,10
.L4:
	movq	%rdx, %r12
.L3:
	movsd	(%rbx,%r12,8), %xmm11
	movq	272(%rsp), %rax
	movapd	%xmm9, %xmm1
	movapd	%xmm7, %xmm0
	movapd	%xmm10, %xmm12
	divsd	(%rax,%r12,8), %xmm12
	call	pow
	movapd	%xmm12, %xmm1
	movapd	%xmm0, %xmm6
	movapd	%xmm11, %xmm0
	andpd	%xmm8, %xmm0
	call	Rf_fmax2
	movq	%rbp, %r9
	movq	%r14, %r8
	movq	%rbx, %rdx
	mulsd	%xmm0, %xmm6
	movapd	%xmm11, %xmm0
	movl	%esi, %ecx
	addsd	%xmm6, %xmm0
	movsd	%xmm0, (%rbx,%r12,8)
	call	*%rdi
	movapd	%xmm11, %xmm0
	movq	%rbx, %rdx
	movq	%rbp, %r9
	subsd	%xmm6, %xmm0
	movq	%r13, %r8
	movl	%esi, %ecx
	movsd	%xmm0, (%rbx,%r12,8)
	call	*%rdi
	movsd	32(%rsp), %xmm0
	addsd	%xmm6, %xmm6
	subsd	40(%rsp), %xmm0
	movq	288(%rsp), %rax
	movsd	%xmm11, (%rbx,%r12,8)
	leaq	1(%r12), %rdx
	divsd	%xmm6, %xmm0
	movsd	%xmm0, (%rax,%r12,8)
	cmpq	%r15, %r12
	jne	.L4
.L1:
	movaps	48(%rsp), %xmm6
	movaps	64(%rsp), %xmm7
	movaps	80(%rsp), %xmm8
	movaps	96(%rsp), %xmm9
	movaps	128(%rsp), %xmm11
	movaps	112(%rsp), %xmm10
	movaps	144(%rsp), %xmm12
	addq	$168, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.seh_endproc
	.p2align 4,,15
	.def	sndofd;	.scl	3;	.type	32;	.endef
	.seh_proc	sndofd
sndofd:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$216, %rsp
	.seh_stackalloc	216
	movaps	%xmm6, 96(%rsp)
	.seh_savexmm	%xmm6, 96
	movaps	%xmm7, 112(%rsp)
	.seh_savexmm	%xmm7, 112
	movaps	%xmm8, 128(%rsp)
	.seh_savexmm	%xmm8, 128
	movaps	%xmm9, 144(%rsp)
	.seh_savexmm	%xmm9, 144
	movaps	%xmm10, 160(%rsp)
	.seh_savexmm	%xmm10, 160
	movaps	%xmm11, 176(%rsp)
	.seh_savexmm	%xmm11, 176
	movaps	%xmm12, 192(%rsp)
	.seh_savexmm	%xmm12, 192
	.seh_endprologue
	movq	360(%rsp), %r13
	movq	368(%rsp), %rdi
	movsd	328(%rsp), %xmm7
	movsd	352(%rsp), %xmm9
	movl	%ecx, 288(%rsp)
	movl	%edx, %ebp
	movq	%r9, %r12
	testl	%edx, %edx
	jle	.L6
	leal	-1(%rdx), %eax
	xorl	%r15d, %r15d
	movq	%r8, %rbx
	movsd	.LC1(%rip), %xmm12
	movq	%rax, 72(%rsp)
	movq	344(%rsp), %rsi
	leaq	8(,%rax,8), %r14
	movsd	.LC0(%rip), %xmm11
	movq	.LC2(%rip), %xmm10
	.p2align 4,,10
.L8:
	movsd	(%rbx,%r15), %xmm8
	movapd	%xmm12, %xmm1
	movapd	%xmm9, %xmm0
	call	pow
	movapd	%xmm11, %xmm1
	divsd	(%rsi,%r15), %xmm1
	movapd	%xmm0, %xmm6
	movapd	%xmm8, %xmm0
	andpd	%xmm10, %xmm0
	call	Rf_fmax2
	leaq	(%rdi,%r15), %r8
	movq	%rbx, %rdx
	movl	%ebp, %ecx
	mulsd	%xmm6, %xmm0
	movq	320(%rsp), %r9
	movsd	%xmm0, 0(%r13,%r15)
	addsd	%xmm8, %xmm0
	movsd	%xmm0, (%rbx,%r15)
	call	*%r12
	movsd	%xmm8, (%rbx,%r15)
	addq	$8, %r15
	cmpq	%r14, %r15
	jne	.L8
	movslq	288(%rsp), %r15
	movq	%rbx, %rsi
	leaq	8(,%r15,8), %rax
	xorl	%r15d, %r15d
	movq	%rax, 64(%rsp)
	subq	$8, %rax
	movq	%rax, 48(%rsp)
	movq	336(%rsp), %rax
	movq	%rax, 56(%rsp)
	leaq	88(%rsp), %rax
	movq	%rax, 32(%rsp)
	jmp	.L12
	.p2align 4,,10
.L16:
	movsd	%xmm8, (%rsi)
.L10:
	movq	64(%rsp), %rcx
	leaq	1(%r15), %rdx
	addq	%rcx, 56(%rsp)
	cmpq	72(%rsp), %r15
	je	.L6
	movq	%rdx, %r15
.L12:
	movsd	(%rsi,%r15,8), %xmm8
	movq	32(%rsp), %r8
	movq	%rsi, %rdx
	movl	%ebp, %ecx
	movsd	0(%r13,%r15,8), %xmm0
	movq	320(%rsp), %r9
	addsd	%xmm0, %xmm0
	addsd	%xmm8, %xmm0
	movsd	%xmm0, (%rsi,%r15,8)
	call	*%r12
	movsd	(%rdi,%r15,8), %xmm2
	movapd	%xmm7, %xmm3
	movq	56(%rsp), %rax
	movsd	88(%rsp), %xmm0
	movsd	0(%r13,%r15,8), %xmm1
	subsd	%xmm2, %xmm3
	subsd	%xmm2, %xmm0
	mulsd	%xmm1, %xmm1
	addsd	%xmm3, %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
	testq	%r15, %r15
	je	.L16
	movsd	0(%r13,%r15,8), %xmm0
	movq	336(%rsp), %rax
	movq	%r13, 360(%rsp)
	xorl	%ebx, %ebx
	movq	%r15, %r13
	addsd	%xmm8, %xmm0
	leaq	(%rax,%r15,8), %r14
	leal	-1(%r15), %eax
	movq	%rax, 40(%rsp)
	movsd	%xmm0, (%rsi,%r15,8)
	movq	360(%rsp), %r15
	jmp	.L11
	.p2align 4,,10
.L13:
	movq	%rdx, %rbx
.L11:
	movsd	(%rsi,%rbx,8), %xmm6
	movsd	(%r15,%rbx,8), %xmm0
	movq	%rsi, %rdx
	movl	%ebp, %ecx
	movq	320(%rsp), %r9
	movq	32(%rsp), %r8
	addsd	%xmm6, %xmm0
	movsd	%xmm0, (%rsi,%rbx,8)
	call	*%r12
	movsd	88(%rsp), %xmm0
	movapd	%xmm7, %xmm1
	subsd	(%rdi,%rbx,8), %xmm0
	subsd	(%rdi,%r13,8), %xmm1
	leaq	1(%rbx), %rdx
	addsd	%xmm1, %xmm0
	movsd	(%r15,%r13,8), %xmm1
	mulsd	(%r15,%rbx,8), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%r14)
	addq	48(%rsp), %r14
	movsd	%xmm6, (%rsi,%rbx,8)
	cmpq	40(%rsp), %rbx
	jne	.L13
	movq	%r15, 360(%rsp)
	movq	%r13, %r15
	movq	360(%rsp), %r13
	movsd	%xmm8, (%rsi,%r15,8)
	jmp	.L10
	.p2align 4,,10
.L6:
	movaps	96(%rsp), %xmm6
	movaps	112(%rsp), %xmm7
	movaps	128(%rsp), %xmm8
	movaps	144(%rsp), %xmm9
	movaps	160(%rsp), %xmm10
	movaps	176(%rsp), %xmm11
	movaps	192(%rsp), %xmm12
	addq	$216, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.seh_endproc
	.p2align 4,,15
	.def	choldc;	.scl	3;	.type	32;	.endef
	.seh_proc	choldc
choldc:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$152, %rsp
	.seh_stackalloc	152
	movaps	%xmm6, 48(%rsp)
	.seh_savexmm	%xmm6, 48
	movaps	%xmm7, 64(%rsp)
	.seh_savexmm	%xmm7, 64
	movaps	%xmm8, 80(%rsp)
	.seh_savexmm	%xmm8, 80
	movaps	%xmm9, 96(%rsp)
	.seh_savexmm	%xmm9, 96
	movaps	%xmm10, 112(%rsp)
	.seh_savexmm	%xmm10, 112
	movaps	%xmm11, 128(%rsp)
	.seh_savexmm	%xmm11, 128
	.seh_endprologue
	pxor	%xmm7, %xmm7
	mulsd	256(%rsp), %xmm3
	movq	264(%rsp), %r14
	movq	$0x000000000, (%r14)
	movl	%ecx, %ebp
	movl	%edx, %ebx
	movq	%r8, %r13
	ucomisd	%xmm3, %xmm7
	sqrtsd	%xmm3, %xmm9
	movapd	%xmm3, %xmm0
	ja	.L60
.L18:
	mulsd	%xmm9, %xmm9
	testl	%ebx, %ebx
	jle	.L17
	movsd	0(%r13), %xmm6
	movslq	%ebp, %rax
	leaq	8(,%rax,8), %rdi
	comisd	%xmm9, %xmm6
	jb	.L61
	ucomisd	%xmm6, %xmm7
	sqrtsd	%xmm6, %xmm8
	ja	.L62
.L21:
	movsd	%xmm8, 0(%r13)
.L22:
	cmpl	$1, %ebx
	je	.L17
	movq	.LC2(%rip), %xmm8
	leal	1(%rbp), %eax
	leal	-2(%rbx), %r15d
	movl	$1, %ebp
	cltq
	leaq	-8(%rdi), %rbx
	leaq	8(%r13), %rsi
	addq	$2, %r15
	leaq	0(%r13,%rax,8), %r12
	leaq	0(%r13,%rbx), %rax
	movq	%rax, 40(%rsp)
	.p2align 4,,10
.L41:
	movsd	(%rsi), %xmm0
	movl	%ebp, %r11d
	divsd	0(%r13), %xmm0
	movsd	%xmm0, (%rsi)
	cmpq	$1, %rbp
	je	.L27
	movl	$1, %r8d
	movq	40(%rsp), %r10
	leaq	(%rsi,%rbx), %r9
	movl	$1, %ecx
	subq	%rbp, %r8
	.p2align 4,,10
.L33:
	movq	%rsi, %rax
	pxor	%xmm1, %xmm1
	xorl	%edx, %edx
	.p2align 4,,10
.L32:
	movsd	(%rax,%r8,8), %xmm0
	mulsd	(%rax), %xmm0
	addl	$1, %edx
	addq	%rbx, %rax
	addsd	%xmm0, %xmm1
	cmpl	%ecx, %edx
	jne	.L32
	movsd	(%r9), %xmm0
	addl	$1, %ecx
	addq	$1, %r8
	subsd	%xmm1, %xmm0
	divsd	8(%r10), %xmm0
	addq	%rdi, %r10
	movsd	%xmm0, (%r9)
	addq	%rbx, %r9
	cmpl	%ecx, %r11d
	jne	.L33
.L27:
	movq	%rsi, %rdx
	pxor	%xmm1, %xmm1
	xorl	%eax, %eax
	.p2align 4,,10
.L34:
	movsd	(%rdx), %xmm0
	addl	$1, %eax
	addq	%rbx, %rdx
	mulsd	%xmm0, %xmm0
	addsd	%xmm0, %xmm1
	cmpl	%eax, %r11d
	jg	.L34
	movsd	(%r12), %xmm10
	subsd	%xmm1, %xmm10
	comisd	%xmm9, %xmm10
	jb	.L63
	ucomisd	%xmm10, %xmm7
	sqrtsd	%xmm10, %xmm6
	ja	.L64
.L28:
	movsd	%xmm6, (%r12)
.L29:
	addq	$1, %rbp
	addq	$8, %rsi
	addq	%rdi, %r12
	cmpq	%r15, %rbp
	jne	.L41
.L17:
	movaps	48(%rsp), %xmm6
	movaps	64(%rsp), %xmm7
	movaps	80(%rsp), %xmm8
	movaps	96(%rsp), %xmm9
	movaps	128(%rsp), %xmm11
	movaps	112(%rsp), %xmm10
	addq	$152, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L63:
	movq	%rsi, %rdx
	pxor	%xmm6, %xmm6
	xorl	%eax, %eax
	.p2align 4,,10
.L36:
	movsd	(%rdx), %xmm0
	addl	$1, %eax
	addq	%rbx, %rdx
	andpd	%xmm8, %xmm0
	maxsd	%xmm6, %xmm0
	movapd	%xmm0, %xmm6
	cmpl	%r11d, %eax
	jl	.L36
	movapd	%xmm6, %xmm0
	cmpnlesd	%xmm9, %xmm0
	andpd	%xmm0, %xmm6
	andnpd	%xmm9, %xmm0
	orpd	%xmm0, %xmm6
	ucomisd	%xmm6, %xmm7
	sqrtsd	%xmm6, %xmm11
	ja	.L65
.L30:
	movsd	%xmm11, (%r12)
	subsd	%xmm10, %xmm6
	comisd	(%r14), %xmm6
	jbe	.L29
	movsd	%xmm6, (%r14)
	jmp	.L29
.L61:
	comisd	%xmm7, %xmm9
	jb	.L66
	ucomisd	%xmm9, %xmm7
	sqrtsd	%xmm9, %xmm8
	movapd	%xmm9, %xmm0
	ja	.L67
.L23:
	movsd	%xmm8, 0(%r13)
	subsd	%xmm6, %xmm0
	comisd	(%r14), %xmm0
	jbe	.L22
	movsd	%xmm0, (%r14)
	jmp	.L22
.L66:
	pxor	%xmm0, %xmm0
	pxor	%xmm8, %xmm8
	jmp	.L23
.L62:
	movapd	%xmm6, %xmm0
	call	sqrt
	jmp	.L21
.L67:
	call	sqrt
	movapd	%xmm9, %xmm0
	jmp	.L23
.L60:
	call	sqrt
	jmp	.L18
.L65:
	movapd	%xmm6, %xmm0
	call	sqrt
	jmp	.L30
.L64:
	movapd	%xmm10, %xmm0
	call	sqrt
	jmp	.L28
	.seh_endproc
	.p2align 4,,15
	.def	fstofd;	.scl	3;	.type	32;	.endef
	.seh_proc	fstofd
fstofd:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$216, %rsp
	.seh_stackalloc	216
	movaps	%xmm6, 96(%rsp)
	.seh_savexmm	%xmm6, 96
	movaps	%xmm7, 112(%rsp)
	.seh_savexmm	%xmm7, 112
	movaps	%xmm8, 128(%rsp)
	.seh_savexmm	%xmm8, 128
	movaps	%xmm9, 144(%rsp)
	.seh_savexmm	%xmm9, 144
	movaps	%xmm10, 160(%rsp)
	.seh_savexmm	%xmm10, 160
	movaps	%xmm11, 176(%rsp)
	.seh_savexmm	%xmm11, 176
	movaps	%xmm12, 192(%rsp)
	.seh_savexmm	%xmm12, 192
	.seh_endprologue
	movq	336(%rsp), %rbp
	movq	344(%rsp), %rbx
	movsd	360(%rsp), %xmm6
	movq	368(%rsp), %rsi
	movl	%ecx, %r13d
	movl	%edx, 296(%rsp)
	movq	%r9, %r15
	movl	%r8d, 304(%rsp)
	testl	%r8d, %r8d
	jle	.L68
	movl	%edx, %r10d
	movl	%edx, %r14d
	movl	%r8d, %eax
	movl	%edx, %ecx
	subl	$1, %eax
	shrl	%r10d
	andl	$-2, %r14d
	subl	$1, %ecx
	movq	%rax, 48(%rsp)
	salq	$4, %r10
	movslq	%r14d, %rax
	leaq	16(%rsi), %rdx
	salq	$3, %rax
	sqrtsd	%xmm6, %xmm10
	movl	%ecx, 68(%rsp)
	xorl	%r12d, %r12d
	movq	%rdx, 56(%rsp)
	leaq	(%rsi,%rax), %r11
	xorl	%edi, %edi
	addq	%rbp, %rax
	movq	%rcx, 80(%rsp)
	pxor	%xmm7, %xmm7
	movq	.LC2(%rip), %xmm9
	movsd	.LC0(%rip), %xmm8
	movq	%r10, 72(%rsp)
	movl	%r13d, 288(%rsp)
	movq	%r11, %r13
	.p2align 4,,10
.L77:
	ucomisd	%xmm6, %xmm7
	movsd	(%r15,%rdi,8), %xmm11
	movapd	%xmm8, %xmm1
	movq	352(%rsp), %rcx
	andpd	%xmm9, %xmm11
	divsd	(%rcx,%rdi,8), %xmm1
	ja	.L108
.L70:
	movapd	%xmm11, %xmm0
	movq	%rax, 40(%rsp)
	call	Rf_fmax2
	movsd	(%r15,%rdi,8), %xmm12
	movq	%rsi, %r8
	movq	%r15, %rdx
	mulsd	%xmm10, %xmm0
	movq	328(%rsp), %r9
	movl	304(%rsp), %ecx
	movapd	%xmm0, %xmm11
	addsd	%xmm12, %xmm0
	movsd	%xmm0, (%r15,%rdi,8)
	call	*320(%rsp)
	movl	296(%rsp), %eax
	movsd	%xmm12, (%r15,%rdi,8)
	testl	%eax, %eax
	movq	40(%rsp), %rax
	jle	.L71
	movslq	%r12d, %rdx
	leaq	16(,%rdx,8), %rdx
	leaq	-16(%rbx,%rdx), %rcx
	addq	%rbx, %rdx
	cmpq	%rdx, %rsi
	setnb	%r9b
	cmpq	56(%rsp), %rcx
	setnb	%r8b
	orl	%r9d, %r8d
	cmpq	%rdx, %rbp
	leaq	16(%rbp), %r9
	setnb	%dl
	cmpq	%r9, %rcx
	setnb	%r9b
	orl	%r9d, %edx
	testb	%dl, %r8b
	je	.L72
	cmpl	$1, 68(%rsp)
	jbe	.L72
	movapd	%xmm11, %xmm0
	movq	72(%rsp), %r10
	xorl	%edx, %edx
	unpcklpd	%xmm0, %xmm0
	.p2align 4,,10
.L73:
	movupd	(%rsi,%rdx), %xmm1
	movupd	0(%rbp,%rdx), %xmm4
	subpd	%xmm4, %xmm1
	divpd	%xmm0, %xmm1
	movups	%xmm1, (%rcx,%rdx)
	addq	$16, %rdx
	cmpq	%r10, %rdx
	jne	.L73
	cmpl	%r14d, 296(%rsp)
	je	.L71
	movsd	0(%r13), %xmm0
	subsd	(%rax), %xmm0
	leal	(%r12,%r14), %edx
	movslq	%edx, %rdx
	divsd	%xmm11, %xmm0
	movsd	%xmm0, (%rbx,%rdx,8)
.L71:
	leaq	1(%rdi), %rdx
	addl	288(%rsp), %r12d
	cmpq	48(%rsp), %rdi
	je	.L109
	movq	%rdx, %rdi
	jmp	.L77
	.p2align 4,,10
.L72:
	xorl	%edx, %edx
	movq	80(%rsp), %r9
	jmp	.L75
	.p2align 4,,10
.L84:
	movq	%r8, %rdx
.L75:
	movsd	(%rsi,%rdx,8), %xmm0
	subsd	0(%rbp,%rdx,8), %xmm0
	leaq	1(%rdx), %r8
	divsd	%xmm11, %xmm0
	movsd	%xmm0, (%rcx,%rdx,8)
	cmpq	%r9, %rdx
	jne	.L84
	jmp	.L71
	.p2align 4,,10
.L109:
	cmpl	$3, 376(%rsp)
	movl	288(%rsp), %r13d
	jne	.L68
	cmpl	$1, 304(%rsp)
	jg	.L110
.L68:
	movaps	96(%rsp), %xmm6
	movaps	112(%rsp), %xmm7
	movaps	128(%rsp), %xmm8
	movaps	144(%rsp), %xmm9
	movaps	160(%rsp), %xmm10
	movaps	176(%rsp), %xmm11
	movaps	192(%rsp), %xmm12
	addq	$216, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L110:
	cmpl	$1, 296(%rsp)
	jle	.L68
	movslq	%r13d, %r11
	movsd	.LC5(%rip), %xmm3
	movl	%r13d, %r10d
	xorl	%ebp, %ebp
	leaq	0(,%r11,8), %rcx
	movl	$8, %esi
	salq	$4, %r11
	xorl	%r14d, %r14d
	leaq	8(%rcx), %r15
	leaq	(%rcx,%rbx), %rdi
	movapd	%xmm3, %xmm2
	movq	%rcx, %r12
	movapd	.LC4(%rip), %xmm1
	movl	$1, %r8d
	.p2align 4,,10
.L83:
	testl	%r13d, %r13d
	movq	%r14, %rax
	movq	%rdi, %rdx
	cmovs	%rbp, %rax
	subq	%rbx, %rdx
	addq	%rsi, %rax
	cmpq	%rdx, %rax
	movq	%r14, %rax
	setg	%dl
	testl	%r13d, %r13d
	cmovns	%rbp, %rax
	addq	%rsi, %rax
	cmpq	%r12, %rax
	setl	%al
	orb	%al, %dl
	je	.L78
	leal	-1(%r8), %eax
	cmpl	$26, %eax
	seta	%dl
	testl	%r13d, %r13d
	setne	%al
	testb	%al, %dl
	je	.L78
	movl	%r8d, %r9d
	leaq	(%rbx,%r12), %rdx
	leaq	(%rbx,%rsi), %rax
	shrl	%r9d
	salq	$4, %r9
	addq	%rdx, %r9
	.p2align 4,,10
.L79:
	movsd	(%rax), %xmm0
	movupd	(%rdx), %xmm5
	addq	$16, %rdx
	movhpd	(%rax,%rcx), %xmm0
	addpd	%xmm5, %xmm0
	mulpd	%xmm1, %xmm0
	movlpd	%xmm0, (%rax)
	movhpd	%xmm0, (%rax,%rcx)
	addq	%r11, %rax
	cmpq	%r9, %rdx
	jne	.L79
	movl	%r8d, %eax
	andl	$-2, %eax
	cmpl	%r8d, %eax
	je	.L82
	movl	%eax, %edx
	addl	%r10d, %eax
	imull	%r13d, %edx
	cltq
	movsd	(%rbx,%rax,8), %xmm0
	addl	%r8d, %edx
	movslq	%edx, %rdx
	leaq	(%rbx,%rdx,8), %rdx
	addsd	(%rdx), %xmm0
	mulsd	%xmm2, %xmm0
	movsd	%xmm0, (%rdx)
.L82:
	addl	$1, %r8d
	addq	%rcx, %rbp
	addq	$8, %rsi
	addq	%rcx, %r12
	addq	%r15, %rdi
	addl	%r13d, %r10d
	cmpl	%r8d, 296(%rsp)
	jne	.L83
	jmp	.L68
	.p2align 4,,10
.L78:
	leaq	(%rbx,%rsi), %rax
	leaq	(%rbx,%r12), %rdx
	jmp	.L81
	.p2align 4,,10
.L86:
	movq	%r9, %rdx
.L81:
	movsd	(%rdx), %xmm0
	addsd	(%rax), %xmm0
	leaq	8(%rdx), %r9
	mulsd	%xmm3, %xmm0
	movsd	%xmm0, (%rax)
	addq	%rcx, %rax
	cmpq	%rdi, %rdx
	jne	.L86
	jmp	.L82
.L108:
	movapd	%xmm6, %xmm0
	movq	%rax, 88(%rsp)
	movsd	%xmm1, 40(%rsp)
	call	sqrt
	movq	88(%rsp), %rax
	movsd	40(%rsp), %xmm1
	jmp	.L70
	.seh_endproc
	.p2align 4,,15
	.def	opt_stop.isra.0;	.scl	3;	.type	32;	.endef
	.seh_proc	opt_stop.isra.0
opt_stop.isra.0:
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$152, %rsp
	.seh_stackalloc	152
	movaps	%xmm6, 48(%rsp)
	.seh_savexmm	%xmm6, 48
	movaps	%xmm7, 64(%rsp)
	.seh_savexmm	%xmm7, 64
	movaps	%xmm8, 80(%rsp)
	.seh_savexmm	%xmm8, 80
	movaps	%xmm9, 96(%rsp)
	.seh_savexmm	%xmm9, 96
	movaps	%xmm10, 112(%rsp)
	.seh_savexmm	%xmm10, 112
	movaps	%xmm11, 128(%rsp)
	.seh_savexmm	%xmm11, 128
	.seh_endprologue
	movl	$3, %eax
	cmpl	$1, 304(%rsp)
	movl	%ecx, %r12d
	movq	%rdx, %rbp
	movq	%r9, %rbx
	je	.L111
	movq	.LC2(%rip), %xmm7
	movsd	288(%rsp), %xmm1
	andpd	%xmm7, %xmm2
	movapd	%xmm2, %xmm0
	call	Rf_fmax2
	movapd	%xmm0, %xmm9
	testl	%r12d, %r12d
	jle	.L126
	leal	-1(%r12), %eax
	movq	280(%rsp), %rdi
	movq	%rbp, %rsi
	pxor	%xmm10, %xmm10
	leaq	(%rbx,%rax,8), %r13
	pxor	%xmm11, %xmm11
	movsd	.LC0(%rip), %xmm8
	jmp	.L116
	.p2align 4,,10
.L127:
	movq	%rax, %rbx
.L116:
	movsd	(%rsi), %xmm0
	movsd	(%rbx), %xmm6
	addq	$8, %rdi
	addq	$8, %rsi
	movapd	%xmm8, %xmm1
	divsd	-8(%rdi), %xmm1
	andpd	%xmm7, %xmm0
	andpd	%xmm7, %xmm6
	call	Rf_fmax2
	leaq	8(%rbx), %rax
	mulsd	%xmm0, %xmm6
	divsd	%xmm9, %xmm6
	maxsd	%xmm11, %xmm6
	movapd	%xmm6, %xmm11
	cmpq	%r13, %rbx
	jne	.L127
.L113:
	comisd	264(%rsp), %xmm11
	movl	$1, %eax
	jbe	.L111
	movl	248(%rsp), %ecx
	testl	%ecx, %ecx
	je	.L118
	testl	%r12d, %r12d
	jle	.L119
	leal	-1(%r12), %eax
	movq	%rbp, %rbx
	movq	240(%rsp), %rdi
	movq	280(%rsp), %rsi
	movsd	.LC0(%rip), %xmm8
	leaq	8(%rbp,%rax,8), %rbp
	.p2align 4,,10
.L122:
	movsd	(%rbx), %xmm0
	addq	$8, %rbx
	addq	$8, %rdi
	addq	$8, %rsi
	movapd	%xmm8, %xmm1
	divsd	-8(%rsi), %xmm1
	movapd	%xmm0, %xmm6
	subsd	-8(%rdi), %xmm6
	andpd	%xmm7, %xmm0
	call	Rf_fmax2
	andpd	%xmm7, %xmm6
	divsd	%xmm0, %xmm6
	maxsd	%xmm10, %xmm6
	movapd	%xmm6, %xmm10
	cmpq	%rbx, %rbp
	jne	.L122
.L119:
	comisd	272(%rsp), %xmm10
	movl	$2, %eax
	jbe	.L111
	movl	$4, %eax
	movl	296(%rsp), %ecx
	cmpl	%ecx, 248(%rsp)
	jge	.L111
	movl	312(%rsp), %edx
	movq	256(%rsp), %rax
	testl	%edx, %edx
	je	.L144
	movl	(%rax), %eax
	leal	1(%rax), %edx
	movl	%eax, 44(%rsp)
	movq	256(%rsp), %rax
	movl	%edx, (%rax)
	movl	$5, %eax
	cmpl	$4, %edx
	jle	.L118
.L111:
	movaps	48(%rsp), %xmm6
	movaps	64(%rsp), %xmm7
	movaps	80(%rsp), %xmm8
	movaps	96(%rsp), %xmm9
	movaps	128(%rsp), %xmm11
	movaps	112(%rsp), %xmm10
	addq	$152, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	ret
	.p2align 4,,10
.L118:
	xorl	%eax, %eax
	jmp	.L111
	.p2align 4,,10
.L126:
	pxor	%xmm10, %xmm10
	pxor	%xmm11, %xmm11
	jmp	.L113
.L144:
	movl	$0, (%rax)
	xorl	%eax, %eax
	jmp	.L111
	.seh_endproc
	.p2align 4,,15
	.def	fstofd.constprop.5;	.scl	3;	.type	32;	.endef
	.seh_proc	fstofd.constprop.5
fstofd.constprop.5:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$136, %rsp
	.seh_stackalloc	136
	movaps	%xmm6, 32(%rsp)
	.seh_savexmm	%xmm6, 32
	movaps	%xmm7, 48(%rsp)
	.seh_savexmm	%xmm7, 48
	movaps	%xmm8, 64(%rsp)
	.seh_savexmm	%xmm8, 64
	movaps	%xmm9, 80(%rsp)
	.seh_savexmm	%xmm9, 80
	movaps	%xmm10, 96(%rsp)
	.seh_savexmm	%xmm10, 96
	movaps	%xmm11, 112(%rsp)
	.seh_savexmm	%xmm11, 112
	.seh_endprologue
	movq	256(%rsp), %r14
	movq	272(%rsp), %rbx
	movsd	264(%rsp), %xmm6
	movl	%ecx, %esi
	movq	%rdx, %r13
	movq	%r8, %rdi
	movq	%r9, %rbp
	testl	%ecx, %ecx
	jle	.L145
	pxor	%xmm0, %xmm0
	sqrtsd	%xmm6, %xmm9
	leal	-1(%rcx), %r15d
	movl	$0, %r12d
	ucomisd	%xmm6, %xmm0
	movsd	.LC0(%rip), %xmm7
	movq	.LC2(%rip), %xmm8
	jbe	.L149
	jmp	.L148
	.p2align 4,,10
.L151:
	movq	%rdx, %r12
.L149:
	movsd	0(%r13,%r12,8), %xmm0
	movapd	%xmm7, %xmm1
	divsd	(%r14,%r12,8), %xmm1
	andpd	%xmm8, %xmm0
	call	Rf_fmax2
	movq	%r13, %rdx
	movq	%rbp, %r9
	movq	%rbx, %r8
	movapd	%xmm0, %xmm6
	movsd	0(%r13,%r12,8), %xmm10
	movl	%esi, %ecx
	mulsd	%xmm9, %xmm6
	movapd	%xmm6, %xmm0
	addsd	%xmm10, %xmm0
	movsd	%xmm0, 0(%r13,%r12,8)
	call	*%rdi
	movq	240(%rsp), %rax
	movsd	%xmm10, 0(%r13,%r12,8)
	movsd	(%rbx), %xmm0
	leaq	1(%r12), %rdx
	subsd	(%rax), %xmm0
	movq	248(%rsp), %rax
	divsd	%xmm6, %xmm0
	movsd	%xmm0, (%rax,%r12,8)
	cmpq	%r15, %r12
	jne	.L151
.L145:
	movaps	32(%rsp), %xmm6
	movaps	48(%rsp), %xmm7
	movaps	64(%rsp), %xmm8
	movaps	80(%rsp), %xmm9
	movaps	96(%rsp), %xmm10
	movaps	112(%rsp), %xmm11
	addq	$136, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L150:
	movq	%rdx, %r12
.L148:
	movsd	0(%r13,%r12,8), %xmm10
	movapd	%xmm6, %xmm0
	movapd	%xmm7, %xmm11
	divsd	(%r14,%r12,8), %xmm11
	call	sqrt
	movapd	%xmm11, %xmm1
	andpd	%xmm8, %xmm10
	movapd	%xmm10, %xmm0
	call	Rf_fmax2
	movq	%r13, %rdx
	movq	%rbp, %r9
	movq	%rbx, %r8
	mulsd	%xmm9, %xmm0
	movsd	0(%r13,%r12,8), %xmm11
	movl	%esi, %ecx
	movapd	%xmm0, %xmm10
	addsd	%xmm11, %xmm0
	movsd	%xmm0, 0(%r13,%r12,8)
	call	*%rdi
	movq	240(%rsp), %rax
	movsd	%xmm11, 0(%r13,%r12,8)
	movsd	(%rbx), %xmm0
	leaq	1(%r12), %rdx
	subsd	(%rax), %xmm0
	movq	248(%rsp), %rax
	divsd	%xmm10, %xmm0
	movsd	%xmm0, (%rax,%r12,8)
	cmpq	%r15, %r12
	jne	.L150
	jmp	.L145
	.seh_endproc
	.p2align 4,,15
	.globl	fdhess
	.def	fdhess;	.scl	2;	.type	32;	.endef
	.seh_proc	fdhess
fdhess:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$216, %rsp
	.seh_stackalloc	216
	movaps	%xmm6, 128(%rsp)
	.seh_savexmm	%xmm6, 128
	movaps	%xmm7, 144(%rsp)
	.seh_savexmm	%xmm7, 144
	movaps	%xmm8, 160(%rsp)
	.seh_savexmm	%xmm8, 160
	movaps	%xmm9, 176(%rsp)
	.seh_savexmm	%xmm9, 176
	movaps	%xmm10, 192(%rsp)
	.seh_savexmm	%xmm10, 192
	.seh_endprologue
	movsd	.LC7(%rip), %xmm0
	pxor	%xmm1, %xmm1
	movq	344(%rsp), %r13
	movq	352(%rsp), %rdi
	movq	368(%rsp), %rbx
	movq	%rdx, %rsi
	movl	360(%rsp), %edx
	movl	%ecx, %ebp
	movapd	%xmm2, %xmm7
	movq	%r9, %r12
	negl	%edx
	cvtsi2sd	%edx, %xmm1
	divsd	.LC6(%rip), %xmm1
	call	pow
	movapd	%xmm0, %xmm8
	testl	%ebp, %ebp
	jle	.L152
	leal	-1(%rbp), %eax
	xorl	%r15d, %r15d
	pxor	%xmm9, %xmm9
	movq	.LC8(%rip), %xmm10
	movq	%rax, 72(%rsp)
	leaq	8(,%rax,8), %r14
	.p2align 4,,10
.L154:
	movsd	(%rbx,%r15), %xmm1
	movsd	(%rsi,%r15), %xmm0
	call	Rf_fmax2
	mulsd	%xmm8, %xmm0
	movsd	%xmm0, 0(%r13,%r15)
	comisd	(%rbx,%r15), %xmm9
	ja	.L166
	movsd	(%rsi,%r15), %xmm6
	leaq	(%rdi,%r15), %r8
	movq	%rsi, %rdx
	movl	%ebp, %ecx
	movq	320(%rsp), %r9
	addsd	%xmm6, %xmm0
	movsd	%xmm0, (%rsi,%r15)
	subsd	%xmm6, %xmm0
	movsd	%xmm0, 0(%r13,%r15)
	call	*%r12
	movsd	%xmm6, (%rsi,%r15)
	addq	$8, %r15
	cmpq	%r15, %r14
	jne	.L154
.L158:
	movslq	336(%rsp), %rdx
	xorl	%r15d, %r15d
	movq	%rdi, %r14
	leaq	8(,%rdx,8), %rax
	negq	%rdx
	movq	%rax, 96(%rsp)
	subq	$8, %rax
	movq	%rax, 40(%rsp)
	addq	328(%rsp), %rax
	movq	%rax, 56(%rsp)
	leaq	0(,%rdx,8), %rax
	movq	%rax, 80(%rsp)
	leaq	112(%rsp), %rax
	movq	%rax, 88(%rsp)
	leal	-2(%rbp), %eax
	movl	%eax, 108(%rsp)
	leaq	120(%rsp), %rax
	movq	%rax, 48(%rsp)
	.p2align 4,,10
.L162:
	movsd	(%rsi,%r15,8), %xmm8
	movq	88(%rsp), %r8
	movq	%rsi, %rdx
	movl	%ebp, %ecx
	movsd	0(%r13,%r15,8), %xmm0
	movq	320(%rsp), %r9
	addsd	%xmm0, %xmm0
	addsd	%xmm8, %xmm0
	movsd	%xmm0, (%rsi,%r15,8)
	call	*%r12
	movsd	(%r14,%r15,8), %xmm2
	movapd	%xmm7, %xmm3
	movq	56(%rsp), %rdi
	movsd	112(%rsp), %xmm0
	movsd	0(%r13,%r15,8), %xmm1
	subsd	%xmm2, %xmm3
	movq	80(%rsp), %rax
	subsd	%xmm2, %xmm0
	mulsd	%xmm1, %xmm1
	addsd	%xmm3, %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%rdi,%rax)
	movsd	0(%r13,%r15,8), %xmm0
	addsd	%xmm8, %xmm0
	movsd	%xmm0, (%rsi,%r15,8)
	cmpq	72(%rsp), %r15
	je	.L159
	movl	108(%rsp), %edx
	leaq	1(%r15), %rbx
	movq	%r14, 352(%rsp)
	movq	%r15, %r14
	movq	%rbx, 64(%rsp)
	subl	%r15d, %edx
	leaq	2(%r15,%rdx), %rax
	movq	%r13, %r15
	movq	%r12, %r13
	movl	%ebp, %r12d
	movq	%rax, 32(%rsp)
	movq	352(%rsp), %rbp
	.p2align 4,,10
.L160:
	movsd	(%rsi,%rbx,8), %xmm6
	movq	48(%rsp), %r8
	movq	%rsi, %rdx
	movl	%r12d, %ecx
	movsd	(%r15,%rbx,8), %xmm0
	movq	320(%rsp), %r9
	addsd	%xmm6, %xmm0
	movsd	%xmm0, (%rsi,%rbx,8)
	call	*%r13
	movsd	120(%rsp), %xmm0
	movapd	%xmm7, %xmm1
	subsd	0(%rbp,%rbx,8), %xmm0
	subsd	0(%rbp,%r14,8), %xmm1
	addsd	%xmm1, %xmm0
	movsd	(%r15,%r14,8), %xmm1
	mulsd	(%r15,%rbx,8), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%rdi)
	addq	40(%rsp), %rdi
	movsd	%xmm6, (%rsi,%rbx,8)
	addq	$1, %rbx
	cmpq	%rbx, 32(%rsp)
	jne	.L160
	movq	%rbp, 352(%rsp)
	movl	%r12d, %ebp
	movq	%r13, %r12
	movq	%r15, %r13
	movq	%r14, %r15
	movq	96(%rsp), %rcx
	movq	352(%rsp), %r14
	movsd	%xmm8, (%rsi,%r15,8)
	movq	64(%rsp), %r15
	addq	%rcx, 56(%rsp)
	jmp	.L162
	.p2align 4,,10
.L166:
	movapd	%xmm0, %xmm1
	leaq	(%rdi,%r15), %r8
	movq	%rsi, %rdx
	movl	%ebp, %ecx
	xorpd	%xmm10, %xmm1
	movq	320(%rsp), %r9
	movsd	%xmm1, 0(%r13,%r15)
	movsd	(%rsi,%r15), %xmm6
	movapd	%xmm6, %xmm4
	subsd	%xmm0, %xmm4
	movapd	%xmm4, %xmm0
	movsd	%xmm4, (%rsi,%r15)
	subsd	%xmm6, %xmm0
	movsd	%xmm0, 0(%r13,%r15)
	call	*%r12
	movsd	%xmm6, (%rsi,%r15)
	addq	$8, %r15
	cmpq	%r14, %r15
	jne	.L154
	jmp	.L158
	.p2align 4,,10
.L159:
	movsd	%xmm8, (%rsi,%r15,8)
.L152:
	movaps	128(%rsp), %xmm6
	movaps	144(%rsp), %xmm7
	movaps	160(%rsp), %xmm8
	movaps	176(%rsp), %xmm9
	movaps	192(%rsp), %xmm10
	addq	$216, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC13:
	.ascii "iteration = %d\12\0"
.LC14:
	.ascii "Parameter:\12\0"
.LC15:
	.ascii "Function Value\12\0"
.LC16:
	.ascii "Gradient:\12\0"
.LC17:
	.ascii "\12\0"
.LC18:
	.ascii "Step:\12\0"
	.text
	.p2align 4,,15
	.globl	optif9
	.def	optif9;	.scl	2;	.type	32;	.endef
	.seh_proc	optif9
optif9:
	pushq	%r15
	.seh_pushreg	%r15
	pushq	%r14
	.seh_pushreg	%r14
	pushq	%r13
	.seh_pushreg	%r13
	pushq	%r12
	.seh_pushreg	%r12
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rdi
	.seh_pushreg	%rdi
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$1112, %rsp
	.seh_stackalloc	1112
	movaps	%xmm6, 944(%rsp)
	.seh_savexmm	%xmm6, 944
	movaps	%xmm7, 960(%rsp)
	.seh_savexmm	%xmm7, 960
	movaps	%xmm8, 976(%rsp)
	.seh_savexmm	%xmm8, 976
	movaps	%xmm9, 992(%rsp)
	.seh_savexmm	%xmm9, 992
	movaps	%xmm10, 1008(%rsp)
	.seh_savexmm	%xmm10, 1008
	movaps	%xmm11, 1024(%rsp)
	.seh_savexmm	%xmm11, 1024
	movaps	%xmm12, 1040(%rsp)
	.seh_savexmm	%xmm12, 1040
	movaps	%xmm13, 1056(%rsp)
	.seh_savexmm	%xmm13, 1056
	movaps	%xmm14, 1072(%rsp)
	.seh_savexmm	%xmm14, 1072
	movaps	%xmm15, 1088(%rsp)
	.seh_savexmm	%xmm15, 1088
	.seh_endprologue
	movq	1392(%rsp), %rax
	movq	1240(%rsp), %r12
	movsd	1312(%rsp), %xmm12
	movq	1376(%rsp), %r15
	movl	$0, (%rax)
	movl	1256(%rsp), %eax
	subl	$1, %eax
	movl	%ecx, 1184(%rsp)
	movslq	%edx, %r13
	cmpl	$2, %eax
	movl	$1, %eax
	cmovbe	1256(%rsp), %eax
	movq	%r8, 1200(%rsp)
	movq	%r9, 1208(%rsp)
	movl	%eax, 1256(%rsp)
	movq	1272(%rsp), %rax
	movl	$0, 880(%rsp)
	movl	(%rax), %ecx
	movl	%ecx, %edx
	shrl	$31, %edx
	addl	%ecx, %edx
	movl	%edx, %eax
	shrl	$31, %edx
	sarl	%eax
	addl	%edx, %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	jne	.L169
	cmpl	$1, 1296(%rsp)
	jne	.L1315
.L169:
	testl	%ecx, %ecx
	leal	3(%rcx), %edx
	cmovns	%ecx, %edx
	movl	%edx, %eax
	shrl	$31, %edx
	sarl	$2, %eax
	addl	%edx, %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	jne	.L171
	cmpl	$1, 1304(%rsp)
	jne	.L1316
.L171:
	testl	%r13d, %r13d
	jle	.L1317
	cmpl	$1, %r13d
	je	.L1318
.L174:
	movl	1184(%rsp), %eax
	movq	1384(%rsp), %r14
	pxor	%xmm11, %xmm11
	movsd	.LC0(%rip), %xmm2
	movq	.LC8(%rip), %xmm5
	leal	(%rax,%rax,2), %ebx
	leal	-1(%r13), %eax
	movsd	.LC9(%rip), %xmm4
	movslq	%ebx, %rbx
	movl	%eax, 356(%rsp)
	leaq	1(%rax), %rsi
	movapd	%xmm2, %xmm1
	salq	$3, %rbx
	movq	%rax, 272(%rsp)
	xorl	%eax, %eax
	addq	%rbx, %r14
	jmp	.L179
	.p2align 4,,10
.L1320:
	jne	.L175
	movsd	%xmm1, (%r12,%rax,8)
	movapd	%xmm1, %xmm0
.L177:
	movsd	%xmm0, (%r14,%rax,8)
	leaq	1(%rax), %rdx
	cmpq	272(%rsp), %rax
	je	.L1319
	movq	%rdx, %rax
.L179:
	movsd	(%r12,%rax,8), %xmm0
	ucomisd	%xmm11, %xmm0
	jnp	.L1320
.L175:
	comisd	%xmm0, %xmm11
	ja	.L178
	movapd	%xmm2, %xmm3
	divsd	%xmm0, %xmm3
	movapd	%xmm3, %xmm0
	jmp	.L177
	.p2align 4,,10
.L178:
	movapd	%xmm0, %xmm3
	xorpd	%xmm5, %xmm3
	movsd	%xmm3, (%r12,%rax,8)
	movapd	%xmm4, %xmm3
	divsd	%xmm0, %xmm3
	movapd	%xmm3, %xmm0
	jmp	.L177
	.p2align 4,,10
.L1319:
	comisd	1328(%rsp), %xmm11
	jnb	.L1321
	movsd	1248(%rsp), %xmm4
	ucomisd	%xmm11, %xmm4
	jp	.L892
.L1342:
	jne	.L892
	movsd	.LC0(%rip), %xmm4
	movsd	%xmm4, 1248(%rsp)
.L186:
	comisd	1320(%rsp), %xmm11
	ja	.L1322
.L1254:
	movl	1288(%rsp), %eax
	testl	%eax, %eax
	jle	.L1323
	movl	1280(%rsp), %eax
	testl	%eax, %eax
	je	.L1324
	movl	$15, %eax
	cmovns	1280(%rsp), %eax
	comisd	%xmm12, %xmm11
	movl	%eax, 1280(%rsp)
	jnb	.L810
	movsd	1328(%rsp), %xmm5
	minsd	%xmm12, %xmm5
	movapd	%xmm5, %xmm12
.L194:
	movq	1272(%rsp), %rax
	movl	(%rax), %edx
	testl	%edx, %edx
	js	.L167
	movl	1184(%rsp), %eax
	xorl	%edx, %edx
	leaq	0(,%rsi,8), %r8
	addl	%eax, %eax
	cltq
	salq	$3, %rax
	movq	%rax, 144(%rsp)
	movslq	1184(%rsp), %rax
	movq	%rax, 248(%rsp)
	negq	%rax
	leaq	(%r14,%rax,8), %rax
	movq	%rax, %rcx
	movq	%rax, 264(%rsp)
	call	memset
	pxor	%xmm1, %xmm1
	movsd	.LC7(%rip), %xmm0
	cvtsi2sd	1280(%rsp), %xmm1
	xorpd	.LC8(%rip), %xmm1
	call	pow
	movsd	.LC11(%rip), %xmm1
	call	Rf_fmax2
	sqrtsd	%xmm0, %xmm5
	ucomisd	%xmm0, %xmm11
	movsd	%xmm0, 360(%rsp)
	movsd	%xmm5, 688(%rsp)
	ja	.L1325
.L196:
	movq	248(%rsp), %rax
	movq	264(%rsp), %rsi
	movsd	688(%rsp), %xmm1
	movsd	.LC12(%rip), %xmm0
	addq	%rbx, %rsi
	leaq	0(,%rax,8), %rbx
	salq	$5, %rax
	movq	%rsi, 128(%rsp)
	subq	%rax, %rsi
	movq	%rbx, 136(%rsp)
	leaq	920(%rsp), %rbx
	movq	%rsi, 112(%rsp)
	call	Rf_fmax2
	movq	1232(%rsp), %r9
	movq	%rbx, %r8
	movl	%r13d, %ecx
	movapd	%xmm0, %xmm7
	movq	1200(%rsp), %rdx
	call	*1208(%rsp)
	cmpl	$1, 1296(%rsp)
	jne	.L1326
	movq	1200(%rsp), %rdx
	movq	1232(%rsp), %r9
	movl	%r13d, %ecx
	movq	112(%rsp), %r8
	call	*1216(%rsp)
	movq	1272(%rsp), %rax
	movl	(%rax), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	testb	$2, %al
	je	.L1327
.L198:
	movl	1288(%rsp), %eax
	movq	%r14, 72(%rsp)
	movl	%r13d, %ecx
	movsd	1248(%rsp), %xmm4
	movl	$0, 104(%rsp)
	movl	%eax, 88(%rsp)
	leaq	880(%rsp), %rax
	movsd	1336(%rsp), %xmm5
	movsd	%xmm4, 80(%rsp)
	movq	1200(%rsp), %rdx
	movsd	1320(%rsp), %xmm4
	movq	%rax, 48(%rsp)
	movq	112(%rsp), %r9
	movq	%rax, 792(%rsp)
	movq	1392(%rsp), %rax
	movsd	920(%rsp), %xmm2
	movsd	%xmm5, 64(%rsp)
	movl	$-1, 96(%rsp)
	movsd	%xmm4, 56(%rsp)
	movl	(%rax), %eax
	movl	%eax, 40(%rsp)
	movq	128(%rsp), %rax
	movq	%rax, 32(%rsp)
	call	opt_stop.isra.0
	movq	248(%rsp), %rdx
	movq	1368(%rsp), %rbx
	negq	%rdx
	movl	%eax, (%rbx)
	salq	$4, %rdx
	movq	%rdx, 368(%rsp)
	testl	%eax, %eax
	jne	.L1328
	movq	248(%rsp), %rax
	movq	112(%rsp), %rbx
	movl	1264(%rsp), %ebp
	leaq	(%rax,%rax,4), %rax
	leaq	(%rbx,%rax,8), %rax
	movq	%rax, 160(%rsp)
	testl	%ebp, %ebp
	jne	.L1329
	cmpl	$1, 1304(%rsp)
	je	.L220
	cmpl	$1, 1296(%rsp)
	jne	.L221
	movq	128(%rsp), %rax
	movq	%r14, 64(%rsp)
	movl	%r13d, %r8d
	movl	%r13d, %edx
	movsd	360(%rsp), %xmm5
	movl	$3, 88(%rsp)
	movq	%rax, 80(%rsp)
	movq	112(%rsp), %rax
	movq	%r15, 56(%rsp)
	movq	1200(%rsp), %r9
	movq	%rax, 48(%rsp)
	movq	1232(%rsp), %rax
	movl	1184(%rsp), %ecx
	movsd	%xmm5, 72(%rsp)
	movq	%rax, 40(%rsp)
	movq	1216(%rsp), %rax
	movq	%rax, 32(%rsp)
	call	fstofd
	movq	248(%rsp), %rsi
	movq	1272(%rsp), %rax
	leaq	1(%rsi), %rbx
	leaq	8(%r15), %rsi
	movl	(%rax), %eax
	movq	%rbx, 432(%rsp)
	movl	1184(%rsp), %ebx
	movq	%rsi, 312(%rsp)
	leal	1(%rbx), %esi
	movq	136(%rsp), %rbx
	movl	%esi, 612(%rsp)
	leaq	(%r15,%rbx), %rsi
	movq	%rsi, 704(%rsp)
	.p2align 4,,10
.L219:
	movq	1392(%rsp), %rsi
	leal	7(%rax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	movl	(%rsi), %esi
	movl	%esi, 320(%rsp)
	testb	$8, %al
	je	.L1260
	leaq	936(%rsp), %rax
	movq	%rax, 224(%rsp)
	movslq	%r13d, %rax
	movq	%rax, 736(%rsp)
.L239:
	movq	248(%rsp), %rsi
	movq	136(%rsp), %r11
	pxor	%xmm14, %xmm14
	movapd	%xmm12, %xmm10
	movq	160(%rsp), %rbx
	movl	1264(%rsp), %edi
	movapd	%xmm14, %xmm12
	leaq	0(,%rsi,4), %rax
	movq	%rsi, %rdx
	leaq	16(%r11), %r9
	subq	%rax, %rdx
	addq	%r11, %rbx
	xorl	%eax, %eax
	movq	%r9, 336(%rsp)
	salq	$3, %rdx
	cmpl	$1, 1296(%rsp)
	movq	%rbx, 344(%rsp)
	sete	%al
	cmpl	$3, 1256(%rsp)
	leaq	(%rbx,%rdx), %r10
	setne	%cl
	testl	%edi, %edi
	movl	%eax, 352(%rsp)
	setne	%al
	movq	%r10, 496(%rsp)
	andl	%eax, %ecx
	movq	736(%rsp), %rax
	movb	%cl, 857(%rsp)
	salq	$3, %rax
	cmpl	$3, 356(%rsp)
	movq	%rax, 640(%rsp)
	movl	1184(%rsp), %eax
	seta	304(%rsp)
	movzbl	304(%rsp), %r8d
	leal	0(,%rax,4), %ebx
	movl	1184(%rsp), %eax
	addl	%ebx, %eax
	movslq	%ebx, %rbx
	cltq
	leaq	16(,%rax,8), %rcx
	leaq	0(,%rax,8), %rdi
	cmpq	%r11, %rcx
	movq	%rcx, 208(%rsp)
	setle	%cl
	cmpq	%rdi, %r9
	setle	%al
	addq	%r10, %rdx
	movq	%rdx, 232(%rsp)
	movl	%r13d, %edx
	orl	%eax, %ecx
	shrl	%edx
	andl	%r8d, %ecx
	salq	$4, %rdx
	movb	%cl, 856(%rsp)
	movq	1384(%rsp), %rcx
	movq	%rdx, 288(%rsp)
	movl	%r13d, %edx
	andl	$-2, %edx
	addq	%rdi, %rcx
	movl	%edx, %r9d
	movl	%edx, 472(%rsp)
	leaq	0(,%r9,8), %r10
	movq	112(%rsp), %r9
	movq	%rcx, 216(%rsp)
	movq	%r10, 520(%rsp)
	movq	%r9, %rdx
	addq	%r10, %rdx
	movq	%rdx, 656(%rsp)
	movq	128(%rsp), %rdx
	leaq	(%rdx,%r10), %rbp
	movq	%rbp, 664(%rsp)
	movl	1184(%rsp), %ebp
	leal	(%rbp,%rbp), %ecx
	movl	1184(%rsp), %ebp
	movq	1384(%rsp), %r12
	movq	1384(%rsp), %r10
	addl	%ecx, %ebp
	movslq	%ecx, %rcx
	movl	%ebp, %r8d
	movslq	%ebp, %rbp
	leaq	0(,%rbp,8), %rdx
	movq	%rbp, 624(%rsp)
	addq	%rdx, %r12
	movq	%r12, 152(%rsp)
	leaq	0(,%rcx,8), %r12
	leaq	16(,%rcx,8), %rcx
	addq	%r12, %r10
	testl	%r13d, %r13d
	movq	%rcx, 296(%rsp)
	movq	%rdi, %rcx
	movq	%r10, 168(%rsp)
	movl	$1, %r10d
	cmovg	%r13d, %r10d
	movq	%rcx, 512(%rsp)
	movl	%r10d, 184(%rsp)
	shrl	%r10d
	salq	$4, %r10
	movq	%r10, 176(%rsp)
	movl	184(%rsp), %r10d
	andl	$-2, %r10d
	movl	%r10d, 192(%rsp)
	leaq	8(%r11), %r10
	movq	%r10, 200(%rsp)
	movq	%rbp, %r10
	subq	%rsi, %r10
	leaq	0(,%r10,8), %rsi
	movq	%rsi, 600(%rsp)
	leaq	16(,%rbp,8), %rsi
	movq	208(%rsp), %rbp
	cmpq	%rbp, %r11
	setge	%r10b
	orl	%r10d, %eax
	cmpq	%rdi, %rsi
	movl	%eax, %r11d
	setle	%al
	cmpq	%rbp, %rdx
	setge	%r10b
	movb	%r11b, 532(%rsp)
	orl	%r10d, %eax
	andl	%r11d, %eax
	cmpl	$1, %r13d
	setg	%r10b
	addl	%r8d, %r8d
	andl	%r10d, %eax
	movq	128(%rsp), %r10
	movslq	%r8d, %r8
	movb	%al, 655(%rsp)
	movl	192(%rsp), %eax
	salq	$3, %rax
	leaq	(%r9,%rax), %rbp
	movq	%rbp, 488(%rsp)
	leaq	(%r14,%rax), %rbp
	movq	%rbp, 480(%rsp)
	leaq	(%r10,%rax), %rbp
	movq	%r8, %r10
	leaq	0(,%r8,8), %r8
	leaq	16(,%r10,8), %r9
	cmpq	%rsi, %r8
	movq	%r10, 464(%rsp)
	setge	%r11b
	cmpq	%rdx, %r9
	movq	%rbp, 576(%rsp)
	setle	%r10b
	movq	%r9, 240(%rsp)
	orl	%r10d, %r11d
	cmpq	208(%rsp), %r8
	movb	%r11b, 529(%rsp)
	setge	%r11b
	cmpq	%rdi, %r9
	setle	%r10b
	movl	%r11d, %edi
	leaq	0(,%rbx,8), %r11
	orl	%r10d, %edi
	movq	1384(%rsp), %r10
	movb	%dil, 530(%rsp)
	addq	%r8, %r10
	cmpq	%rsi, %r11
	movq	%r10, 256(%rsp)
	leaq	16(,%rbx,8), %r10
	setge	%dil
	cmpq	%rdx, %r10
	movl	%edi, %ebp
	setle	%dl
	orl	%edx, %ebp
	cmpq	%rcx, %r10
	setle	%dil
	cmpq	208(%rsp), %r11
	movb	%bpl, 531(%rsp)
	setge	%dl
	movl	%edi, %r9d
	orl	%edx, %r9d
	cmpq	%r8, %r10
	setle	%dil
	cmpq	240(%rsp), %r11
	movb	%r9b, 478(%rsp)
	setge	%dl
	movl	%edi, %ebp
	orl	%edx, %ebp
	movb	%bpl, 610(%rsp)
	movq	1384(%rsp), %rdx
	movq	496(%rsp), %r9
	addq	%r11, %rdx
	cmpq	296(%rsp), %r11
	setge	%dil
	cmpq	%r12, %r10
	movq	%rdx, %rbp
	setle	%dl
	orl	%edx, %edi
	cmpl	$4, %r13d
	movl	%edi, %edx
	movb	%dil, 654(%rsp)
	setg	%dil
	andl	%edi, %edx
	movb	%dl, 608(%rsp)
	movq	264(%rsp), %rdx
	leaq	(%rdx,%rax), %rcx
	movq	1384(%rsp), %rdx
	movq	%rcx, 384(%rsp)
	leaq	(%r9,%rax), %rcx
	addq	%r10, %rdx
	movq	%rcx, 280(%rsp)
	movq	1344(%rsp), %rcx
	movq	%rdx, %r9
	cmpq	%r9, %rcx
	leaq	16(%rcx), %rdx
	movq	%r9, 448(%rsp)
	setnb	144(%rsp)
	cmpq	%rbp, %rdx
	movzbl	144(%rsp), %ecx
	movq	%rdx, 408(%rsp)
	setbe	%dl
	movl	%edx, %r9d
	movq	%rbp, 144(%rsp)
	movq	408(%rsp), %rbp
	orl	%ecx, %r9d
	movq	1200(%rsp), %rcx
	movb	%r9b, 456(%rsp)
	leaq	16(%rcx), %rdx
	cmpq	%rdx, 1344(%rsp)
	setnb	392(%rsp)
	cmpq	%rbp, %rcx
	movzbl	392(%rsp), %ebp
	setnb	400(%rsp)
	movzbl	400(%rsp), %ecx
	orl	%ecx, %ebp
	movl	1184(%rsp), %ecx
	andl	%ebp, %edi
	movb	%bpl, 609(%rsp)
	andl	%r9d, %edi
	movq	432(%rsp), %r9
	movb	%dil, 479(%rsp)
	movq	1200(%rsp), %rdi
	salq	$3, %r9
	addq	%rax, %rdi
	movq	%r9, 504(%rsp)
	movq	%rdi, 392(%rsp)
	movq	1344(%rsp), %rdi
	addq	%rax, %rdi
	movq	%rdi, 400(%rsp)
	leal	0(,%rcx,8), %edi
	subl	%ecx, %edi
	movslq	%edi, %rdi
	movq	%rdi, 416(%rsp)
	leaq	16(,%rdi,8), %rbp
	salq	$3, %rdi
	movq	%rdi, 776(%rsp)
	addq	1384(%rsp), %rdi
	movq	%rbp, %rcx
	movq	%rdi, 584(%rsp)
	movq	%rdi, %rbp
	movq	1384(%rsp), %rdi
	movq	%rcx, 440(%rsp)
	addq	%rcx, %rdi
	cmpq	%rdi, 1344(%rsp)
	movq	%rbp, %rdi
	movq	408(%rsp), %rbp
	setnb	432(%rsp)
	movzbl	432(%rsp), %ecx
	cmpq	%rbp, %rdi
	setnb	%dil
	orl	%ecx, %edi
	movb	%dil, 611(%rsp)
	movq	296(%rsp), %rdi
	addq	1384(%rsp), %rdi
	cmpq	%rdi, 1344(%rsp)
	setnb	432(%rsp)
	cmpq	168(%rsp), %rbp
	movzbl	432(%rsp), %ebp
	setbe	477(%rsp)
	movzbl	477(%rsp), %ecx
	orl	%ecx, %ebp
	cmpq	%r8, 296(%rsp)
	setle	296(%rsp)
	cmpq	%r12, 240(%rsp)
	movzbl	296(%rsp), %ecx
	setle	%r12b
	movb	%bpl, 528(%rsp)
	movzbl	529(%rsp), %ebp
	orl	%ecx, %r12d
	andl	%r12d, %ebp
	cmpl	$2, %r13d
	setg	%r12b
	movb	%bpl, 651(%rsp)
	movl	%r12d, %ecx
	movl	%ebp, %r12d
	andl	%r12d, %ecx
	movq	160(%rsp), %r12
	movb	%cl, 653(%rsp)
	leaq	(%r12,%rax), %rcx
	movq	%r9, %r12
	subq	$8, %r12
	cmpq	240(%rsp), %r12
	movq	%r9, %r12
	movq	%rcx, 592(%rsp)
	setge	296(%rsp)
	addq	$8, %r12
	movzbl	296(%rsp), %ebp
	cmpq	%r8, %r12
	setle	%r12b
	movl	%r12d, %ecx
	movl	%ebp, %r12d
	orl	%r12d, %ecx
	movb	%cl, 652(%rsp)
	movq	1384(%rsp), %rcx
	movq	248(%rsp), %r9
	movq	408(%rsp), %rbp
	leaq	8(%rcx,%rbx,8), %rbx
	movq	%rbx, 680(%rsp)
	movq	%r9, %rbx
	salq	$4, %rbx
	movq	%rbx, 296(%rsp)
	movq	208(%rsp), %rbx
	addq	%rcx, %rbx
	cmpq	%rbx, 1344(%rsp)
	setnb	248(%rsp)
	cmpq	216(%rsp), %rbp
	movzbl	248(%rsp), %ecx
	setbe	%r12b
	movq	624(%rsp), %rbp
	movq	%r9, 248(%rsp)
	orl	%ecx, %r12d
	movb	%r12b, 477(%rsp)
	leaq	(%r9,%r9,2), %r12
	movq	200(%rsp), %r9
	subq	%r12, %rbp
	leaq	0(,%rbp,8), %rcx
	movq	%rcx, 672(%rsp)
	movslq	612(%rsp), %rcx
	movq	%rcx, 816(%rsp)
	salq	$3, %rcx
	movq	%rcx, 800(%rsp)
	addq	%r15, %rcx
	movq	%rcx, 808(%rsp)
	leaq	(%r15,%r9), %rcx
	movq	%rcx, 784(%rsp)
	movq	1384(%rsp), %rcx
	addq	%rsi, %rcx
	cmpq	168(%rsp), %rdx
	setbe	%sil
	cmpq	%rdi, 1200(%rsp)
	movq	%rcx, 432(%rsp)
	setnb	%dil
	movzbl	304(%rsp), %ecx
	orl	%edi, %esi
	andb	528(%rsp), %sil
	andl	%esi, %ecx
	movq	520(%rsp), %rsi
	movb	%cl, 858(%rsp)
	movq	1344(%rsp), %rcx
	addq	%rsi, %rcx
	movq	%rcx, 720(%rsp)
	movq	1200(%rsp), %rcx
	addq	%rsi, %rcx
	movq	%rcx, 728(%rsp)
	movq	264(%rsp), %rcx
	movq	216(%rsp), %rdi
	movq	136(%rsp), %r12
	addq	%rsi, %rcx
	cmpl	$3, %r13d
	movq	%rcx, 712(%rsp)
	movq	1360(%rsp), %rcx
	setg	649(%rsp)
	cmpq	%rdi, %rdx
	leaq	16(%rcx), %r9
	setbe	%sil
	cmpq	%rbx, 1200(%rsp)
	movq	%r9, %rbp
	movq	%r9, 864(%rsp)
	setnb	%r9b
	orl	%esi, %r9d
	cmpq	%rdi, %rbp
	movq	144(%rsp), %rdi
	setbe	%sil
	cmpq	%rbx, %rcx
	movzbl	649(%rsp), %ecx
	setnb	%bl
	orl	%esi, %ebx
	cmpq	336(%rsp), %r11
	setge	%r11b
	cmpq	%r12, %r10
	setle	%r10b
	orl	%r11d, %r10d
	andb	478(%rsp), %r10b
	andl	%r10d, %ecx
	cmpq	%rdi, %rdx
	movl	%ecx, %esi
	setbe	%r10b
	movq	448(%rsp), %rcx
	cmpq	%rcx, 1200(%rsp)
	setnb	%r11b
	orl	%r11d, %r10d
	andl	%esi, %r10d
	movzbl	456(%rsp), %esi
	andl	%r10d, %esi
	cmpq	%rdi, %rbp
	setbe	%r10b
	cmpq	%rcx, 1360(%rsp)
	setnb	%r11b
	orl	%r11d, %r10d
	andl	%esi, %r10d
	movzbl	532(%rsp), %esi
	movl	%esi, %r11d
	andl	%r11d, %r10d
	movq	208(%rsp), %r11
	andl	%r9d, %r10d
	andb	477(%rsp), %r10b
	movl	%r10d, %ecx
	movq	368(%rsp), %r10
	andl	%ebx, %ecx
	movb	%cl, 860(%rsp)
	movq	1360(%rsp), %rcx
	addq	%r14, %r10
	movq	%r10, 632(%rsp)
	addq	%rax, %rcx
	movq	440(%rsp), %rax
	cmpq	512(%rsp), %rax
	setle	%al
	cmpq	%r11, 776(%rsp)
	movq	%r12, %r11
	movq	%rcx, 696(%rsp)
	setge	%r10b
	movl	%eax, %ecx
	orl	%r10d, %ecx
	movb	%cl, 862(%rsp)
	movq	312(%rsp), %rcx
	addq	%r12, %rcx
	movq	%rcx, 848(%rsp)
	movl	1184(%rsp), %ecx
	negl	%ecx
	movslq	%ecx, %rax
	leaq	-8(,%rax,8), %rcx
	movq	%rcx, 824(%rsp)
	movq	240(%rsp), %rdi
	movzbl	530(%rsp), %r10d
	movq	1384(%rsp), %rcx
	movzbl	649(%rsp), %r12d
	andl	%esi, %r10d
	addq	%rdi, %rcx
	movq	248(%rsp), %rsi
	andl	%r12d, %r10d
	movq	%rcx, %rax
	andl	%r9d, %r10d
	andb	477(%rsp), %r10b
	andl	%ebx, %r10d
	cmpq	%r8, 336(%rsp)
	setle	%bl
	cmpq	%rdi, %r11
	movq	256(%rsp), %r11
	movq	408(%rsp), %rdi
	setge	%cl
	orl	%ecx, %ebx
	andl	%ebx, %r10d
	cmpq	%r11, %rdx
	setbe	%r8b
	cmpq	%rax, 1200(%rsp)
	setnb	%cl
	orl	%ecx, %r8d
	andl	%r8d, %r10d
	cmpq	%r11, %rdi
	setbe	%cl
	cmpq	%rax, 1344(%rsp)
	setnb	%bl
	orl	%ebx, %ecx
	andl	%ecx, %r10d
	cmpq	%r11, %rbp
	setbe	%bl
	cmpq	%rax, 1360(%rsp)
	movq	464(%rsp), %rax
	setnb	%cl
	orl	%ecx, %ebx
	movl	%r10d, %ecx
	andl	%ebx, %ecx
	movb	%cl, 861(%rsp)
	leaq	0(,%rsi,8), %rcx
	subq	%rsi, %rcx
	subq	%rcx, %rax
	leaq	0(,%rax,8), %rbx
	movq	416(%rsp), %rax
	movq	%rbx, 832(%rsp)
	subq	%rcx, %rax
	salq	$3, %rax
	movq	%rax, 840(%rsp)
	movq	1384(%rsp), %rax
	leaq	16(%rax,%rsi,8), %rbx
	movq	632(%rsp), %rsi
	movq	%rbx, 872(%rsp)
	cmpq	%rdi, %rsi
	setnb	648(%rsp)
	cmpq	%rbp, %rsi
	movzbl	648(%rsp), %r11d
	setnb	650(%rsp)
	cmpq	%rbp, 1200(%rsp)
	movzbl	650(%rsp), %r10d
	setnb	%cl
	cmpq	%rdx, 1360(%rsp)
	setnb	%al
	movl	%ecx, %edi
	orl	%eax, %edi
	cmpq	%rdx, %rsi
	setnb	%al
	cmpq	%rbx, 1200(%rsp)
	movb	%dil, 863(%rsp)
	setnb	%dl
	andb	609(%rsp), %dil
	orl	%edx, %eax
	movl	%edi, %edx
	andl	%r12d, %edx
	andl	%edx, %eax
	cmpq	%rbx, 1344(%rsp)
	setnb	%dl
	orl	%r11d, %edx
	andl	%edx, %eax
	cmpq	%rbx, 1360(%rsp)
	setnb	%dl
	orl	%r10d, %edx
	andl	%edx, %eax
	movb	%al, 859(%rsp)
	leaq	912(%rsp), %rax
	movsd	%xmm11, 240(%rsp)
	movl	320(%rsp), %edx
	movq	%rax, 304(%rsp)
	leaq	908(%rsp), %rax
	movq	%rax, 464(%rsp)
	leaq	916(%rsp), %rax
	movq	%rax, 208(%rsp)
	movl	%r13d, 1192(%rsp)
	movq	%r14, %r13
	movl	1192(%rsp), %r14d
	movsd	%xmm11, 336(%rsp)
	movsd	%xmm11, 768(%rsp)
	movsd	%xmm11, 760(%rsp)
	movsd	%xmm11, 456(%rsp)
	movsd	%xmm11, 752(%rsp)
	movsd	%xmm11, 744(%rsp)
.L763:
	movq	1392(%rsp), %rax
	addl	$1, %edx
	cmpb	$0, 857(%rsp)
	movl	%edx, (%rax)
	jne	.L240
.L241:
	movq	152(%rsp), %rdx
	movq	%r15, %r11
	movq	%r15, %rcx
	xorl	%esi, %esi
	movl	%r14d, %ebx
	xorl	%r9d, %r9d
	movl	$8, %r12d
	.p2align 4,,10
.L797:
	leaq	16(%rdx), %r8
	movl	%r14d, %eax
	leaq	8(%rdx), %r10
	subl	%ebx, %eax
	cmpq	%r8, %rcx
	leaq	16(%rcx), %r8
	setnb	%dil
	cmpq	%r8, %rdx
	setnb	%r8b
	orl	%r8d, %edi
	cmpl	%eax, %r14d
	setg	%r8b
	cmpl	$1, %ebx
	setne	%bpl
	andl	%ebp, %r8d
	testb	%r8b, %dil
	je	.L897
	movl	%ebx, %r8d
	salq	$3, %r8
	cmpl	%eax, %r14d
	cmovle	%r12, %r8
	addq	%rcx, %r8
	cmpq	%r8, %rdx
	setnb	%dil
	cmpq	%r10, %rcx
	setnb	%r8b
	orb	%r8b, %dil
	je	.L897
	cmpl	%eax, %r14d
	movl	$1, %ebp
	movsd	0(%r13,%r9,8), %xmm1
	cmovg	%ebx, %ebp
	addq	672(%rsp), %rdx
	xorl	%r8d, %r8d
	unpcklpd	%xmm1, %xmm1
	movl	%ebp, %edi
	shrl	%edi
	salq	$4, %rdi
	.p2align 4,,10
.L242:
	movupd	(%rdx,%r8), %xmm0
	movupd	(%rcx,%r8), %xmm5
	mulpd	%xmm1, %xmm0
	divpd	%xmm0, %xmm5
	movups	%xmm5, (%rcx,%r8)
	addq	$16, %r8
	cmpq	%rdi, %r8
	jne	.L242
	movl	%ebp, %edx
	andl	$-2, %edx
	addl	%edx, %eax
	cmpl	%edx, %ebp
	je	.L245
	leal	(%rsi,%rax), %edx
	cltq
	movsd	0(%r13,%rax,8), %xmm1
	mulsd	0(%r13,%r9,8), %xmm1
	movslq	%edx, %rdx
	leaq	(%r15,%rdx,8), %rdx
	movsd	(%rdx), %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%rdx)
.L245:
	addq	$1, %r9
	addq	200(%rsp), %rcx
	movq	%r10, %rdx
	addq	136(%rsp), %r11
	addl	1184(%rsp), %esi
	subl	$1, %ebx
	jne	.L797
	movsd	(%r15), %xmm8
	cmpl	$1, %r14d
	jle	.L249
	movq	808(%rsp), %rdx
	movapd	%xmm8, %xmm6
	movl	$1, %eax
	movq	800(%rsp), %rcx
	.p2align 4,,10
.L254:
	movsd	(%rdx), %xmm0
	addl	$1, %eax
	addq	%rcx, %rdx
	movapd	%xmm0, %xmm5
	maxsd	%xmm6, %xmm0
	minsd	%xmm8, %xmm5
	movapd	%xmm0, %xmm6
	movapd	%xmm5, %xmm8
	cmpl	%eax, %r14d
	jne	.L254
	pxor	%xmm1, %xmm1
	call	Rf_fmax2
	movsd	.LC19(%rip), %xmm7
	movapd	%xmm0, %xmm1
	mulsd	%xmm7, %xmm1
	comisd	%xmm8, %xmm1
	jb	.L1330
	subsd	%xmm8, %xmm0
	mulsd	%xmm7, %xmm0
	subsd	%xmm8, %xmm0
	ucomisd	%xmm11, %xmm0
	jp	.L942
	jne	.L942
	movq	312(%rsp), %r8
	movq	136(%rsp), %r9
	pxor	%xmm0, %xmm0
	movl	$1, %eax
	movq	.LC2(%rip), %xmm8
	.p2align 4,,10
.L262:
	movq	%r8, %rcx
	xorl	%edx, %edx
	.p2align 4,,10
.L261:
	movsd	(%rcx), %xmm1
	addl	$1, %edx
	addq	%r9, %rcx
	andpd	%xmm8, %xmm1
	maxsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	cmpl	%edx, %eax
	jne	.L261
	addl	$1, %eax
	addq	$8, %r8
	cmpl	%eax, %r14d
	jne	.L262
	ucomisd	%xmm11, %xmm1
	jnp	.L1331
.L787:
	mulsd	.LC20(%rip), %xmm0
	movapd	%xmm6, %xmm8
.L785:
	movq	200(%rsp), %rcx
	movq	%r15, %rax
	xorl	%edx, %edx
	.p2align 4,,10
.L264:
	movsd	(%rax), %xmm1
	addl	$1, %edx
	addsd	%xmm0, %xmm1
	movsd	%xmm1, (%rax)
	addq	%rcx, %rax
	cmpl	%edx, %r14d
	jne	.L264
	movapd	%xmm0, %xmm6
	movq	1384(%rsp), %rax
	movsd	(%r15), %xmm0
	addsd	%xmm8, %xmm6
	movsd	%xmm0, (%rax)
	cmpl	$1, %r14d
	jle	.L814
.L796:
	leal	-2(%r14), %r11d
	movq	312(%rsp), %r10
	movq	704(%rsp), %r9
	movl	$1, %edx
	movq	784(%rsp), %r8
	movq	136(%rsp), %rsi
	movq	%r11, %rdi
	addq	$2, %r11
	movq	1384(%rsp), %rbp
	.p2align 4,,10
.L267:
	movsd	(%r8), %xmm0
	movq	%r9, %rax
	movq	%r10, %rcx
	movsd	%xmm0, 0(%rbp,%rdx,8)
	.p2align 4,,10
.L266:
	movsd	(%rcx), %xmm0
	addq	$8, %rax
	addq	%rsi, %rcx
	movsd	%xmm0, -8(%rax)
	cmpq	%r8, %rax
	jne	.L266
	movq	200(%rsp), %rcx
	addq	$1, %rdx
	addq	$8, %r10
	addq	%rsi, %r9
	leaq	(%rax,%rcx), %r8
	cmpq	%r11, %rdx
	jne	.L267
	movsd	%xmm7, 32(%rsp)
	movapd	%xmm6, %xmm3
	movq	%r15, %r8
	movl	%r14d, %edx
	movq	224(%rsp), %rax
	movl	1184(%rsp), %ecx
	movq	%rax, 40(%rsp)
	call	choldc
	movsd	936(%rsp), %xmm1
	comisd	%xmm11, %xmm1
	jbe	.L270
	movl	1184(%rsp), %esi
	movq	1384(%rsp), %rax
	movq	%r13, 368(%rsp)
	xorl	%r9d, %r9d
	movq	704(%rsp), %r8
	movl	$1, %edx
	xorl	%ebp, %ebp
	movl	%ebx, 416(%rsp)
	movsd	(%rax), %xmm0
	leaq	2(%rdi), %rax
	movl	%r14d, 1192(%rsp)
	movl	%esi, %r11d
	movq	%rax, 320(%rsp)
	movq	136(%rsp), %r10
	movq	%r8, %rcx
	movsd	%xmm0, (%r15)
	.p2align 4,,10
.L276:
	testl	%r11d, %r11d
	movq	1384(%rsp), %rax
	movq	%rbp, %rdi
	movl	%edx, %ebx
	cmovs	%r9, %rdi
	movq	%r8, %r13
	movq	%rcx, %r14
	movl	%edx, %r12d
	movsd	(%rax,%rdx,8), %xmm0
	leaq	0(,%rdx,8), %rax
	subq	%r15, %r13
	addq	%rax, %rdi
	cmpq	%r13, %rdi
	movq	%rbp, %rdi
	movsd	%xmm0, 8(%r8)
	setg	%r13b
	testl	%r11d, %r11d
	cmovns	%r9, %rdi
	subq	%r15, %r14
	addq	%rax, %rdi
	cmpq	%r14, %rdi
	setl	%dil
	addq	%r15, %rax
	orb	%dil, %r13b
	je	.L273
	leal	-1(%rdx), %edi
	cmpl	$22, %edi
	jbe	.L273
	movl	%edx, %edi
	movq	%rcx, %r13
	shrl	%edi
	salq	$4, %rdi
	addq	%rcx, %rdi
	.p2align 4,,10
.L274:
	movupd	0(%r13), %xmm0
	addq	$16, %r13
	movlpd	%xmm0, (%rax)
	movhpd	%xmm0, (%rax,%r10)
	addq	296(%rsp), %rax
	cmpq	%rdi, %r13
	jne	.L274
	movl	%ebx, %eax
	andl	$-2, %eax
	cmpl	%ebx, %eax
	je	.L279
	leal	(%rsi,%rax), %ebx
	imull	%r11d, %eax
	movslq	%ebx, %rbx
	movsd	(%r15,%rbx,8), %xmm0
	addl	%r12d, %eax
	cltq
	movsd	%xmm0, (%r15,%rax,8)
.L279:
	addq	$1, %rdx
	addq	%r10, %rcx
	addl	%r11d, %esi
	addq	%r10, %r9
	addq	200(%rsp), %r8
	cmpq	320(%rsp), %rdx
	jne	.L276
	movq	368(%rsp), %r13
	movl	416(%rsp), %ebx
	movl	1192(%rsp), %r14d
.L272:
	movsd	(%r15), %xmm0
	movq	312(%rsp), %rdx
	pxor	%xmm2, %xmm2
	cmpl	$1, %r14d
	je	.L784
	cmpl	$2, %r14d
	je	.L816
	movl	356(%rsp), %eax
	movapd	.LC21(%rip), %xmm5
	pxor	%xmm2, %xmm2
	shrl	%eax
	salq	$4, %rax
	addq	312(%rsp), %rax
	.p2align 4,,10
.L281:
	movupd	(%rdx), %xmm3
	addq	$16, %rdx
	andpd	%xmm5, %xmm3
	addsd	%xmm3, %xmm2
	unpckhpd	%xmm3, %xmm3
	addsd	%xmm3, %xmm2
	cmpq	%rdx, %rax
	jne	.L281
	movl	356(%rsp), %esi
	movl	%esi, %edx
	andl	$-2, %edx
	leal	1(%rdx), %eax
	cmpl	%esi, %edx
	je	.L784
.L280:
	cltq
	movsd	(%r15,%rax,8), %xmm3
	andpd	.LC2(%rip), %xmm3
	addsd	%xmm3, %xmm2
.L784:
	movq	312(%rsp), %r9
	movsd	-8(%r9), %xmm3
	movapd	%xmm3, %xmm4
	subsd	%xmm2, %xmm4
	addsd	%xmm3, %xmm2
	maxsd	%xmm0, %xmm2
	minsd	%xmm11, %xmm4
	movapd	%xmm2, %xmm0
	cmpl	$1, %r14d
	je	.L287
	movq	816(%rsp), %rsi
	leal	-2(%r14), %ecx
	movq	248(%rsp), %rax
	movl	$1, %edx
	movl	1184(%rsp), %r10d
	movapd	.LC21(%rip), %xmm5
	leaq	-1(%rsi), %r11
	movq	200(%rsp), %rdi
	leaq	16(%r15,%rax,8), %r8
	movq	.LC2(%rip), %xmm8
	movq	136(%rsp), %rsi
	subq	%rax, %r11
	movl	%r10d, %ebp
	.p2align 4,,10
.L297:
	movq	%r9, %r12
	xorl	%eax, %eax
	pxor	%xmm2, %xmm2
	.p2align 4,,10
.L288:
	movsd	(%r12), %xmm3
	addl	$1, %eax
	addq	%rsi, %r12
	andpd	%xmm8, %xmm3
	addsd	%xmm3, %xmm2
	cmpl	%edx, %eax
	jl	.L288
	addl	$1, %edx
	cmpl	%edx, %r14d
	jle	.L289
	cmpl	$1, %ecx
	je	.L818
	movl	%ecx, %eax
	movq	%r8, %r12
	shrl	%eax
	salq	$4, %rax
	addq	%r8, %rax
	.p2align 4,,10
.L291:
	movupd	(%r12), %xmm3
	addq	$16, %r12
	andpd	%xmm5, %xmm3
	addsd	%xmm3, %xmm2
	unpckhpd	%xmm3, %xmm3
	addsd	%xmm3, %xmm2
	cmpq	%rax, %r12
	jne	.L291
	movl	%ecx, %r12d
	andl	$-2, %r12d
	leal	(%r12,%rdx), %eax
	cmpl	%r12d, %ecx
	je	.L289
.L290:
	addl	%r10d, %eax
	cltq
	movsd	(%r15,%rax,8), %xmm3
	andpd	%xmm8, %xmm3
	addsd	%xmm3, %xmm2
.L289:
	movsd	-8(%r8,%r11,8), %xmm3
	addl	%ebp, %r10d
	subl	$1, %ecx
	addq	%rdi, %r8
	addq	$8, %r9
	movapd	%xmm3, %xmm6
	subsd	%xmm2, %xmm6
	addsd	%xmm3, %xmm2
	minsd	%xmm4, %xmm6
	maxsd	%xmm0, %xmm2
	movapd	%xmm6, %xmm4
	movapd	%xmm2, %xmm0
	cmpl	%edx, %r14d
	jne	.L297
.L287:
	subsd	%xmm4, %xmm0
	mulsd	%xmm7, %xmm0
	subsd	%xmm4, %xmm0
	call	Rf_fmin2
	movq	200(%rsp), %rcx
	movq	%r15, %rdx
	xorl	%eax, %eax
	movq	1384(%rsp), %r8
	.p2align 4,,10
.L298:
	movsd	(%rdx), %xmm1
	addsd	%xmm0, %xmm1
	movsd	%xmm1, (%rdx)
	addq	%rcx, %rdx
	movsd	%xmm1, (%r8,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r14d
	jg	.L298
	movsd	%xmm7, 32(%rsp)
	pxor	%xmm3, %xmm3
	movq	%r15, %r8
	movl	%r14d, %edx
	movq	224(%rsp), %rax
	movl	1184(%rsp), %ecx
	movq	%rax, 40(%rsp)
	call	choldc
.L270:
	movq	432(%rsp), %r11
	movq	%r15, %rsi
	movq	%r15, %r9
	xorl	%eax, %eax
	movq	152(%rsp), %rdx
	movl	356(%rsp), %r10d
	movq	%r11, %r12
	.p2align 4,,10
.L304:
	leaq	-16(%r12), %rdi
	leaq	16(%r9), %r11
	movl	%eax, %ecx
	movl	%eax, %r8d
	cmpq	%r11, %rdi
	setnb	%dil
	cmpq	%r12, %r9
	setnb	%r11b
	orb	%r11b, %dil
	je	.L905
	cmpl	%eax, %r14d
	setg	%dil
	cmpl	$1, %r10d
	seta	%r11b
	testb	%r11b, %dil
	je	.L905
	movl	%r14d, %edi
	movl	$1, %r11d
	subl	%ecx, %edi
	cmpl	%ecx, %r14d
	cmovle	%r11d, %edi
	xorl	%r11d, %r11d
	movl	%edi, %ebp
	shrl	%ebp
	salq	$4, %rbp
	.p2align 4,,10
.L299:
	movupd	(%r9,%r11), %xmm0
	movupd	(%rdx,%r11), %xmm4
	mulpd	%xmm4, %xmm0
	movups	%xmm0, (%r9,%r11)
	addq	$16, %r11
	cmpq	%rbp, %r11
	jne	.L299
	movl	%edi, %r11d
	andl	$-2, %r11d
	addl	%r11d, %r8d
	cmpl	%r11d, %edi
	je	.L302
	leal	(%rbx,%r8), %r11d
	movslq	%r8d, %r8
	movslq	%r11d, %r11
	leaq	(%r15,%r11,8), %r11
	movsd	(%r11), %xmm0
	mulsd	0(%r13,%r8,8), %xmm0
	movsd	%xmm0, (%r11)
.L302:
	testq	%rax, %rax
	je	.L1332
.L303:
	movslq	%ebx, %rbp
	leal	-1(%rcx), %r11d
	leaq	0(,%rbp,8), %rdi
	addq	%rax, %rbp
	leaq	(%r15,%rbp,8), %rbp
	leaq	(%r15,%rdi), %r8
	cmpq	%rbp, %rdx
	leaq	16(%r15,%rdi), %rdi
	setnb	320(%rsp)
	addq	$8, %rdx
	cmpq	%rdx, %r8
	setnb	%bpl
	orb	320(%rsp), %bpl
	cmpq	%rdi, 152(%rsp)
	setnb	%dil
	cmpq	%r8, 432(%rsp)
	setbe	320(%rsp)
	orb	320(%rsp), %dil
	testb	%dil, %bpl
	je	.L314
	cmpl	$1, %r11d
	jbe	.L314
	movsd	0(%r13,%rax,8), %xmm1
	movl	%ecx, %edi
	movq	152(%rsp), %rbp
	xorl	%r11d, %r11d
	shrl	%edi
	unpcklpd	%xmm1, %xmm1
	salq	$4, %rdi
	.p2align 4,,10
.L315:
	movupd	0(%rbp,%r11), %xmm0
	movupd	(%r8,%r11), %xmm4
	mulpd	%xmm1, %xmm0
	mulpd	%xmm4, %xmm0
	movups	%xmm0, (%r8,%r11)
	addq	$16, %r11
	cmpq	%rdi, %r11
	jne	.L315
	movl	%ecx, %r8d
	andl	$-2, %r8d
	cmpl	%r8d, %ecx
	je	.L317
	leal	(%rbx,%r8), %ecx
	movsd	0(%r13,%r8,8), %xmm0
	mulsd	0(%r13,%rax,8), %xmm0
	movslq	%ecx, %rcx
	leaq	(%r15,%rcx,8), %rcx
	mulsd	(%rcx), %xmm0
	movsd	%xmm0, (%rcx)
.L317:
	movsd	0(%r13,%rax,8), %xmm0
	movq	1384(%rsp), %rdi
	movl	%r14d, %ecx
	addq	$8, %r12
	subl	%r10d, %ecx
	subl	$1, %r10d
	addq	200(%rsp), %r9
	addl	1184(%rsp), %ebx
	mulsd	%xmm0, %xmm0
	addq	136(%rsp), %rsi
	mulsd	(%rdi,%rax,8), %xmm0
	movsd	%xmm0, (%rdi,%rax,8)
	addq	$1, %rax
	cmpl	$-1, %r10d
	jne	.L304
	cmpl	%ecx, %r14d
	jle	.L240
	movq	624(%rsp), %rbx
	movslq	%ecx, %rax
	imull	1184(%rsp), %ecx
	movq	152(%rsp), %r11
	leaq	(%rax,%rbx), %rdx
	movq	1384(%rsp), %rbx
	leaq	(%rbx,%rdx,8), %rdx
	.p2align 4,,10
.L312:
	testl	%eax, %eax
	jle	.L1333
	movslq	%ecx, %rbp
	movl	%eax, %r10d
	leal	-1(%rax), %r9d
	movl	%eax, %esi
	addq	%rbp, %r10
	leaq	0(,%rbp,8), %rdi
	leaq	(%r15,%r10,8), %r10
	leaq	(%r15,%rdi), %r8
	cmpq	%r10, %rdx
	setnb	%bpl
	addq	$8, %rdx
	cmpq	%rdx, %r8
	setnb	%r10b
	orb	%r10b, %bpl
	je	.L307
	leaq	16(%r15,%rdi), %r10
	cmpq	%r10, %r11
	setnb	%r10b
	cmpq	432(%rsp), %r8
	setnb	%dil
	orl	%edi, %r10d
	cmpl	$1, %r9d
	seta	%dil
	testb	%dil, %r10b
	je	.L307
	movsd	0(%r13,%rax,8), %xmm1
	movl	%eax, %r10d
	xorl	%r9d, %r9d
	shrl	%r10d
	unpcklpd	%xmm1, %xmm1
	salq	$4, %r10
	.p2align 4,,10
.L308:
	movupd	(%r11,%r9), %xmm0
	movupd	(%r8,%r9), %xmm5
	mulpd	%xmm1, %xmm0
	mulpd	%xmm5, %xmm0
	movups	%xmm0, (%r8,%r9)
	addq	$16, %r9
	cmpq	%r10, %r9
	jne	.L308
	movl	%esi, %r8d
	andl	$-2, %r8d
	cmpl	%r8d, %esi
	je	.L306
	leal	(%rcx,%r8), %r9d
	movslq	%r8d, %r8
	movslq	%r9d, %r9
	movsd	0(%r13,%r8,8), %xmm0
	leaq	(%r15,%r9,8), %r9
	mulsd	0(%r13,%rax,8), %xmm0
	mulsd	(%r9), %xmm0
	movsd	%xmm0, (%r9)
.L306:
	movsd	0(%r13,%rax,8), %xmm0
	addl	1184(%rsp), %ecx
	mulsd	%xmm0, %xmm0
	mulsd	(%rbx,%rax,8), %xmm0
	movsd	%xmm0, (%rbx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r14d
	jg	.L312
.L240:
	xorl	%eax, %eax
	cmpb	$0, 856(%rsp)
	movsd	%xmm12, 320(%rsp)
	movq	264(%rsp), %rbx
	movapd	%xmm14, %xmm12
	movq	152(%rsp), %rbp
	je	.L821
.L1355:
	movq	232(%rsp), %rdx
	.p2align 4,,10
.L326:
	movupd	(%rdx,%rax), %xmm0
	movq	216(%rsp), %rsi
	xorpd	.LC22(%rip), %xmm0
	movups	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpq	288(%rsp), %rax
	jne	.L326
	cmpl	%r14d, 472(%rsp)
	je	.L328
	movq	656(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	664(%rsp), %rax
	xorpd	.LC8(%rip), %xmm0
	movsd	%xmm0, (%rax)
.L328:
	movl	1184(%rsp), %eax
	movl	%r14d, 912(%rsp)
	movl	$0, 916(%rsp)
	movl	%eax, 908(%rsp)
	movq	128(%rsp), %rax
	cmpq	%rbx, %rax
	je	.L329
	movq	640(%rsp), %r8
	movq	%rax, %rdx
	movq	%rbx, %rcx
	call	memcpy
.L329:
	movq	224(%rsp), %rsi
	movq	%rbx, %r9
	movq	%r15, %rcx
	movq	208(%rsp), %rdi
	movq	464(%rsp), %r12
	movq	304(%rsp), %r8
	movq	%rsi, 40(%rsp)
	movq	%rdi, 32(%rsp)
	movq	%r12, %rdx
	call	dtrsl_
	movq	%rsi, 40(%rsp)
	movq	%rbx, %r9
	movq	%r12, %rdx
	movq	%rdi, 32(%rsp)
	movq	%r15, %rcx
	movq	304(%rsp), %r8
	movl	$10, 916(%rsp)
	call	dtrsl_
	movl	352(%rsp), %esi
	testl	%esi, %esi
	jne	.L330
	cmpl	$1, 1256(%rsp)
	je	.L331
	cmpl	$2, 1256(%rsp)
	je	.L823
	movsd	336(%rsp), %xmm5
	movsd	240(%rsp), %xmm4
	movsd	%xmm12, 760(%rsp)
	movsd	%xmm10, 456(%rsp)
	movsd	%xmm5, 768(%rsp)
	movsd	320(%rsp), %xmm5
	movsd	%xmm4, 752(%rsp)
	movsd	%xmm5, 744(%rsp)
.L330:
	cmpl	$2, 1256(%rsp)
	je	.L332
	cmpl	$3, 1256(%rsp)
	jne	.L331
	movq	1392(%rsp), %rax
	movapd	%xmm12, %xmm14
	pxor	%xmm0, %xmm0
	movsd	920(%rsp), %xmm4
	movsd	320(%rsp), %xmm12
	movsd	%xmm4, 616(%rsp)
	movl	(%rax), %ebx
	xorl	%eax, %eax
	cmpl	$1, %r14d
	je	.L488
	movq	152(%rsp), %rdx
	movq	168(%rsp), %rcx
	movapd	%xmm0, %xmm2
	.p2align 4,,10
.L489:
	movupd	(%rdx,%rax), %xmm1
	movupd	(%rcx,%rax), %xmm4
	addq	$16, %rax
	mulpd	%xmm1, %xmm1
	mulpd	%xmm4, %xmm1
	mulpd	%xmm4, %xmm1
	movapd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm2, %xmm0
	movapd	%xmm1, %xmm2
	addsd	%xmm0, %xmm2
	cmpq	288(%rsp), %rax
	jne	.L489
	movslq	472(%rsp), %rax
	movapd	%xmm2, %xmm0
	cmpl	%r14d, %eax
	je	.L490
.L488:
	movsd	0(%r13,%rax,8), %xmm1
	movq	264(%rsp), %rsi
	mulsd	%xmm1, %xmm1
	movsd	(%rsi,%rax,8), %xmm2
	mulsd	%xmm2, %xmm1
	mulsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
.L490:
	ucomisd	%xmm0, %xmm11
	sqrtsd	%xmm0, %xmm9
	ja	.L1334
.L491:
	cmpl	$1, %ebx
	je	.L1335
.L492:
	pxor	%xmm15, %xmm15
	movq	%r13, %r12
	movq	%r15, %r13
	movl	%r14d, %r15d
	movl	$4, 320(%rsp)
	movapd	%xmm15, %xmm5
	movl	$1, %ebx
	movq	496(%rsp), %r14
	movapd	%xmm14, %xmm15
	movapd	%xmm5, %xmm14
.L504:
	movsd	.LC29(%rip), %xmm13
	movl	1184(%rsp), %eax
	movl	%r15d, 888(%rsp)
	movl	$1, 892(%rsp)
	mulsd	%xmm10, %xmm13
	movl	%eax, 884(%rsp)
	movl	$0, 896(%rsp)
	comisd	%xmm9, %xmm13
	jnb	.L1336
	comisd	%xmm11, %xmm15
	jbe	.L512
	movsd	240(%rsp), %xmm5
	movapd	%xmm12, %xmm0
	subsd	%xmm10, %xmm0
	addsd	%xmm5, %xmm0
	addsd	%xmm12, %xmm5
	movapd	%xmm5, %xmm8
	mulsd	%xmm0, %xmm8
	movsd	336(%rsp), %xmm0
	mulsd	%xmm10, %xmm0
	divsd	%xmm0, %xmm8
	subsd	%xmm8, %xmm15
.L512:
	movapd	%xmm9, %xmm6
	subsd	%xmm10, %xmm6
	testl	%ebx, %ebx
	je	.L514
	xorl	%eax, %eax
	cmpb	$0, 653(%rsp)
	je	.L850
	movq	152(%rsp), %rdx
	movq	168(%rsp), %rcx
	.p2align 4,,10
.L516:
	movupd	(%rdx,%rax), %xmm0
	movupd	(%rcx,%rax), %xmm4
	movq	256(%rsp), %rbx
	mulpd	%xmm0, %xmm0
	mulpd	%xmm4, %xmm0
	movups	%xmm0, (%rbx,%rax)
	addq	$16, %rax
	cmpq	176(%rsp), %rax
	jne	.L516
	movl	192(%rsp), %ebx
	cmpl	%ebx, 184(%rsp)
	je	.L518
	movq	480(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	384(%rsp), %rax
	mulsd	%xmm0, %xmm0
	mulsd	(%rax), %xmm0
	movq	592(%rsp), %rax
	movsd	%xmm0, (%rax)
.L518:
	leaq	896(%rsp), %rsi
	movq	%r13, %rcx
	pxor	%xmm12, %xmm12
	leaq	900(%rsp), %rbp
	movq	%rsi, 448(%rsp)
	leaq	884(%rsp), %rax
	movq	%rsi, 32(%rsp)
	movq	160(%rsp), %rsi
	leaq	888(%rsp), %rdi
	movq	%rax, %rdx
	movq	%rbp, 40(%rsp)
	movq	%rdi, %r8
	movq	%rsi, %r9
	movq	%rax, 416(%rsp)
	call	dtrsl_
	leaq	892(%rsp), %rax
	movq	%rsi, %rdx
	movq	%rdi, %rcx
	movq	%rax, %r8
	movq	%rax, 440(%rsp)
	call	dnrm2_
	xorpd	.LC8(%rip), %xmm6
	movl	888(%rsp), %eax
	mulsd	%xmm0, %xmm0
	xorpd	.LC8(%rip), %xmm0
	movapd	%xmm0, %xmm5
	divsd	%xmm9, %xmm5
	movsd	%xmm5, 336(%rsp)
	divsd	%xmm5, %xmm6
	testl	%eax, %eax
	jle	.L519
	cmpl	$1, %eax
	je	.L852
.L1347:
	movl	%eax, %ecx
	movq	152(%rsp), %r8
	xorl	%edx, %edx
	pxor	%xmm0, %xmm0
	shrl	%ecx
	movq	232(%rsp), %r9
	salq	$4, %rcx
	.p2align 4,,10
.L521:
	movupd	(%r9,%rdx), %xmm1
	movupd	(%r8,%rdx), %xmm3
	addq	$16, %rdx
	mulpd	%xmm1, %xmm1
	mulpd	%xmm3, %xmm3
	divpd	%xmm3, %xmm1
	addsd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm1, %xmm0
	cmpq	%rcx, %rdx
	jne	.L521
	movl	%eax, %edx
	andl	$-2, %edx
	cmpl	%edx, %eax
	je	.L522
.L520:
	movq	112(%rsp), %rax
	movslq	%edx, %rdx
	movsd	(%r12,%rdx,8), %xmm3
	movsd	(%rax,%rdx,8), %xmm1
	mulsd	%xmm3, %xmm3
	mulsd	%xmm1, %xmm1
	divsd	%xmm3, %xmm1
	addsd	%xmm1, %xmm0
.L522:
	ucomisd	%xmm0, %xmm11
	sqrtsd	%xmm0, %xmm12
	ja	.L1337
.L519:
	divsd	%xmm10, %xmm12
	leaq	904(%rsp), %rax
	movsd	.LC19(%rip), %xmm5
	movsd	.LC28(%rip), %xmm4
	movq	%rax, 536(%rsp)
	movq	%rbp, 568(%rsp)
	movl	%r15d, 1192(%rsp)
	movq	160(%rsp), %r15
	movq	%rdi, 560(%rsp)
	movq	%r14, %rdi
	movsd	%xmm5, 552(%rsp)
	movsd	%xmm4, 544(%rsp)
	.p2align 4,,10
.L560:
	comisd	%xmm15, %xmm6
	ja	.L523
	comisd	%xmm12, %xmm15
	jbe	.L524
.L523:
	movapd	%xmm6, %xmm0
	movsd	.LC30(%rip), %xmm1
	mulsd	%xmm12, %xmm0
	mulsd	%xmm12, %xmm1
	ucomisd	%xmm0, %xmm11
	sqrtsd	%xmm0, %xmm7
	ja	.L1338
.L526:
	movapd	%xmm7, %xmm0
	call	Rf_fmax2
	movapd	%xmm0, %xmm15
.L524:
	movl	888(%rsp), %edx
	movl	884(%rsp), %ecx
	testl	%edx, %edx
	jle	.L531
	movsd	(%r12), %xmm1
	movapd	%xmm15, %xmm0
	movq	1384(%rsp), %rbx
	movslq	%ecx, %rax
	leaq	8(,%rax,8), %rsi
	mulsd	%xmm1, %xmm0
	movq	%rsi, 520(%rsp)
	mulsd	%xmm1, %xmm0
	addsd	(%rbx), %xmm0
	movsd	%xmm0, 0(%r13)
	cmpl	$1, %edx
	je	.L531
	leal	1(%rcx), %r8d
	leaq	0(,%rax,8), %r10
	salq	$4, %rax
	subq	$8, %rsi
	movslq	%r8d, %r8
	movl	%ecx, 368(%rsp)
	movq	%rax, 512(%rsp)
	leaq	0(%r13,%r8,8), %rbx
	movl	$1, %r8d
	movq	%rbx, 240(%rsp)
	xorl	%ebx, %ebx
	.p2align 4,,10
.L537:
	movsd	(%r12,%r8,8), %xmm1
	testl	%r8d, %r8d
	leaq	-1(%r8), %r9
	movq	%rbx, %r14
	movapd	%xmm15, %xmm0
	movq	1384(%rsp), %rax
	cmovle	%rbx, %r9
	movl	%r8d, %ebp
	movl	%r8d, 532(%rsp)
	mulsd	%xmm1, %xmm0
	imulq	%rsi, %r9
	testl	%r8d, %r8d
	mulsd	%xmm1, %xmm0
	addsd	(%rax,%r8,8), %xmm0
	movq	240(%rsp), %rax
	movsd	%xmm0, (%rax)
	leaq	0(,%r8,8), %rax
	leaq	-8(%rax), %r11
	cmovle	%rbx, %r11
	addq	%r10, %r11
	testl	%ecx, %ecx
	cmovs	%r9, %r14
	addq	%rax, %r14
	cmpq	%r14, %r11
	setl	%r11b
	testl	%ecx, %ecx
	cmovs	%rbx, %r9
	addq	%rax, %r9
	cmpq	%r10, %r9
	setl	%r9b
	orb	%r9b, %r11b
	je	.L532
	cmpl	$23, %r8d
	jle	.L532
	testl	%r8d, %r8d
	movl	$1, %r14d
	leaq	0(%r13,%r10), %r11
	cmovg	%r8d, %r14d
	addq	%r13, %rax
	movl	%r14d, %r9d
	shrl	%r9d
	salq	$4, %r9
	addq	%r11, %r9
.L533:
	movupd	(%r11), %xmm0
	addq	$16, %r11
	movlpd	%xmm0, (%rax)
	movhpd	%xmm0, (%rax,%rsi)
	addq	512(%rsp), %rax
	cmpq	%r9, %r11
	jne	.L533
	movl	%r14d, %eax
	andl	$-2, %eax
	cmpl	%eax, %r14d
	je	.L536
	movl	368(%rsp), %r11d
	leal	(%r11,%rax), %r9d
	imull	%ecx, %eax
	movslq	%r9d, %r9
	movsd	0(%r13,%r9,8), %xmm0
	addl	%eax, %ebp
	movslq	%ebp, %rbp
	movsd	%xmm0, 0(%r13,%rbp,8)
.L536:
	addq	$1, %r8
	movq	520(%rsp), %r11
	addq	%rsi, %r10
	addq	%r11, 240(%rsp)
	addl	%ecx, 368(%rsp)
	cmpl	%r8d, %edx
	jg	.L537
.L531:
	movq	224(%rsp), %rax
	movq	%r13, %r8
	pxor	%xmm3, %xmm3
	movsd	552(%rsp), %xmm5
	movq	%rax, 40(%rsp)
	movsd	%xmm5, 32(%rsp)
	call	choldc
	movslq	888(%rsp), %r8
	testl	%r8d, %r8d
	jle	.L529
	leal	-1(%r8), %eax
	cmpl	$3, %eax
	jbe	.L541
	cmpb	$0, 652(%rsp)
	je	.L541
	movl	%r8d, %edx
	movq	232(%rsp), %rcx
	xorl	%eax, %eax
	shrl	%edx
	salq	$4, %rdx
.L542:
	movupd	(%rcx,%rax), %xmm0
	movq	256(%rsp), %rbx
	xorpd	.LC22(%rip), %xmm0
	movups	%xmm0, (%rbx,%rax)
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L542
	movl	%r8d, %eax
	andl	$-2, %eax
	cmpl	%eax, %r8d
	je	.L529
	movq	112(%rsp), %rsi
	movsd	(%rsi,%rax,8), %xmm0
	xorpd	.LC8(%rip), %xmm0
	movsd	%xmm0, (%r15,%rax,8)
.L529:
	movl	884(%rsp), %eax
	movl	%r8d, 908(%rsp)
	movl	$0, 912(%rsp)
	movl	%eax, 904(%rsp)
	cmpq	%rdi, %r15
	je	.L540
	salq	$3, %r8
	movq	%r15, %rdx
	movq	%rdi, %rcx
	call	memcpy
.L540:
	movq	208(%rsp), %rsi
	movq	%rdi, %r9
	movq	%r13, %rcx
	movq	304(%rsp), %rbx
	movq	464(%rsp), %rbp
	movq	536(%rsp), %r14
	movq	%rsi, 40(%rsp)
	movq	%rbx, 32(%rsp)
	movq	%rbp, %r8
	movq	%r14, %rdx
	call	dtrsl_
	movq	%rsi, 40(%rsp)
	movq	%rdi, %r9
	movq	%rbp, %r8
	movq	%rbx, 32(%rsp)
	movq	%r14, %rdx
	movq	%r13, %rcx
	movl	$10, 912(%rsp)
	call	dtrsl_
	movl	888(%rsp), %eax
	testl	%eax, %eax
	jle	.L546
	cmpl	$1, %eax
	je	.L854
	movl	%eax, %ecx
	movq	144(%rsp), %r8
	xorl	%edx, %edx
	pxor	%xmm0, %xmm0
	shrl	%ecx
	movq	152(%rsp), %r9
	salq	$4, %rcx
.L548:
	movupd	(%r9,%rdx), %xmm1
	movupd	(%r8,%rdx), %xmm5
	addq	$16, %rdx
	mulpd	%xmm1, %xmm1
	mulpd	%xmm5, %xmm1
	mulpd	%xmm5, %xmm1
	addsd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm1, %xmm0
	cmpq	%rcx, %rdx
	jne	.L548
	movl	%eax, %edx
	andl	$-2, %edx
	cmpl	%edx, %eax
	je	.L549
.L547:
	movslq	%edx, %rdx
	movsd	(%r12,%rdx,8), %xmm1
	movsd	(%rdi,%rdx,8), %xmm2
	mulsd	%xmm1, %xmm1
	mulsd	%xmm2, %xmm1
	mulsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
.L549:
	ucomisd	%xmm0, %xmm11
	sqrtsd	%xmm0, %xmm8
	ja	.L1339
	movapd	%xmm8, %xmm5
	subsd	%xmm10, %xmm5
	movsd	%xmm5, 240(%rsp)
.L788:
	cmpl	$2, %eax
	jle	.L855
	movzbl	529(%rsp), %esi
	testb	%sil, 610(%rsp)
	je	.L855
	testl	%eax, %eax
	movl	$1, %r8d
	movq	152(%rsp), %r9
	cmovg	%eax, %r8d
	movq	144(%rsp), %rax
	xorl	%edx, %edx
	movl	%r8d, %ecx
	shrl	%ecx
	salq	$4, %rcx
.L552:
	movupd	(%r9,%rdx), %xmm0
	movupd	(%rax,%rdx), %xmm4
	movq	256(%rsp), %rbx
	mulpd	%xmm0, %xmm0
	mulpd	%xmm4, %xmm0
	movups	%xmm0, (%rbx,%rdx)
	addq	$16, %rdx
	cmpq	%rcx, %rdx
	jne	.L552
	movl	%r8d, %eax
	andl	$-2, %eax
	cmpl	%eax, %r8d
	je	.L550
	movsd	(%r12,%rax,8), %xmm0
	mulsd	%xmm0, %xmm0
	mulsd	(%rdi,%rax,8), %xmm0
	movsd	%xmm0, (%r15,%rax,8)
.L550:
	movq	568(%rsp), %rax
	movq	560(%rsp), %rsi
	movq	%r15, %r9
	movq	%r13, %rcx
	movq	416(%rsp), %rdx
	movq	%rax, 40(%rsp)
	movq	448(%rsp), %rax
	movq	%rsi, %r8
	movq	%rax, 32(%rsp)
	call	dtrsl_
	movq	440(%rsp), %r8
	movq	%r15, %rdx
	movq	%rsi, %rcx
	call	dnrm2_
	mulsd	%xmm0, %xmm0
	movapd	%xmm0, %xmm7
	xorpd	.LC8(%rip), %xmm7
	movsd	544(%rsp), %xmm0
	mulsd	%xmm10, %xmm0
	divsd	%xmm8, %xmm7
	comisd	%xmm0, %xmm8
	jb	.L555
	comisd	%xmm8, %xmm13
	jnb	.L557
.L555:
	movapd	%xmm12, %xmm0
	subsd	%xmm6, %xmm0
	comisd	%xmm11, %xmm0
	ja	.L557
	movapd	%xmm15, %xmm1
	movapd	%xmm6, %xmm0
	subsd	240(%rsp), %xmm1
	divsd	%xmm7, %xmm1
	call	Rf_fmax2
	comisd	240(%rsp), %xmm11
	movapd	%xmm0, %xmm6
	ja	.L1340
.L558:
	movsd	240(%rsp), %xmm2
	mulsd	%xmm10, %xmm7
	mulsd	%xmm8, %xmm2
	divsd	%xmm7, %xmm2
	subsd	%xmm2, %xmm15
	jmp	.L560
	.p2align 4,,10
.L892:
	comisd	1248(%rsp), %xmm11
	jbe	.L186
	comisd	1320(%rsp), %xmm11
	movsd	1248(%rsp), %xmm4
	xorpd	.LC8(%rip), %xmm4
	movsd	%xmm4, 1248(%rsp)
	jbe	.L1254
.L1322:
	movq	1272(%rsp), %rax
	movl	$-3, (%rax)
	jmp	.L167
	.p2align 4,,10
.L1321:
	cmpl	$1, %r13d
	je	.L808
	movl	%r13d, %edx
	pxor	%xmm0, %xmm0
	movq	1200(%rsp), %rcx
	xorl	%eax, %eax
	shrl	%edx
	movapd	%xmm0, %xmm2
	salq	$4, %rdx
	.p2align 4,,10
.L183:
	movupd	(%rcx,%rax), %xmm1
	movupd	(%r14,%rax), %xmm5
	addq	$16, %rax
	mulpd	%xmm1, %xmm1
	mulpd	%xmm5, %xmm1
	mulpd	%xmm5, %xmm1
	movapd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm2, %xmm0
	movapd	%xmm1, %xmm2
	addsd	%xmm0, %xmm2
	cmpq	%rdx, %rax
	jne	.L183
	movl	%r13d, %eax
	movapd	%xmm2, %xmm0
	andl	$-2, %eax
	cmpl	%r13d, %eax
	je	.L184
.L182:
	movq	1200(%rsp), %rdi
	cltq
	movsd	(%r14,%rax,8), %xmm1
	movsd	(%rdi,%rax,8), %xmm2
	mulsd	%xmm2, %xmm2
	mulsd	%xmm1, %xmm2
	mulsd	%xmm1, %xmm2
	addsd	%xmm2, %xmm0
.L184:
	ucomisd	%xmm0, %xmm11
	sqrtsd	%xmm0, %xmm6
	ja	.L1341
.L185:
	movsd	.LC0(%rip), %xmm1
	movapd	%xmm6, %xmm0
	call	Rf_fmax2
	mulsd	.LC10(%rip), %xmm0
	movsd	1248(%rsp), %xmm4
	ucomisd	%xmm11, %xmm4
	movsd	%xmm0, 1328(%rsp)
	jnp	.L1342
	jmp	.L892
	.p2align 4,,10
.L1317:
	movq	1272(%rsp), %rax
	movl	$-1, (%rax)
.L167:
	movaps	944(%rsp), %xmm6
	movaps	960(%rsp), %xmm7
	movaps	976(%rsp), %xmm8
	movaps	992(%rsp), %xmm9
	movaps	1008(%rsp), %xmm10
	movaps	1024(%rsp), %xmm11
	movaps	1040(%rsp), %xmm12
	movaps	1056(%rsp), %xmm13
	movaps	1072(%rsp), %xmm14
	movaps	1088(%rsp), %xmm15
	addq	$1112, %rsp
	popq	%rbx
	popq	%rsi
	popq	%rdi
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
	.p2align 4,,10
.L1318:
	andl	$1, %ecx
	jne	.L174
	movq	1272(%rsp), %rax
	movl	$-2, (%rax)
	jmp	.L167
	.p2align 4,,10
.L1315:
	movq	1272(%rsp), %rax
	movl	$-6, (%rax)
	jmp	.L167
	.p2align 4,,10
.L1316:
	movq	1272(%rsp), %rax
	movl	$-7, (%rax)
	jmp	.L167
	.p2align 4,,10
.L1324:
	movq	1272(%rsp), %rax
	movl	$-5, (%rax)
	jmp	.L167
	.p2align 4,,10
.L557:
	movl	1192(%rsp), %r15d
	movq	%rdi, %r14
	movapd	%xmm10, %xmm12
	xorl	%ebx, %ebx
.L511:
	xorl	%eax, %eax
	cmpb	$0, 479(%rsp)
	movl	%r15d, 916(%rsp)
	movl	$1, 936(%rsp)
	je	.L856
	movq	144(%rsp), %rdx
	movq	1200(%rsp), %rcx
	.p2align 4,,10
.L562:
	movupd	(%rcx,%rax), %xmm0
	movupd	(%rdx,%rax), %xmm5
	movq	1344(%rsp), %rsi
	addpd	%xmm5, %xmm0
	movups	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpq	176(%rsp), %rax
	jne	.L562
	movl	192(%rsp), %esi
	cmpl	%esi, 184(%rsp)
	je	.L564
	movq	392(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	280(%rsp), %rax
	addsd	(%rax), %xmm0
	movq	400(%rsp), %rax
	movsd	%xmm0, (%rax)
.L564:
	movq	1232(%rsp), %r9
	movq	1352(%rsp), %r8
	movl	%r15d, %ecx
	movq	1344(%rsp), %rdx
	call	*1208(%rsp)
	movq	112(%rsp), %rdx
	movq	%r14, %r9
	movq	1352(%rsp), %rax
	movq	208(%rsp), %rcx
	movsd	(%rax), %xmm6
	movq	224(%rsp), %rax
	subsd	616(%rsp), %xmm6
	movq	%rax, 32(%rsp)
	movq	%rax, %r8
	call	ddot_
	cmpl	$3, 320(%rsp)
	movapd	%xmm0, %xmm7
	je	.L1343
	movsd	.LC23(%rip), %xmm0
	mulsd	%xmm7, %xmm0
.L567:
	comisd	%xmm0, %xmm6
	movl	916(%rsp), %r9d
	ja	.L575
	pxor	%xmm0, %xmm0
	testl	%r9d, %r9d
	jle	.L577
	movl	1184(%rsp), %r11d
	leal	-1(%r9), %ecx
	xorl	%eax, %eax
	xorl	%edx, %edx
	movq	680(%rsp), %r10
	pxor	%xmm0, %xmm0
	.p2align 4,,10
.L585:
	movq	1384(%rsp), %rsi
	movsd	(%r14,%rdx,8), %xmm3
	movsd	(%rsi,%rdx,8), %xmm1
	leal	1(%rax), %esi
	mulsd	%xmm3, %xmm1
	mulsd	%xmm3, %xmm1
	addsd	%xmm1, %xmm0
	cmpl	%r9d, %esi
	jge	.L586
	movl	%r9d, %r8d
	subl	%edx, %r8d
	cmpl	$2, %r8d
	je	.L860
	movslq	%r11d, %r8
	movapd	%xmm3, %xmm4
	pxor	%xmm1, %xmm1
	movq	%r10, %rdi
	addq	%rdx, %r8
	movl	%eax, 368(%rsp)
	unpcklpd	%xmm4, %xmm4
	leaq	0(%r13,%r8,8), %rbp
	movl	%ecx, %r8d
	shrl	%r8d
	salq	$4, %r8
	addq	%r10, %r8
	.p2align 4,,10
.L588:
	movsd	0(%rbp), %xmm2
	movq	136(%rsp), %rax
	addq	$16, %rdi
	movupd	-16(%rdi), %xmm5
	movhpd	0(%rbp,%rax), %xmm2
	addq	296(%rsp), %rbp
	mulpd	%xmm4, %xmm2
	mulpd	%xmm5, %xmm2
	addsd	%xmm2, %xmm1
	unpckhpd	%xmm2, %xmm2
	addsd	%xmm2, %xmm1
	cmpq	%r8, %rdi
	jne	.L588
	movl	%ecx, %edi
	movl	368(%rsp), %eax
	andl	$-2, %edi
	leal	(%rdi,%rsi), %r8d
	cmpl	%ecx, %edi
	je	.L589
.L587:
	movl	1184(%rsp), %edi
	imull	%r8d, %edi
	movslq	%r8d, %r8
	addl	%edi, %eax
	cltq
	mulsd	0(%r13,%rax,8), %xmm3
	mulsd	(%r14,%r8,8), %xmm3
	addsd	%xmm3, %xmm1
.L589:
	addsd	%xmm1, %xmm1
	addq	$1, %rdx
	subl	$1, %ecx
	addq	$8, %r10
	addl	1184(%rsp), %r11d
	addsd	%xmm1, %xmm0
.L590:
	movl	%esi, %eax
	jmp	.L585
	.p2align 4,,10
.L860:
	movl	%esi, %r8d
	pxor	%xmm1, %xmm1
	jmp	.L587
	.p2align 4,,10
.L586:
	addsd	%xmm11, %xmm0
	addq	$1, %rdx
	subl	$1, %ecx
	addq	$8, %r10
	addl	1184(%rsp), %r11d
	cmpl	%r9d, %esi
	jne	.L590
	mulsd	.LC5(%rip), %xmm0
.L577:
	cmpl	$2, 320(%rsp)
	addsd	%xmm0, %xmm7
	movsd	1328(%rsp), %xmm2
	mulsd	.LC24(%rip), %xmm2
	je	.L591
	movapd	%xmm7, %xmm1
	movq	.LC2(%rip), %xmm0
	subsd	%xmm6, %xmm1
	andpd	%xmm0, %xmm1
	andpd	%xmm6, %xmm0
	mulsd	.LC12(%rip), %xmm0
	comisd	%xmm1, %xmm0
	jb	.L591
	comisd	%xmm9, %xmm13
	jb	.L591
	comisd	%xmm12, %xmm2
	jb	.L591
	testl	%r9d, %r9d
	jle	.L600
	leal	-1(%r9), %eax
	cmpl	$3, %eax
	jbe	.L597
	cmpb	$0, 477(%rsp)
	je	.L597
	movl	%r9d, %edx
	movq	216(%rsp), %rcx
	movq	1344(%rsp), %r8
	xorl	%eax, %eax
	shrl	%edx
	salq	$4, %rdx
	.p2align 4,,10
.L598:
	movupd	(%r8,%rax), %xmm4
	movups	%xmm4, (%rcx,%rax)
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L598
	movl	%r9d, %eax
	andl	$-2, %eax
	cmpl	%eax, %r9d
	je	.L600
	movq	1344(%rsp), %rsi
	movsd	(%rsi,%rax,8), %xmm0
	movq	128(%rsp), %rsi
	movsd	%xmm0, (%rsi,%rax,8)
.L600:
	movapd	%xmm12, %xmm0
	movq	1352(%rsp), %rax
	movsd	1328(%rsp), %xmm1
	addsd	%xmm12, %xmm0
	movsd	(%rax), %xmm14
	call	Rf_fmin2
	movl	$3, 320(%rsp)
	movapd	%xmm0, %xmm10
	jmp	.L504
	.p2align 4,,10
.L591:
	movsd	.LC12(%rip), %xmm0
	xorl	%esi, %esi
	comisd	%xmm2, %xmm12
	movl	%r15d, %r14d
	movapd	%xmm15, %xmm14
	movq	%r13, %r15
	movq	%r12, %r13
	mulsd	%xmm7, %xmm0
	seta	%sil
	comisd	%xmm0, %xmm6
	jb	.L1283
	movapd	%xmm12, %xmm6
.L1310:
	mulsd	.LC5(%rip), %xmm6
.L1309:
	xorl	%ebx, %ebx
.L378:
	xorl	%eax, %eax
	cmpb	$0, 858(%rsp)
	je	.L610
	movq	168(%rsp), %rdx
	movq	288(%rsp), %rcx
	movq	1200(%rsp), %r8
	movq	1344(%rsp), %r9
	.p2align 4,,10
.L609:
	movupd	(%r9,%rax), %xmm0
	movupd	(%r8,%rax), %xmm4
	subpd	%xmm4, %xmm0
	movups	%xmm0, (%rdx,%rax)
	addq	$16, %rax
	cmpq	%rcx, %rax
	jne	.L609
	cmpl	%r14d, 472(%rsp)
	je	.L613
	movq	720(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	728(%rsp), %rax
	subsd	(%rax), %xmm0
	movq	712(%rsp), %rax
	movsd	%xmm0, (%rax)
.L613:
	movl	352(%rsp), %eax
	cmpl	$-1, %eax
	je	.L615
	testl	%eax, %eax
	je	.L616
	movq	1232(%rsp), %r9
	movq	1360(%rsp), %r8
	movl	%r14d, %ecx
	movq	1344(%rsp), %rdx
	call	*1216(%rsp)
.L618:
	movl	1288(%rsp), %eax
	movl	%esi, 104(%rsp)
	movl	%r14d, %ecx
	movsd	1248(%rsp), %xmm4
	movl	%ebx, 96(%rsp)
	movl	%eax, 88(%rsp)
	movq	792(%rsp), %rax
	movsd	%xmm4, 80(%rsp)
	movq	1360(%rsp), %r9
	movsd	1336(%rsp), %xmm5
	movq	%rax, 48(%rsp)
	movq	1392(%rsp), %rax
	movsd	1320(%rsp), %xmm4
	movq	%r13, 72(%rsp)
	movsd	%xmm5, 64(%rsp)
	movq	1344(%rsp), %rdx
	movsd	%xmm4, 56(%rsp)
	movl	(%rax), %eax
	movl	%eax, 40(%rsp)
	movq	1200(%rsp), %rax
	movq	%rax, 32(%rsp)
	movq	1352(%rsp), %rax
	movsd	(%rax), %xmm2
	call	opt_stop.isra.0
	movl	%eax, %r12d
	movq	1368(%rsp), %rax
	movl	%r12d, (%rax)
	testl	%r12d, %r12d
	jne	.L619
	movl	1264(%rsp), %ecx
	testl	%ecx, %ecx
	je	.L620
	movq	1392(%rsp), %rax
	cmpl	$3, 1256(%rsp)
	movl	(%rax), %eax
	movl	%eax, 440(%rsp)
	je	.L1344
	xorl	%eax, %eax
	cmpb	$0, 860(%rsp)
	movl	%r14d, 908(%rsp)
	movl	$1, 912(%rsp)
	je	.L664
	.p2align 4,,10
.L665:
	movq	1344(%rsp), %rbx
	movupd	(%rbx,%rax), %xmm5
	movq	1200(%rsp), %rbx
	movupd	(%rbx,%rax), %xmm4
	movapd	%xmm5, %xmm0
	movq	144(%rsp), %rbx
	subpd	%xmm4, %xmm0
	movups	%xmm0, (%rbx,%rax)
	movq	1360(%rsp), %rbx
	movupd	(%rbx,%rax), %xmm4
	movq	632(%rsp), %rbx
	movupd	(%rbx,%rax), %xmm5
	movapd	%xmm4, %xmm0
	movq	216(%rsp), %rbx
	movaps	%xmm4, 320(%rsp)
	subpd	%xmm5, %xmm0
	movaps	%xmm5, 368(%rsp)
	movups	%xmm0, (%rbx,%rax)
	addq	$16, %rax
	cmpq	176(%rsp), %rax
	jne	.L665
	movl	192(%rsp), %ebx
	cmpl	%ebx, 184(%rsp)
	je	.L667
	movq	400(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	392(%rsp), %rax
	subsd	(%rax), %xmm0
	movq	280(%rsp), %rax
	movsd	%xmm0, (%rax)
	movq	696(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	488(%rsp), %rax
	subsd	(%rax), %xmm0
	movq	576(%rsp), %rax
	movsd	%xmm0, (%rax)
.L667:
	movq	304(%rsp), %rbx
	movq	464(%rsp), %rsi
	movq	128(%rsp), %rbp
	movq	496(%rsp), %rdi
	movq	%rbx, 32(%rsp)
	movq	%rbx, %r8
	movq	%rsi, %rcx
	movq	%rbp, %r9
	movq	%rdi, %rdx
	call	ddot_
	movq	%rbx, %r8
	movq	%rdi, %rdx
	movq	%rsi, %rcx
	movapd	%xmm0, %xmm10
	call	dnrm2_
	movq	%rbx, %r8
	movq	%rbp, %rdx
	movq	%rsi, %rcx
	movapd	%xmm0, %xmm8
	call	dnrm2_
	movsd	.LC19(%rip), %xmm7
	mulsd	%xmm8, %xmm7
	mulsd	%xmm0, %xmm7
	comisd	%xmm10, %xmm7
	ja	.L663
	movl	908(%rsp), %eax
	movl	$1, 936(%rsp)
	movl	%eax, 916(%rsp)
	testl	%eax, %eax
	jle	.L673
	movq	496(%rsp), %rbx
	subl	$1, %eax
	movq	160(%rsp), %rbp
	movq	%r15, %rdi
	movq	%rbx, %rsi
	leaq	8(%rbx,%rax,8), %rbx
	.p2align 4,,10
.L672:
	movq	224(%rsp), %rax
	movq	%rsi, %r9
	movq	%rdi, %rdx
	addq	$8, %rsi
	movq	208(%rsp), %rcx
	addq	$8, %rbp
	movq	%rax, 32(%rsp)
	movq	%rax, %r8
	call	ddot_
	subl	$1, 916(%rsp)
	addq	200(%rsp), %rdi
	movsd	%xmm0, -8(%rbp)
	cmpq	%rsi, %rbx
	jne	.L672
.L673:
	movq	304(%rsp), %r8
	movq	160(%rsp), %rdx
	movq	464(%rsp), %rcx
	movq	%r8, 32(%rsp)
	movq	%rdx, %r9
	call	ddot_
	movapd	%xmm10, %xmm4
	divsd	%xmm0, %xmm4
	ucomisd	%xmm4, %xmm11
	sqrtsd	%xmm4, %xmm13
	movapd	%xmm4, %xmm0
	ja	.L1345
.L670:
	cmpl	$1, 440(%rsp)
	movl	908(%rsp), %esi
	jne	.L674
	testl	%esi, %esi
	jle	.L873
	movapd	%xmm13, %xmm1
	movl	%esi, %r11d
	leal	-1(%rsi), %ebp
	movq	%r15, %rcx
	xorl	%r10d, %r10d
	xorl	%r9d, %r9d
	unpcklpd	%xmm1, %xmm1
	movl	$1, %edi
	.p2align 4,,10
.L679:
	movq	160(%rsp), %rbx
	cmpl	%esi, %r9d
	movl	%r9d, %eax
	movsd	(%rbx,%r9,8), %xmm0
	mulsd	%xmm13, %xmm0
	movsd	%xmm0, (%rbx,%r9,8)
	movl	%edi, %ebx
	cmovl	%r11d, %ebx
	cmpl	$1, %r11d
	je	.L676
	cmpl	%r9d, %esi
	jle	.L676
	movl	%ebx, %r8d
	xorl	%edx, %edx
	shrl	%r8d
	salq	$4, %r8
	.p2align 4,,10
.L677:
	movupd	(%rcx,%rdx), %xmm0
	mulpd	%xmm1, %xmm0
	movups	%xmm0, (%rcx,%rdx)
	addq	$16, %rdx
	cmpq	%r8, %rdx
	jne	.L677
	movl	%ebx, %edx
	andl	$-2, %edx
	addl	%edx, %eax
	cmpl	%ebx, %edx
	je	.L678
.L676:
	addl	%r10d, %eax
	cltq
	leaq	(%r15,%rax,8), %rax
	movsd	(%rax), %xmm0
	mulsd	%xmm13, %xmm0
	movsd	%xmm0, (%rax)
.L678:
	leaq	1(%r9), %rax
	subl	$1, %r11d
	addl	1184(%rsp), %r10d
	addq	200(%rsp), %rcx
	cmpq	%r9, %rbp
	je	.L1346
	movq	%rax, %r9
	jmp	.L679
	.p2align 4,,10
.L864:
	movq	%rdx, %rax
.L610:
	movq	1344(%rsp), %rdi
	leaq	1(%rax), %rdx
	movsd	(%rdi,%rax,8), %xmm0
	movq	1200(%rsp), %rdi
	subsd	(%rdi,%rax,8), %xmm0
	movq	264(%rsp), %rdi
	movsd	%xmm0, (%rdi,%rax,8)
	cmpq	272(%rsp), %rax
	jne	.L864
	jmp	.L613
	.p2align 4,,10
.L575:
	testl	%r9d, %r9d
	jle	.L859
	movsd	.LC0(%rip), %xmm8
	movq	1344(%rsp), %rdi
	xorl	%esi, %esi
	pxor	%xmm13, %xmm13
	.p2align 4,,10
.L581:
	movsd	(%rdi,%rsi,8), %xmm0
	movsd	(%r14,%rsi,8), %xmm10
	movapd	%xmm8, %xmm1
	divsd	(%r12,%rsi,8), %xmm1
	andpd	.LC2(%rip), %xmm0
	addq	$1, %rsi
	andpd	.LC2(%rip), %xmm10
	call	Rf_fmax2
	divsd	%xmm0, %xmm10
	maxsd	%xmm13, %xmm10
	movapd	%xmm10, %xmm13
	cmpl	%esi, 916(%rsp)
	jg	.L581
.L578:
	movsd	1336(%rsp), %xmm4
	comisd	%xmm13, %xmm4
	ja	.L582
	movapd	%xmm7, %xmm0
	subsd	%xmm7, %xmm6
	xorpd	.LC8(%rip), %xmm0
	movsd	.LC12(%rip), %xmm10
	movl	$2, 320(%rsp)
	mulsd	%xmm12, %xmm0
	addsd	%xmm6, %xmm6
	mulsd	%xmm12, %xmm10
	divsd	%xmm6, %xmm0
	maxsd	%xmm0, %xmm10
	jmp	.L504
	.p2align 4,,10
.L856:
	movq	1200(%rsp), %rcx
	movq	1344(%rsp), %rsi
	jmp	.L561
	.p2align 4,,10
.L857:
	movq	%rdx, %rax
.L561:
	movsd	(%rcx,%rax,8), %xmm0
	addsd	(%r14,%rax,8), %xmm0
	leaq	1(%rax), %rdx
	movsd	%xmm0, (%rsi,%rax,8)
	cmpq	272(%rsp), %rax
	jne	.L857
	jmp	.L564
	.p2align 4,,10
.L1343:
	movq	1352(%rsp), %rax
	movsd	(%rax), %xmm0
	comisd	%xmm14, %xmm0
	jnb	.L566
	movsd	.LC23(%rip), %xmm0
	mulsd	%xmm7, %xmm0
	comisd	%xmm0, %xmm6
	jbe	.L567
.L566:
	movl	916(%rsp), %ecx
	movapd	%xmm14, %xmm5
	movl	%r15d, %r14d
	movapd	%xmm15, %xmm14
	movq	%r13, %r15
	movapd	%xmm5, %xmm15
	movq	%r12, %r13
	testl	%ecx, %ecx
	jle	.L574
	leal	-1(%rcx), %eax
	cmpl	$3, %eax
	jbe	.L568
	cmpb	$0, 477(%rsp)
	je	.L568
	movl	%ecx, %edx
	movq	216(%rsp), %r8
	xorl	%eax, %eax
	shrl	%edx
	salq	$4, %rdx
	.p2align 4,,10
.L569:
	movupd	(%r8,%rax), %xmm5
	movq	1344(%rsp), %rbx
	movups	%xmm5, (%rbx,%rax)
	addq	$16, %rax
	cmpq	%rax, %rdx
	jne	.L569
	movl	%ecx, %eax
	andl	$-2, %eax
	cmpl	%ecx, %eax
	je	.L574
	movq	128(%rsp), %rbx
	movsd	(%rbx,%rax,8), %xmm0
	movq	1344(%rsp), %rbx
	movsd	%xmm0, (%rbx,%rax,8)
.L574:
	movq	1352(%rsp), %rax
	movsd	.LC5(%rip), %xmm6
	xorl	%ebx, %ebx
	xorl	%esi, %esi
	movsd	%xmm15, (%rax)
	mulsd	%xmm12, %xmm6
	jmp	.L378
	.p2align 4,,10
.L1340:
	movapd	%xmm12, %xmm0
	movapd	%xmm15, %xmm1
	call	Rf_fmin2
	movapd	%xmm0, %xmm12
	jmp	.L558
	.p2align 4,,10
.L855:
	xorl	%edx, %edx
	.p2align 4,,10
.L551:
	movsd	(%r12,%rdx,8), %xmm0
	mulsd	%xmm0, %xmm0
	mulsd	(%rdi,%rdx,8), %xmm0
	movsd	%xmm0, (%r15,%rdx,8)
	addq	$1, %rdx
	cmpl	%edx, %eax
	jg	.L551
	jmp	.L550
	.p2align 4,,10
.L854:
	xorl	%edx, %edx
	pxor	%xmm0, %xmm0
	jmp	.L547
	.p2align 4,,10
.L546:
	movapd	%xmm11, %xmm5
	pxor	%xmm8, %xmm8
	subsd	%xmm10, %xmm5
	movsd	%xmm5, 240(%rsp)
	jmp	.L550
	.p2align 4,,10
.L541:
	movl	%eax, %edx
	movq	112(%rsp), %r9
	xorl	%eax, %eax
	jmp	.L544
	.p2align 4,,10
.L853:
	movq	%rcx, %rax
.L544:
	movsd	(%r9,%rax,8), %xmm0
	xorpd	.LC8(%rip), %xmm0
	leaq	1(%rax), %rcx
	movsd	%xmm0, (%r15,%rax,8)
	cmpq	%rdx, %rax
	jne	.L853
	jmp	.L529
	.p2align 4,,10
.L532:
	addq	%r13, %rax
	xorl	%r9d, %r9d
	leaq	0(%r13,%r10), %r11
	.p2align 4,,10
.L535:
	movsd	(%r11,%r9,8), %xmm0
	addq	$1, %r9
	movsd	%xmm0, (%rax)
	addq	%rsi, %rax
	cmpl	%r9d, 532(%rsp)
	jg	.L535
	jmp	.L536
	.p2align 4,,10
.L514:
	leaq	884(%rsp), %rbx
	leaq	896(%rsp), %rsi
	movl	%r15d, %eax
	movq	%rbx, 416(%rsp)
	leaq	892(%rsp), %rbx
	xorpd	.LC8(%rip), %xmm6
	leaq	888(%rsp), %rdi
	leaq	900(%rsp), %rbp
	movq	%rsi, 448(%rsp)
	divsd	336(%rsp), %xmm6
	movq	%rbx, 440(%rsp)
	cmpl	$1, %eax
	jne	.L1347
.L852:
	xorl	%edx, %edx
	pxor	%xmm0, %xmm0
	jmp	.L520
	.p2align 4,,10
.L1336:
	xorl	%eax, %eax
	cmpb	$0, 608(%rsp)
	je	.L849
	movq	168(%rsp), %rdx
	.p2align 4,,10
.L508:
	movupd	(%rdx,%rax), %xmm4
	movq	144(%rsp), %rsi
	movups	%xmm4, (%rsi,%rax)
	addq	$16, %rax
	cmpq	176(%rsp), %rax
	jne	.L508
	movl	192(%rsp), %esi
	cmpl	%esi, 184(%rsp)
	je	.L510
	movq	384(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	280(%rsp), %rax
	movsd	%xmm0, (%rax)
.L510:
	movapd	%xmm9, %xmm1
	movapd	%xmm10, %xmm0
	pxor	%xmm15, %xmm15
	call	Rf_fmin2
	movapd	%xmm0, %xmm12
	jmp	.L511
	.p2align 4,,10
.L582:
	movl	352(%rsp), %r8d
	movl	%r15d, %r14d
	movapd	%xmm15, %xmm14
	movq	%r13, %r15
	movq	%r12, %r13
	testl	%r8d, %r8d
	je	.L608
	movapd	%xmm12, %xmm6
	movl	$1, %ebx
.L1308:
	xorl	%esi, %esi
	jmp	.L378
	.p2align 4,,10
.L1283:
	movsd	.LC28(%rip), %xmm0
	mulsd	%xmm0, %xmm7
	comisd	%xmm6, %xmm7
	jnb	.L1348
	xorl	%ebx, %ebx
	movapd	%xmm12, %xmm6
	jmp	.L378
	.p2align 4,,10
.L897:
	movq	%r9, %rax
	.p2align 4,,10
.L244:
	movsd	0(%r13,%rax,8), %xmm1
	mulsd	0(%r13,%r9,8), %xmm1
	movsd	(%r11,%rax,8), %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%r11,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r14d
	jg	.L244
	jmp	.L245
	.p2align 4,,10
.L905:
	movq	%rax, %r8
	.p2align 4,,10
.L301:
	movsd	(%rsi,%r8,8), %xmm0
	mulsd	0(%r13,%r8,8), %xmm0
	movsd	%xmm0, (%rsi,%r8,8)
	addq	$1, %r8
	cmpl	%r8d, %r14d
	jg	.L301
	testq	%rax, %rax
	jne	.L303
	.p2align 4,,10
.L1332:
	addq	$8, %rdx
	jmp	.L317
	.p2align 4,,10
.L314:
	xorl	%ecx, %ecx
	jmp	.L319
	.p2align 4,,10
.L820:
	movq	%rdi, %rcx
.L319:
	movsd	0(%r13,%rcx,8), %xmm0
	mulsd	0(%r13,%rax,8), %xmm0
	leaq	1(%rcx), %rdi
	mulsd	(%r8,%rcx,8), %xmm0
	movsd	%xmm0, (%r8,%rcx,8)
	cmpq	%r11, %rcx
	jne	.L820
	jmp	.L317
	.p2align 4,,10
.L307:
	movl	%r9d, %r10d
	xorl	%r9d, %r9d
	jmp	.L310
	.p2align 4,,10
.L819:
	movq	%rsi, %r9
.L310:
	movsd	0(%r13,%r9,8), %xmm0
	mulsd	0(%r13,%rax,8), %xmm0
	leaq	1(%r9), %rsi
	mulsd	(%r8,%r9,8), %xmm0
	movsd	%xmm0, (%r8,%r9,8)
	cmpq	%r9, %r10
	jne	.L819
	jmp	.L306
	.p2align 4,,10
.L823:
	movsd	%xmm10, 456(%rsp)
.L332:
	movsd	920(%rsp), %xmm5
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movsd	%xmm5, 448(%rsp)
	cmpl	$1, %r14d
	je	.L380
	movq	168(%rsp), %rdx
	movapd	%xmm0, %xmm2
	.p2align 4,,10
.L381:
	movupd	0(%rbp,%rax), %xmm1
	movupd	(%rdx,%rax), %xmm5
	addq	$16, %rax
	mulpd	%xmm1, %xmm1
	mulpd	%xmm5, %xmm1
	mulpd	%xmm5, %xmm1
	movapd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm2, %xmm0
	movapd	%xmm1, %xmm2
	addsd	%xmm0, %xmm2
	cmpq	288(%rsp), %rax
	jne	.L381
	movslq	472(%rsp), %rax
	movapd	%xmm2, %xmm0
	cmpl	%r14d, %eax
	je	.L382
.L380:
	movsd	0(%r13,%rax,8), %xmm1
	movsd	(%rbx,%rax,8), %xmm2
	mulsd	%xmm1, %xmm1
	mulsd	%xmm2, %xmm1
	mulsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
.L382:
	ucomisd	%xmm0, %xmm11
	sqrtsd	%xmm0, %xmm9
	ja	.L1349
.L383:
	movl	$1, %esi
	pxor	%xmm8, %xmm8
	pxor	%xmm7, %xmm7
	movl	$4, 368(%rsp)
	movl	%esi, 416(%rsp)
	movq	496(%rsp), %rdi
	pxor	%xmm13, %xmm13
.L384:
	comisd	%xmm9, %xmm10
	movl	%r14d, 916(%rsp)
	movl	$1, 936(%rsp)
	jnb	.L1350
	movl	416(%rsp), %r10d
	testl	%r10d, %r10d
	je	.L392
	xorl	%eax, %eax
	pxor	%xmm6, %xmm6
	cmpl	$1, %r14d
	je	.L393
	movq	232(%rsp), %rdx
	.p2align 4,,10
.L394:
	movupd	(%rdx,%rax), %xmm0
	movupd	0(%rbp,%rax), %xmm2
	addq	$16, %rax
	mulpd	%xmm0, %xmm0
	mulpd	%xmm2, %xmm2
	divpd	%xmm2, %xmm0
	addsd	%xmm0, %xmm6
	unpckhpd	%xmm0, %xmm0
	addsd	%xmm0, %xmm6
	cmpq	176(%rsp), %rax
	jne	.L394
	movslq	192(%rsp), %rax
	cmpl	%eax, 184(%rsp)
	je	.L395
.L393:
	movq	112(%rsp), %rsi
	movsd	0(%r13,%rax,8), %xmm1
	movsd	(%rsi,%rax,8), %xmm0
	mulsd	%xmm1, %xmm1
	mulsd	%xmm0, %xmm0
	divsd	%xmm1, %xmm0
	addsd	%xmm0, %xmm6
.L395:
	movq	232(%rsp), %r8
	movq	%r15, %r10
	xorl	%eax, %eax
	xorl	%r9d, %r9d
	pxor	%xmm7, %xmm7
	movl	$1, %esi
	.p2align 4,,10
.L801:
	movl	%r14d, %edx
	movl	%esi, %r11d
	subl	%eax, %edx
	cmpl	%eax, %r14d
	cmovg	%edx, %r11d
	jle	.L832
	cmpl	$1, %edx
	je	.L832
	movq	600(%rsp), %rcx
	xorl	%edx, %edx
	pxor	%xmm0, %xmm0
	leaq	(%r8,%rcx), %r12
	movl	%r11d, %ecx
	shrl	%ecx
	salq	$4, %rcx
	.p2align 4,,10
.L396:
	movupd	(%r10,%rdx), %xmm1
	movupd	(%r8,%rdx), %xmm4
	movupd	(%r12,%rdx), %xmm3
	addq	$16, %rdx
	mulpd	%xmm4, %xmm1
	mulpd	%xmm3, %xmm3
	divpd	%xmm3, %xmm1
	addsd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm1, %xmm0
	cmpq	%rcx, %rdx
	jne	.L396
	movl	%r11d, %ecx
	andl	$-2, %ecx
	leal	(%rcx,%rax), %edx
	cmpl	%ecx, %r11d
	je	.L397
.L399:
	movslq	%edx, %rcx
	addl	%r9d, %edx
	movslq	%edx, %rdx
	movsd	0(%r13,%rcx,8), %xmm2
	movsd	(%r15,%rdx,8), %xmm1
	movq	112(%rsp), %rdx
	mulsd	%xmm2, %xmm2
	mulsd	(%rdx,%rcx,8), %xmm1
	divsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
.L397:
	mulsd	%xmm0, %xmm0
	addl	$1, %eax
	addq	$8, %r8
	addl	1184(%rsp), %r9d
	addq	200(%rsp), %r10
	addsd	%xmm0, %xmm7
	cmpl	%eax, %r14d
	jne	.L801
	movapd	%xmm6, %xmm0
	cmpb	$0, 655(%rsp)
	divsd	%xmm7, %xmm0
	xorpd	.LC8(%rip), %xmm0
	je	.L833
	movapd	%xmm0, %xmm2
	movq	232(%rsp), %rdx
	xorl	%eax, %eax
	unpcklpd	%xmm2, %xmm2
	.p2align 4,,10
.L402:
	movupd	(%rdx,%rax), %xmm1
	movupd	0(%rbp,%rax), %xmm4
	movq	216(%rsp), %rsi
	mulpd	%xmm2, %xmm1
	divpd	%xmm4, %xmm1
	movups	%xmm1, (%rsi,%rax)
	addq	$16, %rax
	cmpq	176(%rsp), %rax
	jne	.L402
	movl	192(%rsp), %esi
	cmpl	%esi, 184(%rsp)
	je	.L404
	movq	488(%rsp), %rax
	mulsd	(%rax), %xmm0
	movq	480(%rsp), %rax
	divsd	(%rax), %xmm0
	movq	576(%rsp), %rax
	movsd	%xmm0, (%rax)
.L404:
	ucomisd	%xmm6, %xmm11
	sqrtsd	%xmm6, %xmm8
	movapd	%xmm7, %xmm14
	xorpd	.LC8(%rip), %xmm14
	ja	.L1351
.L405:
	mulsd	%xmm6, %xmm8
	movq	112(%rsp), %rdx
	movq	%rbx, %r9
	movq	224(%rsp), %rax
	movq	208(%rsp), %rcx
	movq	%rax, 32(%rsp)
	movq	%rax, %r8
	divsd	%xmm7, %xmm8
	movsd	.LC26(%rip), %xmm7
	call	ddot_
	movl	916(%rsp), %edx
	mulsd	%xmm6, %xmm7
	mulsd	%xmm0, %xmm14
	mulsd	%xmm7, %xmm6
	movsd	.LC27(%rip), %xmm7
	divsd	%xmm14, %xmm6
	addsd	%xmm6, %xmm7
	testl	%edx, %edx
	jle	.L413
	leal	-1(%rdx), %eax
	cmpl	$1, %eax
	seta	%cl
	testb	%cl, 651(%rsp)
	je	.L410
	cmpb	$0, 530(%rsp)
	je	.L410
	movl	%edx, %ecx
	movapd	%xmm7, %xmm1
	movq	168(%rsp), %r8
	xorl	%eax, %eax
	shrl	%ecx
	movq	216(%rsp), %r9
	unpcklpd	%xmm1, %xmm1
	salq	$4, %rcx
	.p2align 4,,10
.L411:
	movupd	0(%rbp,%rax), %xmm0
	movupd	(%r8,%rax), %xmm5
	movupd	(%r9,%rax), %xmm4
	movq	256(%rsp), %rsi
	mulpd	%xmm1, %xmm0
	mulpd	%xmm5, %xmm0
	subpd	%xmm4, %xmm0
	movups	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpq	%rcx, %rax
	jne	.L411
	movl	%edx, %eax
	andl	$-2, %eax
	cmpl	%eax, %edx
	je	.L413
	movsd	0(%r13,%rax,8), %xmm0
	movq	128(%rsp), %rsi
	mulsd	%xmm7, %xmm0
	mulsd	(%rbx,%rax,8), %xmm0
	subsd	(%rsi,%rax,8), %xmm0
	movq	160(%rsp), %rsi
	movsd	%xmm0, (%rsi,%rax,8)
.L413:
	ucomisd	.LC9(%rip), %xmm10
	jnp	.L1352
.L916:
	movapd	%xmm10, %xmm6
.L409:
	movapd	%xmm9, %xmm0
	mulsd	%xmm7, %xmm0
	comisd	%xmm0, %xmm6
	jb	.L417
	movl	916(%rsp), %eax
	testl	%eax, %eax
	jle	.L423
.L419:
	movapd	%xmm6, %xmm0
	leal	-1(%rax), %edx
	divsd	%xmm9, %xmm0
	cmpl	$2, %edx
	jbe	.L420
	cmpb	$0, 654(%rsp)
	je	.L420
	movl	%eax, %ecx
	movapd	%xmm0, %xmm2
	movq	168(%rsp), %r8
	xorl	%edx, %edx
	shrl	%ecx
	unpcklpd	%xmm2, %xmm2
	salq	$4, %rcx
	.p2align 4,,10
.L421:
	movupd	(%r8,%rdx), %xmm1
	movq	144(%rsp), %rsi
	mulpd	%xmm2, %xmm1
	movups	%xmm1, (%rsi,%rdx)
	addq	$16, %rdx
	cmpq	%rcx, %rdx
	jne	.L421
	movl	%eax, %edx
	andl	$-2, %edx
	cmpl	%edx, %eax
	je	.L423
	movl	%edx, %eax
	mulsd	(%rbx,%rax,8), %xmm0
	movsd	%xmm0, (%rdi,%rax,8)
.L423:
	movl	$0, 416(%rsp)
.L391:
	xorl	%eax, %eax
	cmpb	$0, 479(%rsp)
	movl	%r14d, 916(%rsp)
	movl	$1, 936(%rsp)
	je	.L838
	movq	144(%rsp), %rdx
	movq	1200(%rsp), %rcx
	.p2align 4,,10
.L443:
	movupd	(%rcx,%rax), %xmm0
	movupd	(%rdx,%rax), %xmm4
	movq	1344(%rsp), %rsi
	addpd	%xmm4, %xmm0
	movups	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpq	176(%rsp), %rax
	jne	.L443
	movl	192(%rsp), %esi
	cmpl	%esi, 184(%rsp)
	je	.L445
	movq	392(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	280(%rsp), %rax
	addsd	(%rax), %xmm0
	movq	400(%rsp), %rax
	movsd	%xmm0, (%rax)
.L445:
	movq	1232(%rsp), %r9
	movq	1352(%rsp), %r8
	movl	%r14d, %ecx
	movq	1344(%rsp), %rdx
	call	*1208(%rsp)
	movq	112(%rsp), %rdx
	movq	%rdi, %r9
	movq	1352(%rsp), %rax
	movq	208(%rsp), %rcx
	movsd	(%rax), %xmm15
	movq	224(%rsp), %rax
	subsd	448(%rsp), %xmm15
	movq	%rax, 32(%rsp)
	movq	%rax, %r8
	call	ddot_
	cmpl	$3, 368(%rsp)
	movapd	%xmm0, %xmm14
	je	.L1353
	movsd	.LC23(%rip), %xmm0
	mulsd	%xmm14, %xmm0
.L448:
	comisd	%xmm0, %xmm15
	movl	916(%rsp), %edx
	ja	.L456
	pxor	%xmm3, %xmm3
	testl	%edx, %edx
	jle	.L458
	movq	144(%rsp), %r11
	movl	%edx, %r8d
	movq	%r15, %r10
	xorl	%eax, %eax
	xorl	%r9d, %r9d
	pxor	%xmm3, %xmm3
	.p2align 4,,10
.L469:
	cmpl	%edx, %eax
	movl	$1, %esi
	cmovl	%r8d, %esi
	jge	.L842
	cmpl	$1, %r8d
	je	.L842
	movl	%esi, %r12d
	xorl	%ecx, %ecx
	pxor	%xmm0, %xmm0
	shrl	%r12d
	salq	$4, %r12
	.p2align 4,,10
.L467:
	movupd	(%r10,%rcx), %xmm1
	movupd	(%r11,%rcx), %xmm4
	addq	$16, %rcx
	mulpd	%xmm4, %xmm1
	addsd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm1, %xmm0
	cmpq	%r12, %rcx
	jne	.L467
	movl	%esi, %r12d
	andl	$-2, %r12d
	leal	(%r12,%rax), %ecx
	cmpl	%r12d, %esi
	je	.L468
.L466:
	leal	(%r9,%rcx), %esi
	movslq	%ecx, %rcx
	movslq	%esi, %rsi
	movsd	(%r15,%rsi,8), %xmm1
	mulsd	(%rdi,%rcx,8), %xmm1
	addsd	%xmm1, %xmm0
.L468:
	mulsd	%xmm0, %xmm0
	addl	$1, %eax
	subl	$1, %r8d
	addq	$8, %r11
	addl	1184(%rsp), %r9d
	addq	504(%rsp), %r10
	addsd	%xmm0, %xmm3
	cmpl	%edx, %eax
	jne	.L469
	mulsd	.LC5(%rip), %xmm3
.L458:
	cmpl	$2, 368(%rsp)
	addsd	%xmm14, %xmm3
	movsd	1328(%rsp), %xmm2
	mulsd	.LC24(%rip), %xmm2
	je	.L470
	movapd	%xmm15, %xmm1
	andpd	.LC2(%rip), %xmm1
	movapd	%xmm3, %xmm0
	mulsd	.LC12(%rip), %xmm1
	subsd	%xmm15, %xmm0
	andpd	.LC2(%rip), %xmm0
	comisd	%xmm0, %xmm1
	jb	.L470
	comisd	%xmm9, %xmm10
	jb	.L470
	comisd	%xmm6, %xmm2
	jb	.L470
	testl	%edx, %edx
	jle	.L479
	leal	-1(%rdx), %eax
	cmpl	$3, %eax
	jbe	.L476
	cmpb	$0, 611(%rsp)
	je	.L476
	movl	%edx, %ecx
	movq	584(%rsp), %r8
	movq	1344(%rsp), %r9
	xorl	%eax, %eax
	shrl	%ecx
	salq	$4, %rcx
	.p2align 4,,10
.L477:
	movupd	(%r9,%rax), %xmm5
	movups	%xmm5, (%r8,%rax)
	addq	$16, %rax
	cmpq	%rcx, %rax
	jne	.L477
	movl	%edx, %eax
	andl	$-2, %eax
	cmpl	%eax, %edx
	je	.L479
	movq	1344(%rsp), %rsi
	movsd	(%rsi,%rax,8), %xmm0
	movq	344(%rsp), %rsi
	movsd	%xmm0, (%rsi,%rax,8)
.L479:
	addsd	%xmm6, %xmm6
	movq	1352(%rsp), %rax
	movsd	1328(%rsp), %xmm1
	movsd	(%rax), %xmm13
	movapd	%xmm6, %xmm0
	call	Rf_fmin2
	movl	$3, 368(%rsp)
	movapd	%xmm0, %xmm10
	jmp	.L384
	.p2align 4,,10
.L470:
	movsd	.LC12(%rip), %xmm0
	xorl	%esi, %esi
	comisd	%xmm2, %xmm6
	movapd	%xmm12, %xmm14
	movsd	320(%rsp), %xmm12
	mulsd	%xmm3, %xmm0
	seta	%sil
	comisd	%xmm0, %xmm15
	jnb	.L1310
	movsd	.LC28(%rip), %xmm0
	mulsd	%xmm0, %xmm3
	comisd	%xmm15, %xmm3
	jb	.L1309
	movsd	1328(%rsp), %xmm1
	addsd	%xmm6, %xmm6
	xorl	%ebx, %ebx
	movapd	%xmm6, %xmm0
	call	Rf_fmin2
	movapd	%xmm0, %xmm6
	jmp	.L378
	.p2align 4,,10
.L842:
	movl	%eax, %ecx
	pxor	%xmm0, %xmm0
	jmp	.L466
	.p2align 4,,10
.L456:
	testl	%edx, %edx
	jle	.L841
	movsd	.LC0(%rip), %xmm3
	pxor	%xmm2, %xmm2
	xorl	%esi, %esi
	movq	1344(%rsp), %r12
	movsd	%xmm12, 368(%rsp)
	movapd	%xmm9, %xmm12
	movapd	%xmm7, %xmm9
	movsd	%xmm13, 440(%rsp)
	movapd	%xmm3, %xmm7
	movapd	%xmm6, %xmm13
	movapd	%xmm2, %xmm6
	.p2align 4,,10
.L462:
	movsd	(%r12,%rsi,8), %xmm0
	movsd	(%rdi,%rsi,8), %xmm10
	movapd	%xmm7, %xmm1
	divsd	0(%r13,%rsi,8), %xmm1
	andpd	.LC2(%rip), %xmm0
	addq	$1, %rsi
	andpd	.LC2(%rip), %xmm10
	call	Rf_fmax2
	divsd	%xmm0, %xmm10
	maxsd	%xmm6, %xmm10
	movapd	%xmm10, %xmm6
	cmpl	%esi, 916(%rsp)
	jg	.L462
	movapd	%xmm9, %xmm7
	movapd	%xmm13, %xmm6
	movapd	%xmm12, %xmm9
	movsd	440(%rsp), %xmm13
	movsd	368(%rsp), %xmm12
	movapd	%xmm10, %xmm2
.L459:
	movsd	1336(%rsp), %xmm5
	comisd	%xmm2, %xmm5
	ja	.L463
	movapd	%xmm14, %xmm0
	subsd	%xmm14, %xmm15
	xorpd	.LC8(%rip), %xmm0
	movsd	.LC12(%rip), %xmm10
	movl	$2, 368(%rsp)
	mulsd	%xmm6, %xmm0
	addsd	%xmm15, %xmm15
	mulsd	%xmm6, %xmm10
	divsd	%xmm15, %xmm0
	maxsd	%xmm0, %xmm10
	jmp	.L384
	.p2align 4,,10
.L1353:
	movq	1352(%rsp), %rax
	movsd	(%rax), %xmm0
	comisd	%xmm13, %xmm0
	jnb	.L447
	movsd	.LC23(%rip), %xmm0
	mulsd	%xmm14, %xmm0
	comisd	%xmm0, %xmm15
	jbe	.L448
.L447:
	movl	916(%rsp), %ecx
	movapd	%xmm12, %xmm14
	movsd	320(%rsp), %xmm12
	testl	%ecx, %ecx
	jle	.L455
	leal	-1(%rcx), %eax
	cmpl	$3, %eax
	jbe	.L449
	cmpb	$0, 611(%rsp)
	je	.L449
	movl	%ecx, %edx
	movq	584(%rsp), %r8
	xorl	%eax, %eax
	shrl	%edx
	salq	$4, %rdx
	.p2align 4,,10
.L450:
	movupd	(%r8,%rax), %xmm4
	movq	1344(%rsp), %rbx
	movups	%xmm4, (%rbx,%rax)
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L450
	movl	%ecx, %eax
	andl	$-2, %eax
	cmpl	%eax, %ecx
	je	.L455
	movq	%rbx, %rsi
	movq	344(%rsp), %rbx
	movsd	(%rbx,%rax,8), %xmm0
	movsd	%xmm0, (%rsi,%rax,8)
.L455:
	movq	1352(%rsp), %rax
	mulsd	.LC5(%rip), %xmm6
	xorl	%ebx, %ebx
	xorl	%esi, %esi
	movsd	%xmm13, (%rax)
	jmp	.L378
	.p2align 4,,10
.L838:
	movq	1200(%rsp), %rcx
	movq	1344(%rsp), %rsi
	jmp	.L442
	.p2align 4,,10
.L839:
	movq	%rdx, %rax
.L442:
	movsd	(%rcx,%rax,8), %xmm0
	addsd	(%rdi,%rax,8), %xmm0
	leaq	1(%rax), %rdx
	movsd	%xmm0, (%rsi,%rax,8)
	cmpq	272(%rsp), %rax
	jne	.L839
	jmp	.L445
	.p2align 4,,10
.L417:
	comisd	%xmm6, %xmm8
	jb	.L1277
	movl	916(%rsp), %edx
	testl	%edx, %edx
	jle	.L423
	movapd	%xmm6, %xmm0
	movzbl	478(%rsp), %esi
	divsd	%xmm8, %xmm0
	testb	%sil, 531(%rsp)
	je	.L429
	cmpl	$1, %edx
	je	.L429
	movl	%edx, %ecx
	movapd	%xmm0, %xmm2
	movq	216(%rsp), %r8
	xorl	%eax, %eax
	shrl	%ecx
	unpcklpd	%xmm2, %xmm2
	salq	$4, %rcx
	.p2align 4,,10
.L430:
	movupd	(%r8,%rax), %xmm1
	movupd	0(%rbp,%rax), %xmm5
	movq	144(%rsp), %rsi
	mulpd	%xmm2, %xmm1
	divpd	%xmm5, %xmm1
	movups	%xmm1, (%rsi,%rax)
	addq	$16, %rax
	cmpq	%rcx, %rax
	jne	.L430
	movl	%edx, %eax
	andl	$-2, %eax
	cmpl	%eax, %edx
	je	.L423
	movq	128(%rsp), %rsi
	mulsd	(%rsi,%rax,8), %xmm0
	divsd	0(%r13,%rax,8), %xmm0
	movsd	%xmm0, (%rdi,%rax,8)
	jmp	.L423
	.p2align 4,,10
.L832:
	movl	%eax, %edx
	pxor	%xmm0, %xmm0
	jmp	.L399
	.p2align 4,,10
.L392:
	movapd	%xmm9, %xmm0
	movapd	%xmm10, %xmm6
	mulsd	%xmm7, %xmm0
	comisd	%xmm0, %xmm10
	jb	.L417
	movl	%r14d, %eax
	movapd	%xmm10, %xmm6
	jmp	.L419
	.p2align 4,,10
.L1350:
	xorl	%eax, %eax
	cmpb	$0, 608(%rsp)
	je	.L387
	movq	168(%rsp), %rdx
	.p2align 4,,10
.L388:
	movupd	(%rdx,%rax), %xmm5
	movq	144(%rsp), %rsi
	movups	%xmm5, (%rsi,%rax)
	addq	$16, %rax
	cmpq	176(%rsp), %rax
	jne	.L388
	movl	192(%rsp), %esi
	cmpl	%esi, 184(%rsp)
	je	.L390
	movq	384(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	280(%rsp), %rax
	movsd	%xmm0, (%rax)
.L390:
	movapd	%xmm9, %xmm6
	jmp	.L391
	.p2align 4,,10
.L387:
	movsd	(%rbx,%rax,8), %xmm0
	movsd	%xmm0, (%rdi,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r14d
	jg	.L387
	jmp	.L390
	.p2align 4,,10
.L463:
	movl	352(%rsp), %r9d
	testl	%r9d, %r9d
	jne	.L1354
	movq	112(%rsp), %rax
	movq	%r13, 32(%rsp)
	movl	%r14d, %ecx
	movq	1232(%rsp), %r9
	movq	1208(%rsp), %r8
	movsd	360(%rsp), %xmm4
	movq	%rax, 48(%rsp)
	movq	1200(%rsp), %rdx
	movsd	%xmm4, 40(%rsp)
	call	fstocd
	movsd	456(%rsp), %xmm10
.L611:
	movl	$-1, 352(%rsp)
	xorl	%eax, %eax
	cmpb	$0, 856(%rsp)
	jne	.L1355
.L821:
	movq	128(%rsp), %rcx
	movq	112(%rsp), %r8
	jmp	.L325
	.p2align 4,,10
.L822:
	movq	%rdx, %rax
.L325:
	movsd	(%r8,%rax,8), %xmm0
	xorpd	.LC8(%rip), %xmm0
	leaq	1(%rax), %rdx
	movsd	%xmm0, (%rcx,%rax,8)
	cmpq	272(%rsp), %rax
	jne	.L822
	jmp	.L328
	.p2align 4,,10
.L1352:
	jne	.L916
	movsd	1328(%rsp), %xmm1
	movapd	%xmm8, %xmm0
	call	Rf_fmin2
	movapd	%xmm0, %xmm6
	jmp	.L409
	.p2align 4,,10
.L331:
	movsd	920(%rsp), %xmm14
	movl	%r14d, 912(%rsp)
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movl	$1, 916(%rsp)
	cmpl	$1, %r14d
	je	.L334
	movq	168(%rsp), %rdx
	movapd	%xmm0, %xmm2
	.p2align 4,,10
.L335:
	movupd	0(%rbp,%rax), %xmm1
	movupd	(%rdx,%rax), %xmm4
	addq	$16, %rax
	mulpd	%xmm1, %xmm1
	mulpd	%xmm4, %xmm1
	mulpd	%xmm4, %xmm1
	movapd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm2, %xmm0
	movapd	%xmm1, %xmm2
	addsd	%xmm0, %xmm2
	cmpq	288(%rsp), %rax
	jne	.L335
	movslq	472(%rsp), %rax
	movapd	%xmm2, %xmm0
	cmpl	%r14d, %eax
	je	.L336
.L334:
	movsd	0(%r13,%rax,8), %xmm1
	movsd	(%rbx,%rax,8), %xmm2
	mulsd	%xmm1, %xmm1
	mulsd	%xmm2, %xmm1
	mulsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
.L336:
	sqrtsd	%xmm0, %xmm5
	ucomisd	%xmm0, %xmm11
	movsd	%xmm5, 440(%rsp)
	ja	.L1356
.L337:
	movsd	440(%rsp), %xmm5
	comisd	1328(%rsp), %xmm5
	ja	.L1357
.L338:
	movq	208(%rsp), %rax
	movq	304(%rsp), %rcx
	movq	%rbx, %r9
	movq	112(%rsp), %rdx
	movq	%rax, 32(%rsp)
	movq	%rax, %r8
	call	ddot_
	movl	912(%rsp), %ecx
	movapd	%xmm0, %xmm7
	testl	%ecx, %ecx
	jle	.L825
	movsd	.LC0(%rip), %xmm8
	movq	1200(%rsp), %rdi
	xorl	%esi, %esi
	pxor	%xmm9, %xmm9
	movq	.LC2(%rip), %xmm13
	.p2align 4,,10
.L343:
	movsd	(%rdi,%rsi,8), %xmm0
	movsd	(%rbx,%rsi,8), %xmm6
	movapd	%xmm8, %xmm1
	divsd	0(%r13,%rsi,8), %xmm1
	addq	$1, %rsi
	andpd	%xmm13, %xmm0
	andpd	%xmm13, %xmm6
	call	Rf_fmax2
	movl	912(%rsp), %ecx
	divsd	%xmm0, %xmm6
	maxsd	%xmm9, %xmm6
	movapd	%xmm6, %xmm9
	cmpl	%esi, %ecx
	jg	.L343
.L340:
	movsd	1336(%rsp), %xmm5
	movq	%rbx, %rdi
	movsd	.LC23(%rip), %xmm4
	movq	%rbp, 512(%rsp)
	pxor	%xmm6, %xmm6
	pxor	%xmm15, %xmm15
	movl	$1, %esi
	movq	168(%rsp), %r12
	divsd	%xmm9, %xmm5
	movapd	%xmm8, %xmm9
	movq	1200(%rsp), %rbp
	movq	1344(%rsp), %rbx
	movsd	%xmm4, 416(%rsp)
	movsd	%xmm12, 448(%rsp)
	movsd	%xmm5, 368(%rsp)
	.p2align 4,,10
.L344:
	testl	%ecx, %ecx
	jle	.L351
	movzbl	609(%rsp), %r11d
	leal	-1(%rcx), %edx
	testb	%r11b, 528(%rsp)
	je	.L348
	cmpl	$2, %edx
	jbe	.L348
	movl	%ecx, %r8d
	movapd	%xmm9, %xmm1
	xorl	%edx, %edx
	shrl	%r8d
	unpcklpd	%xmm1, %xmm1
	salq	$4, %r8
	.p2align 4,,10
.L349:
	movupd	(%r12,%rdx), %xmm0
	movupd	0(%rbp,%rdx), %xmm4
	mulpd	%xmm1, %xmm0
	addpd	%xmm4, %xmm0
	movups	%xmm0, (%rbx,%rdx)
	addq	$16, %rdx
	cmpq	%r8, %rdx
	jne	.L349
	movl	%ecx, %edx
	andl	$-2, %edx
	cmpl	%edx, %ecx
	je	.L351
	movsd	(%rdi,%rdx,8), %xmm0
	mulsd	%xmm9, %xmm0
	addsd	0(%rbp,%rdx,8), %xmm0
	movsd	%xmm0, (%rbx,%rdx,8)
.L351:
	movq	1232(%rsp), %r9
	movq	1352(%rsp), %r8
	movq	%rbx, %rdx
	call	*1208(%rsp)
	movq	1352(%rsp), %rax
	movsd	416(%rsp), %xmm0
	mulsd	%xmm7, %xmm0
	movsd	(%rax), %xmm1
	movapd	%xmm1, %xmm5
	mulsd	%xmm9, %xmm0
	addsd	%xmm14, %xmm0
	comisd	%xmm1, %xmm0
	jnb	.L1358
	movsd	368(%rsp), %xmm4
	comisd	%xmm9, %xmm4
	ja	.L359
	comisd	.LC25(%rip), %xmm1
	jb	.L1270
	movsd	.LC12(%rip), %xmm0
	movl	$1, %esi
	mulsd	%xmm9, %xmm0
	movapd	%xmm6, %xmm9
.L362:
	movapd	%xmm9, %xmm6
	movl	912(%rsp), %ecx
	movapd	%xmm0, %xmm9
	jmp	.L344
	.p2align 4,,10
.L1270:
	movapd	%xmm1, %xmm0
	subsd	%xmm14, %xmm0
	testl	%esi, %esi
	je	.L363
	movapd	%xmm9, %xmm2
	subsd	%xmm7, %xmm0
	movapd	%xmm1, %xmm15
	xorpd	.LC8(%rip), %xmm2
	mulsd	%xmm7, %xmm2
	addsd	%xmm0, %xmm0
	divsd	%xmm0, %xmm2
	movapd	%xmm2, %xmm0
.L364:
	movsd	.LC12(%rip), %xmm1
	xorl	%esi, %esi
	mulsd	%xmm9, %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L362
	movapd	%xmm1, %xmm0
	xorl	%esi, %esi
	jmp	.L362
	.p2align 4,,10
.L363:
	movapd	%xmm7, %xmm2
	subsd	%xmm14, %xmm15
	movapd	%xmm8, %xmm3
	mulsd	%xmm9, %xmm2
	movapd	%xmm6, %xmm4
	mulsd	%xmm6, %xmm4
	subsd	%xmm2, %xmm0
	movapd	%xmm7, %xmm2
	mulsd	%xmm6, %xmm2
	movapd	%xmm0, %xmm12
	mulsd	%xmm6, %xmm0
	subsd	%xmm2, %xmm15
	movapd	%xmm9, %xmm2
	subsd	%xmm6, %xmm2
	movapd	%xmm15, %xmm13
	divsd	%xmm2, %xmm3
	movapd	%xmm9, %xmm2
	mulsd	%xmm9, %xmm2
	mulsd	%xmm9, %xmm15
	divsd	%xmm4, %xmm13
	divsd	%xmm2, %xmm12
	divsd	%xmm2, %xmm0
	subsd	%xmm13, %xmm12
	movapd	%xmm12, %xmm13
	movsd	.LC6(%rip), %xmm12
	mulsd	%xmm3, %xmm12
	mulsd	%xmm13, %xmm12
	divsd	%xmm4, %xmm15
	subsd	%xmm0, %xmm15
	movapd	%xmm7, %xmm0
	mulsd	%xmm12, %xmm0
	mulsd	%xmm15, %xmm3
	movapd	%xmm3, %xmm2
	mulsd	%xmm3, %xmm2
	movapd	%xmm2, %xmm4
	subsd	%xmm0, %xmm4
	comisd	%xmm2, %xmm4
	movapd	%xmm4, %xmm0
	jbe	.L1271
	comisd	%xmm12, %xmm11
	sqrtsd	%xmm4, %xmm6
	ja	.L1359
	ucomisd	%xmm4, %xmm11
	ja	.L1360
.L370:
	subsd	%xmm3, %xmm6
	movapd	%xmm1, %xmm15
	movapd	%xmm6, %xmm0
	divsd	%xmm12, %xmm0
.L371:
	movsd	.LC5(%rip), %xmm1
	mulsd	%xmm9, %xmm1
	minsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	jmp	.L364
	.p2align 4,,10
.L348:
	movl	%edx, %r8d
	xorl	%edx, %edx
	jmp	.L353
	.p2align 4,,10
.L826:
	movq	%rax, %rdx
.L353:
	movsd	(%rdi,%rdx,8), %xmm0
	leaq	1(%rdx), %rax
	mulsd	%xmm9, %xmm0
	addsd	0(%rbp,%rdx,8), %xmm0
	movsd	%xmm0, (%rbx,%rdx,8)
	cmpq	%r8, %rdx
	jne	.L826
	jmp	.L351
	.p2align 4,,10
.L1271:
	comisd	%xmm12, %xmm11
	sqrtsd	%xmm4, %xmm6
	ja	.L1361
	ucomisd	%xmm4, %xmm11
	ja	.L1362
.L375:
	xorpd	.LC8(%rip), %xmm6
	movapd	%xmm1, %xmm15
.L374:
	subsd	%xmm3, %xmm6
	movapd	%xmm6, %xmm0
	divsd	%xmm12, %xmm0
	jmp	.L371
	.p2align 4,,10
.L1277:
	movq	224(%rsp), %rsi
	movq	160(%rsp), %r12
	movq	128(%rsp), %r9
	movq	208(%rsp), %rcx
	movq	%rsi, 32(%rsp)
	movq	%rsi, %r8
	movq	%r12, %rdx
	call	ddot_
	movq	%rsi, 32(%rsp)
	movq	%rsi, %r8
	movq	%r12, %r9
	movq	208(%rsp), %rcx
	movq	%r12, %rdx
	movapd	%xmm0, %xmm14
	call	ddot_
	movapd	%xmm6, %xmm3
	movapd	%xmm8, %xmm1
	mulsd	%xmm6, %xmm3
	movapd	%xmm0, %xmm15
	movapd	%xmm14, %xmm0
	mulsd	%xmm8, %xmm1
	mulsd	%xmm14, %xmm0
	subsd	%xmm3, %xmm1
	mulsd	%xmm15, %xmm1
	subsd	%xmm1, %xmm0
	ucomisd	%xmm0, %xmm11
	sqrtsd	%xmm0, %xmm1
	ja	.L1363
.L435:
	subsd	%xmm14, %xmm1
	movl	916(%rsp), %ecx
	movapd	%xmm1, %xmm0
	divsd	%xmm15, %xmm0
	testl	%ecx, %ecx
	jle	.L423
	movzbl	531(%rsp), %edx
	andb	478(%rsp), %dl
	cmpl	$1, %ecx
	setne	%al
	testb	%al, %dl
	je	.L436
	cmpb	$0, 610(%rsp)
	je	.L436
	movl	%ecx, %edx
	movapd	%xmm0, %xmm2
	movq	144(%rsp), %r8
	xorl	%eax, %eax
	shrl	%edx
	movq	256(%rsp), %r9
	movq	216(%rsp), %r10
	unpcklpd	%xmm2, %xmm2
	salq	$4, %rdx
	.p2align 4,,10
.L437:
	movupd	(%r9,%rax), %xmm1
	movupd	(%r10,%rax), %xmm4
	movupd	0(%rbp,%rax), %xmm5
	mulpd	%xmm2, %xmm1
	addpd	%xmm4, %xmm1
	divpd	%xmm5, %xmm1
	movups	%xmm1, (%r8,%rax)
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L437
	movl	%ecx, %eax
	andl	$-2, %eax
	cmpl	%eax, %ecx
	je	.L423
	movq	160(%rsp), %rsi
	mulsd	(%rsi,%rax,8), %xmm0
	movq	128(%rsp), %rsi
	addsd	(%rsi,%rax,8), %xmm0
	divsd	0(%r13,%rax,8), %xmm0
	movsd	%xmm0, (%rdi,%rax,8)
	jmp	.L423
	.p2align 4,,10
.L1333:
	addq	$8, %rdx
	jmp	.L306
	.p2align 4,,10
.L273:
	movq	%rcx, %rbx
	jmp	.L278
	.p2align 4,,10
.L815:
	movq	%rdi, %rbx
.L278:
	movsd	(%rbx), %xmm0
	leaq	8(%rbx), %rdi
	movsd	%xmm0, (%rax)
	addq	%r10, %rax
	cmpq	%r8, %rbx
	jne	.L815
	jmp	.L279
	.p2align 4,,10
.L359:
	movl	352(%rsp), %r11d
	movq	%rdi, %rbx
	movsd	448(%rsp), %xmm12
	movq	512(%rsp), %rbp
	testl	%r11d, %r11d
	jne	.L1364
	movq	112(%rsp), %rax
	movq	%r13, 32(%rsp)
	movl	%r14d, %ecx
	movq	1232(%rsp), %r9
	movq	1208(%rsp), %r8
	movsd	360(%rsp), %xmm4
	movq	%rax, 48(%rsp)
	movq	1200(%rsp), %rdx
	movsd	%xmm4, 40(%rsp)
	call	fstocd
	cmpl	$1, 1256(%rsp)
	je	.L611
	cmpl	$2, 1256(%rsp)
	jne	.L1365
	movsd	456(%rsp), %xmm10
	jmp	.L611
	.p2align 4,,10
.L849:
	movq	264(%rsp), %rdx
	.p2align 4,,10
.L507:
	movsd	(%rdx,%rax,8), %xmm0
	movsd	%xmm0, (%r14,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r15d
	jg	.L507
	jmp	.L510
	.p2align 4,,10
.L850:
	movq	160(%rsp), %rdx
	movq	264(%rsp), %rcx
	.p2align 4,,10
.L515:
	movsd	(%r12,%rax,8), %xmm0
	mulsd	%xmm0, %xmm0
	mulsd	(%rcx,%rax,8), %xmm0
	movsd	%xmm0, (%rdx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r15d
	jg	.L515
	jmp	.L518
	.p2align 4,,10
.L410:
	movl	%eax, %edx
	movq	160(%rsp), %r8
	xorl	%eax, %eax
	movq	128(%rsp), %r9
	jmp	.L415
	.p2align 4,,10
.L834:
	movq	%rcx, %rax
.L415:
	movsd	0(%r13,%rax,8), %xmm0
	leaq	1(%rax), %rcx
	mulsd	%xmm7, %xmm0
	mulsd	(%rbx,%rax,8), %xmm0
	subsd	(%r9,%rax,8), %xmm0
	movsd	%xmm0, (%r8,%rax,8)
	cmpq	%rdx, %rax
	jne	.L834
	jmp	.L413
	.p2align 4,,10
.L833:
	movq	128(%rsp), %rdx
	movq	112(%rsp), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
.L401:
	movsd	(%rcx,%rax,8), %xmm1
	mulsd	%xmm0, %xmm1
	divsd	0(%r13,%rax,8), %xmm1
	movsd	%xmm1, (%rdx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r14d
	jg	.L401
	jmp	.L404
	.p2align 4,,10
.L420:
	xorl	%eax, %eax
	jmp	.L425
	.p2align 4,,10
.L835:
	movq	%rcx, %rax
.L425:
	movsd	(%rbx,%rax,8), %xmm1
	leaq	1(%rax), %rcx
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, (%rdi,%rax,8)
	cmpq	%rdx, %rax
	jne	.L835
	jmp	.L423
	.p2align 4,,10
.L1348:
	movsd	1328(%rsp), %xmm1
	movapd	%xmm12, %xmm0
	xorl	%ebx, %ebx
	addsd	%xmm12, %xmm0
	call	Rf_fmin2
	movapd	%xmm0, %xmm6
	jmp	.L378
	.p2align 4,,10
.L1359:
	ucomisd	%xmm4, %xmm11
	ja	.L1366
.L369:
	xorpd	.LC8(%rip), %xmm6
	movapd	%xmm5, %xmm1
	jmp	.L370
	.p2align 4,,10
.L1361:
	ucomisd	%xmm4, %xmm11
	ja	.L1367
	movapd	%xmm1, %xmm15
	jmp	.L374
	.p2align 4,,10
.L1326:
	leaq	928(%rsp), %rax
	movq	%r14, 48(%rsp)
	movl	%r13d, %ecx
	movsd	360(%rsp), %xmm4
	movq	%rax, 64(%rsp)
	movq	112(%rsp), %rax
	movq	%rbx, 32(%rsp)
	movq	1232(%rsp), %r9
	movq	%rax, 40(%rsp)
	movq	1208(%rsp), %r8
	movq	1200(%rsp), %rdx
	movsd	%xmm4, 56(%rsp)
	call	fstofd.constprop.5
	jmp	.L198
	.p2align 4,,10
.L249:
	pxor	%xmm1, %xmm1
	movapd	%xmm8, %xmm0
	call	Rf_fmax2
	movsd	.LC19(%rip), %xmm7
	movapd	%xmm0, %xmm1
	mulsd	%xmm7, %xmm1
	comisd	%xmm8, %xmm1
	jnb	.L257
	movsd	(%r15), %xmm0
	movq	1384(%rsp), %rax
	movsd	%xmm0, (%rax)
.L265:
	movq	224(%rsp), %rax
	movapd	%xmm8, %xmm3
	movq	%r15, %r8
	movl	%r14d, %edx
	movl	1184(%rsp), %ecx
	movsd	%xmm7, 32(%rsp)
	movq	%rax, 40(%rsp)
	call	choldc
	movsd	936(%rsp), %xmm1
	comisd	%xmm11, %xmm1
	jbe	.L270
	movq	1384(%rsp), %rax
	movsd	(%rax), %xmm0
	movsd	%xmm0, (%r15)
	jmp	.L272
	.p2align 4,,10
.L568:
	movl	%eax, %edx
	movq	128(%rsp), %r8
	xorl	%eax, %eax
	movq	1344(%rsp), %r9
	jmp	.L571
	.p2align 4,,10
.L858:
	movq	%rcx, %rax
.L571:
	movsd	(%r8,%rax,8), %xmm0
	leaq	1(%rax), %rcx
	movsd	%xmm0, (%r9,%rax,8)
	cmpq	%rax, %rdx
	jne	.L858
	jmp	.L574
	.p2align 4,,10
.L449:
	movl	%eax, %edx
	movq	344(%rsp), %r8
	xorl	%eax, %eax
	movq	1344(%rsp), %r9
	jmp	.L452
	.p2align 4,,10
.L840:
	movq	%rcx, %rax
.L452:
	movsd	(%r8,%rax,8), %xmm0
	leaq	1(%rax), %rcx
	movsd	%xmm0, (%r9,%rax,8)
	cmpq	%rdx, %rax
	jne	.L840
	jmp	.L455
	.p2align 4,,10
.L816:
	pxor	%xmm2, %xmm2
	movl	$1, %eax
	jmp	.L280
	.p2align 4,,10
.L818:
	movl	%edx, %eax
	jmp	.L290
	.p2align 4,,10
.L859:
	pxor	%xmm13, %xmm13
	jmp	.L578
	.p2align 4,,10
.L841:
	pxor	%xmm2, %xmm2
	jmp	.L459
	.p2align 4,,10
.L429:
	leal	-1(%rdx), %ecx
	xorl	%eax, %eax
	movq	128(%rsp), %r8
	jmp	.L433
	.p2align 4,,10
.L836:
	movq	%rdx, %rax
.L433:
	movsd	(%r8,%rax,8), %xmm1
	leaq	1(%rax), %rdx
	mulsd	%xmm0, %xmm1
	divsd	0(%r13,%rax,8), %xmm1
	movsd	%xmm1, (%rdi,%rax,8)
	cmpq	%rcx, %rax
	jne	.L836
	jmp	.L423
	.p2align 4,,10
.L1358:
	ucomisd	%xmm8, %xmm9
	movl	$0, %ebx
	movq	512(%rsp), %rax
	movsd	448(%rsp), %xmm14
	movsd	320(%rsp), %xmm12
	movapd	%xmm10, %xmm6
	movq	%rax, 152(%rsp)
	jp	.L1308
	jne	.L1308
	movsd	1328(%rsp), %xmm0
	mulsd	.LC24(%rip), %xmm0
	xorl	%esi, %esi
	movsd	440(%rsp), %xmm4
	comisd	%xmm0, %xmm4
	seta	%sil
	jmp	.L378
	.p2align 4,,10
.L1335:
	ucomisd	.LC9(%rip), %xmm10
	jp	.L1281
	jne	.L1281
	xorl	%eax, %eax
	pxor	%xmm6, %xmm6
	cmpl	$1, %r14d
	je	.L494
	.p2align 4,,10
.L495:
	movq	232(%rsp), %rsi
	movq	152(%rsp), %rbx
	movupd	(%rsi,%rax), %xmm5
	movupd	(%rbx,%rax), %xmm4
	addq	$16, %rax
	movapd	%xmm5, %xmm0
	movapd	%xmm4, %xmm1
	movaps	%xmm5, 320(%rsp)
	mulpd	%xmm4, %xmm1
	movaps	%xmm4, 368(%rsp)
	mulpd	%xmm5, %xmm0
	divpd	%xmm1, %xmm0
	movapd	%xmm0, %xmm1
	unpckhpd	%xmm0, %xmm0
	addsd	%xmm6, %xmm1
	movapd	%xmm0, %xmm6
	addsd	%xmm1, %xmm6
	cmpq	176(%rsp), %rax
	jne	.L495
	movslq	192(%rsp), %rax
	cmpl	%eax, 184(%rsp)
	je	.L496
.L494:
	movq	112(%rsp), %rbx
	movsd	0(%r13,%rax,8), %xmm1
	movsd	(%rbx,%rax,8), %xmm0
	mulsd	%xmm1, %xmm1
	mulsd	%xmm0, %xmm0
	divsd	%xmm1, %xmm0
	addsd	%xmm0, %xmm6
.L496:
	movq	232(%rsp), %r8
	movq	%r15, %r11
	xorl	%edx, %edx
	xorl	%r10d, %r10d
	movq	112(%rsp), %rdi
	movq	600(%rsp), %r12
	pxor	%xmm7, %xmm7
	movl	$1, %esi
	movl	1184(%rsp), %ebp
	.p2align 4,,10
.L799:
	movl	%r14d, %eax
	movl	%esi, %r9d
	subl	%edx, %eax
	cmpl	%edx, %r14d
	cmovg	%eax, %r9d
	jle	.L847
	cmpl	$1, %eax
	je	.L847
	movl	%r9d, %ecx
	leaq	(%r8,%r12), %rbx
	pxor	%xmm0, %xmm0
	xorl	%eax, %eax
	shrl	%ecx
	salq	$4, %rcx
	.p2align 4,,10
.L497:
	movupd	(%r11,%rax), %xmm1
	movupd	(%r8,%rax), %xmm4
	movupd	(%rbx,%rax), %xmm3
	addq	$16, %rax
	mulpd	%xmm4, %xmm1
	mulpd	%xmm3, %xmm3
	divpd	%xmm3, %xmm1
	addsd	%xmm1, %xmm0
	unpckhpd	%xmm1, %xmm1
	addsd	%xmm1, %xmm0
	cmpq	%rcx, %rax
	jne	.L497
	movl	%r9d, %ecx
	andl	$-2, %ecx
	leal	(%rcx,%rdx), %eax
	cmpl	%ecx, %r9d
	je	.L498
.L500:
	movslq	%eax, %rcx
	addl	%r10d, %eax
	movsd	0(%r13,%rcx,8), %xmm2
	cltq
	movsd	(%r15,%rax,8), %xmm1
	mulsd	(%rdi,%rcx,8), %xmm1
	mulsd	%xmm2, %xmm2
	divsd	%xmm2, %xmm1
	addsd	%xmm1, %xmm0
.L498:
	mulsd	%xmm0, %xmm0
	addl	$1, %edx
	addl	%ebp, %r10d
	addq	$8, %r8
	addq	504(%rsp), %r11
	addsd	%xmm0, %xmm7
	cmpl	%edx, %r14d
	jne	.L799
	ucomisd	%xmm6, %xmm11
	sqrtsd	%xmm6, %xmm8
	ja	.L1368
.L502:
	mulsd	%xmm8, %xmm6
	divsd	%xmm7, %xmm6
	comisd	1328(%rsp), %xmm6
	movapd	%xmm6, %xmm10
	jbe	.L1281
	movsd	1328(%rsp), %xmm10
	pxor	%xmm14, %xmm14
	jmp	.L492
	.p2align 4,,10
.L1281:
	pxor	%xmm14, %xmm14
	jmp	.L492
	.p2align 4,,10
.L1357:
	movsd	1328(%rsp), %xmm0
	movq	208(%rsp), %r9
	movq	%rbx, %r8
	movq	224(%rsp), %rdx
	movq	304(%rsp), %rcx
	divsd	%xmm5, %xmm0
	movsd	%xmm0, 936(%rsp)
	call	dscal_
	movsd	1328(%rsp), %xmm4
	movsd	%xmm4, 440(%rsp)
	jmp	.L338
	.p2align 4,,10
.L220:
	movq	1272(%rsp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	leal	3(%rax), %edx
	cmovns	%eax, %edx
	movl	%edx, %eax
	shrl	$31, %edx
	sarl	$2, %eax
	addl	%edx, %eax
	andl	$1, %eax
	subl	%edx, %eax
	cmpl	$1, %eax
	jne	.L222
	movq	1232(%rsp), %rax
	movq	%r15, %r9
	movl	%r13d, %edx
	movl	1184(%rsp), %ecx
	movq	1200(%rsp), %r8
	movq	%rax, 32(%rsp)
	call	*1224(%rsp)
	movq	248(%rsp), %rbx
	movq	1272(%rsp), %rax
	addq	$1, %rbx
	movl	(%rax), %eax
	movq	%rbx, 432(%rsp)
.L1307:
	movl	1184(%rsp), %esi
	leaq	8(%r15), %rbx
	movq	%rbx, 312(%rsp)
	leal	1(%rsi), %ebx
	movq	136(%rsp), %rsi
	movl	%ebx, 612(%rsp)
	leaq	(%r15,%rsi), %rbx
	movq	%rbx, 704(%rsp)
	jmp	.L219
	.p2align 4,,10
.L1329:
	movq	248(%rsp), %rax
	movsd	(%r14), %xmm0
	addq	$1, %rax
	cmpl	$3, 1256(%rsp)
	movq	%rax, 432(%rsp)
	leaq	0(,%rax,8), %r10
	je	.L1369
	movsd	%xmm0, (%r15)
.L212:
	leaq	8(%r15), %rax
	movq	%rax, 312(%rsp)
	cmpl	$1, %r13d
	je	.L1370
	movq	%rax, %r9
	movl	1184(%rsp), %eax
	movl	1256(%rsp), %ebx
	leaq	-8(%r10), %r11
	addl	$1, %eax
	movl	%eax, 612(%rsp)
	cltq
	leaq	(%r15,%rax,8), %r8
	movl	$1, %eax
	.p2align 4,,10
.L216:
	movsd	(%r14,%rax,8), %xmm0
	cmpl	$3, %ebx
	je	.L1371
	movsd	%xmm0, (%r8)
.L214:
	movq	%r9, %rcx
	xorl	%edx, %edx
	.p2align 4,,10
.L215:
	addl	$1, %edx
	movq	$0x000000000, (%rcx)
	addq	%r11, %rcx
	cmpl	%eax, %edx
	jl	.L215
	addq	$1, %rax
	addq	$8, %r9
	addq	%r10, %r8
	cmpl	%eax, %r13d
	jg	.L216
.L217:
	movq	136(%rsp), %rsi
	movq	1272(%rsp), %rax
	addq	%r15, %rsi
	movl	(%rax), %eax
	movq	%rsi, 704(%rsp)
	jmp	.L219
	.p2align 4,,10
.L1371:
	mulsd	%xmm0, %xmm0
	movsd	%xmm0, (%r8)
	jmp	.L214
	.p2align 4,,10
.L1369:
	mulsd	%xmm0, %xmm0
	movsd	%xmm0, (%r15)
	jmp	.L212
	.p2align 4,,10
.L1370:
	movl	1184(%rsp), %eax
	addl	$1, %eax
	movl	%eax, 612(%rsp)
	jmp	.L217
	.p2align 4,,10
.L1260:
	movsd	920(%rsp), %xmm0
	movl	%esi, %edx
	leaq	.LC13(%rip), %rcx
	movslq	%r13d, %rsi
	movsd	%xmm0, 936(%rsp)
	call	Rprintf
	leaq	.LC18(%rip), %rcx
	call	Rprintf
	movq	264(%rsp), %rcx
	movq	%rsi, %rdx
	movl	$1, %r8d
	movq	%rsi, 736(%rsp)
	call	Rf_printRealVector
	leaq	.LC14(%rip), %rcx
	call	Rprintf
	movq	1200(%rsp), %rcx
	movl	$1, %r8d
	movq	%rsi, %rdx
	call	Rf_printRealVector
	leaq	.LC15(%rip), %rcx
	call	Rprintf
	movl	$1, %r8d
	movl	$1, %edx
	leaq	936(%rsp), %rax
	movq	%rax, %rcx
	movq	%rax, 224(%rsp)
	call	Rf_printRealVector
	leaq	.LC16(%rip), %rcx
	call	Rprintf
	movq	112(%rsp), %rcx
	movl	$1, %r8d
	movq	%rsi, %rdx
	call	Rf_printRealVector
	leaq	.LC17(%rip), %rcx
	call	Rprintf
	movq	1392(%rsp), %rax
	movl	(%rax), %eax
	movl	%eax, 320(%rsp)
	jmp	.L239
	.p2align 4,,10
.L1327:
	leaq	936(%rsp), %rax
	movq	%r14, 48(%rsp)
	movl	%r13d, %ecx
	xorl	%ebx, %ebx
	movq	128(%rsp), %rsi
	movq	%rax, 64(%rsp)
	leaq	928(%rsp), %rax
	movsd	360(%rsp), %xmm3
	movq	%rax, 32(%rsp)
	movq	%rsi, 40(%rsp)
	movq	1232(%rsp), %r9
	movsd	920(%rsp), %xmm0
	movq	1208(%rsp), %r8
	movsd	%xmm3, 56(%rsp)
	movq	1200(%rsp), %rdx
	movsd	%xmm0, 928(%rsp)
	call	fstofd.constprop.5
	movl	%r13d, 1192(%rsp)
	movq	%rbx, %r13
	movq	.LC2(%rip), %xmm6
	movq	112(%rsp), %rdi
	movq	272(%rsp), %rbp
	movq	1200(%rsp), %rbx
	movsd	1248(%rsp), %xmm9
	jmp	.L202
	.p2align 4,,10
.L1255:
	leaq	1(%r13), %rdx
	cmpq	%rbp, %r13
	je	.L1372
	movq	%rdx, %r13
.L202:
	movsd	928(%rsp), %xmm0
	movapd	%xmm9, %xmm1
	andpd	%xmm6, %xmm0
	call	Rf_fmax2
	movsd	(%r12,%r13,8), %xmm1
	movapd	%xmm0, %xmm10
	movsd	(%rbx,%r13,8), %xmm0
	andpd	%xmm6, %xmm0
	call	Rf_fmax2
	movsd	(%rdi,%r13,8), %xmm1
	movapd	%xmm1, %xmm8
	movapd	%xmm1, %xmm2
	movapd	%xmm10, %xmm1
	divsd	%xmm0, %xmm1
	andpd	%xmm6, %xmm2
	subsd	(%rsi,%r13,8), %xmm8
	movapd	%xmm2, %xmm0
	andpd	%xmm6, %xmm8
	call	Rf_fmax2
	mulsd	%xmm7, %xmm0
	comisd	%xmm0, %xmm8
	jbe	.L1255
	movq	1272(%rsp), %rax
	movl	$-21, (%rax)
	jmp	.L167
	.p2align 4,,10
.L1328:
	movq	1392(%rsp), %rax
	movq	%rdx, %r8
	movsd	920(%rsp), %xmm0
	addq	%r14, %r8
	movq	1384(%rsp), %rsi
	movq	248(%rsp), %rbx
	movl	(%rax), %edx
	movq	1352(%rsp), %rax
	movsd	%xmm0, (%rax)
	movq	1344(%rsp), %rax
	leaq	16(%rax), %r9
	movq	1360(%rsp), %rax
	leaq	16(%rax), %r10
	movq	1200(%rsp), %rax
	cmpq	%r10, %rax
	leaq	16(%rax), %r11
	setnb	%cl
	cmpq	%r11, 1360(%rsp)
	setnb	%al
	orl	%eax, %ecx
	cmpq	%r9, 1200(%rsp)
	setnb	%al
	cmpq	%r11, 1344(%rsp)
	setnb	%r11b
	orl	%r11d, %eax
	andl	%ecx, %eax
	cmpq	%r10, 1344(%rsp)
	setnb	%cl
	cmpq	%r9, 1360(%rsp)
	setnb	%r11b
	orl	%r11d, %ecx
	leaq	16(%rsi,%rbx,8), %r11
	andl	%ecx, %eax
	cmpl	$2, 356(%rsp)
	seta	%cl
	andl	%ecx, %eax
	cmpq	%r11, 1344(%rsp)
	setnb	%cl
	cmpq	%r8, %r9
	setbe	%r9b
	orl	%r9d, %ecx
	testb	%cl, %al
	je	.L812
	cmpq	%r11, 1360(%rsp)
	setnb	%cl
	cmpq	%r8, %r10
	setbe	%al
	orb	%al, %cl
	je	.L812
	movl	%r13d, %ecx
	movq	1200(%rsp), %r9
	xorl	%eax, %eax
	movq	1344(%rsp), %r10
	shrl	%ecx
	movq	1360(%rsp), %r11
	salq	$4, %rcx
	.p2align 4,,10
.L206:
	movupd	(%r9,%rax), %xmm5
	movups	%xmm5, (%r10,%rax)
	movupd	(%r8,%rax), %xmm4
	movups	%xmm4, (%r11,%rax)
	addq	$16, %rax
	cmpq	%rax, %rcx
	jne	.L206
	movl	%r13d, %eax
	andl	$-2, %eax
	cmpl	%r13d, %eax
	je	.L208
	movq	1200(%rsp), %rbx
	movsd	(%rbx,%rax,8), %xmm0
	movq	1344(%rsp), %rbx
	movsd	%xmm0, (%rbx,%rax,8)
	movq	112(%rsp), %rbx
	movsd	(%rbx,%rax,8), %xmm0
	movq	1360(%rsp), %rbx
	movsd	%xmm0, (%rbx,%rax,8)
.L208:
	movq	1272(%rsp), %rax
	movl	(%rax), %ecx
	leal	7(%rcx), %eax
	testl	%ecx, %ecx
	cmovns	%ecx, %eax
	testb	$8, %al
	jne	.L766
	movq	1352(%rsp), %rax
	leaq	.LC13(%rip), %rcx
	movsd	(%rax), %xmm0
	movsd	%xmm0, 936(%rsp)
	call	Rprintf
	leaq	.LC14(%rip), %rcx
	call	Rprintf
	movq	1344(%rsp), %rcx
	movl	$1, %r8d
	movq	%r13, %rdx
	call	Rf_printRealVector
	leaq	.LC15(%rip), %rcx
	call	Rprintf
	movl	$1, %r8d
	movl	$1, %edx
	leaq	936(%rsp), %rcx
	call	Rf_printRealVector
	leaq	.LC16(%rip), %rcx
	call	Rprintf
	movq	1360(%rsp), %rcx
	movl	$1, %r8d
	movq	%r13, %rdx
	call	Rf_printRealVector
	leaq	.LC17(%rip), %rcx
	call	Rprintf
.L766:
	movq	1272(%rsp), %rax
	movl	$0, (%rax)
	jmp	.L167
	.p2align 4,,10
.L1330:
	movsd	(%r15), %xmm0
	movq	1384(%rsp), %rax
	movsd	%xmm0, (%rax)
	jmp	.L796
	.p2align 4,,10
.L257:
	subsd	%xmm8, %xmm0
	mulsd	%xmm7, %xmm0
	subsd	%xmm8, %xmm0
	ucomisd	%xmm11, %xmm0
	jp	.L785
	movq	%xmm0, %rax
	cmove	.LC0(%rip), %rax
	movq	%rax, 320(%rsp)
	movsd	320(%rsp), %xmm0
	jmp	.L785
	.p2align 4,,10
.L436:
	subl	$1, %ecx
	xorl	%eax, %eax
	movq	160(%rsp), %r8
	movq	128(%rsp), %r9
	jmp	.L440
	.p2align 4,,10
.L837:
	movq	%rdx, %rax
.L440:
	movsd	(%r8,%rax,8), %xmm1
	leaq	1(%rax), %rdx
	mulsd	%xmm0, %xmm1
	addsd	(%r9,%rax,8), %xmm1
	divsd	0(%r13,%rax,8), %xmm1
	movsd	%xmm1, (%rdi,%rax,8)
	cmpq	%rcx, %rax
	jne	.L837
	jmp	.L423
	.p2align 4,,10
.L1323:
	movq	1272(%rsp), %rax
	movl	$-4, (%rax)
	jmp	.L167
	.p2align 4,,10
.L221:
	movq	%rax, 80(%rsp)
	movq	128(%rsp), %rax
	movl	%r13d, %edx
	movsd	360(%rsp), %xmm4
	movq	%r14, 56(%rsp)
	movq	%rax, 72(%rsp)
	movq	1232(%rsp), %rax
	movsd	920(%rsp), %xmm0
	movq	%r15, 48(%rsp)
	movq	%rax, 32(%rsp)
	movq	1208(%rsp), %r9
	movq	1200(%rsp), %r8
	movl	1184(%rsp), %ecx
	movsd	%xmm4, 64(%rsp)
	movsd	%xmm0, 40(%rsp)
	call	sndofd
	movq	248(%rsp), %rbx
	movq	1272(%rsp), %rax
	leaq	1(%rbx), %rsi
	movl	(%rax), %eax
	movq	%rsi, 432(%rsp)
	jmp	.L1307
	.p2align 4,,10
.L222:
	cmpl	$1, 1296(%rsp)
	je	.L1373
	movq	160(%rsp), %rax
	movq	%r14, 56(%rsp)
	movl	%r13d, %edx
	movsd	360(%rsp), %xmm4
	movq	%r15, 48(%rsp)
	movq	%rax, 80(%rsp)
	movq	128(%rsp), %rax
	movsd	920(%rsp), %xmm0
	movq	1208(%rsp), %r9
	movsd	%xmm4, 64(%rsp)
	movq	%rax, 72(%rsp)
	movq	1232(%rsp), %rax
	movq	1200(%rsp), %r8
	movl	1184(%rsp), %ecx
	movsd	%xmm0, 40(%rsp)
	movq	%rax, 32(%rsp)
	call	sndofd
.L224:
	movsd	(%r15), %xmm0
	movq	1384(%rsp), %rax
	movsd	%xmm0, (%rax)
	cmpl	$1, %r13d
	je	.L226
	movq	136(%rsp), %rax
	movq	%r15, %rbp
	xorl	%edx, %edx
	xorl	%edi, %edi
	movq	%r12, 1240(%rsp)
	movl	356(%rsp), %r9d
	movl	$1, %ecx
	leaq	8(%rax), %rsi
	movl	1184(%rsp), %r12d
	movq	%r14, 192(%rsp)
	movq	%rax, %rbx
	movq	%rsi, 184(%rsp)
	movq	%rax, %r14
	movl	$8, %esi
	.p2align 4,,10
.L232:
	movl	%r9d, %r10d
	cmpl	%ecx, %r13d
	leal	-1(%rcx), %eax
	movq	%rdi, %r11
	leaq	-1(%r10), %r8
	leaq	-8(,%r10,8), %r10
	movl	%eax, 152(%rsp)
	movl	%ecx, %eax
	cmovle	%rdi, %r8
	imulq	%r14, %r8
	cmpl	%ecx, %r13d
	cmovle	%rdi, %r10
	addq	%rsi, %r10
	testl	%r12d, %r12d
	cmovs	%r8, %r11
	addq	%rbx, %r11
	cmpq	%r11, %r10
	setl	%r10b
	testl	%r12d, %r12d
	cmovs	%rdi, %r8
	addq	%rbx, %r8
	cmpq	%rsi, %r8
	setl	%r8b
	orb	%r8b, %r10b
	je	.L1374
	leal	-1(%r9), %r11d
	cmpl	$22, %r11d
	movl	%r11d, 168(%rsp)
	seta	%r10b
	cmpl	%ecx, %r13d
	setg	%r8b
	testb	%r8b, %r10b
	je	.L227
	cmpl	%ecx, %r13d
	movl	$1, %r11d
	leaq	(%r15,%rsi), %r8
	cmovle	%r11d, %r9d
	leal	(%rdx,%r12), %r11d
	movslq	%r11d, %r10
	movl	%r11d, 176(%rsp)
	leaq	-1(%rcx,%r10), %r10
	leaq	(%r15,%r10,8), %r11
	movl	%r9d, %r10d
	shrl	%r10d
	salq	$4, %r10
	addq	%r8, %r10
	.p2align 4,,10
.L228:
	movupd	(%r8), %xmm0
	addq	$16, %r8
	movlpd	%xmm0, (%r11)
	movhpd	%xmm0, (%r11,%r14)
	addq	144(%rsp), %r11
	cmpq	%r10, %r8
	jne	.L228
	movl	%r9d, %r8d
	andl	$-2, %r8d
	addl	%r8d, %eax
	cmpl	%r8d, %r9d
	je	.L229
	addl	%eax, %edx
	imull	%r12d, %eax
	addl	152(%rsp), %eax
	movslq	%edx, %rdx
	cltq
	movsd	(%r15,%rdx,8), %xmm0
	movsd	%xmm0, (%r15,%rax,8)
.L229:
	movsd	8(%r15,%rbx), %xmm0
	movq	1384(%rsp), %rax
	addq	%r14, %rbp
	movl	176(%rsp), %edx
	movl	168(%rsp), %r9d
	movsd	%xmm0, (%rax,%rcx,8)
	movq	184(%rsp), %rax
	addq	$1, %rcx
	addq	%rax, %rbx
	addq	%rax, %rsi
	jmp	.L232
	.p2align 4,,10
.L1372:
	movq	1272(%rsp), %rax
	movslq	1192(%rsp), %r13
	movl	(%rax), %eax
	testl	%eax, %eax
	jns	.L198
	jmp	.L167
	.p2align 4,,10
.L847:
	movl	%edx, %eax
	pxor	%xmm0, %xmm0
	jmp	.L500
	.p2align 4,,10
.L810:
	movsd	.LC9(%rip), %xmm12
	jmp	.L194
	.p2align 4,,10
.L620:
	cmpl	$1, 1304(%rsp)
	je	.L756
	movl	352(%rsp), %r9d
	testl	%r9d, %r9d
	je	.L757
	movq	128(%rsp), %rax
	movq	%r13, 64(%rsp)
	movl	%r14d, %r8d
	movl	%r14d, %edx
	movsd	360(%rsp), %xmm4
	movl	$3, 88(%rsp)
	movq	%rax, 80(%rsp)
	movq	1360(%rsp), %rax
	movq	%r15, 56(%rsp)
	movq	1344(%rsp), %r9
	movq	%rax, 48(%rsp)
	movq	1232(%rsp), %rax
	movl	1184(%rsp), %ecx
	movsd	%xmm4, 72(%rsp)
	movq	%rax, 40(%rsp)
	movq	1216(%rsp), %rax
	movq	%rax, 32(%rsp)
	call	fstofd
	.p2align 4,,10
.L663:
	movq	1392(%rsp), %rax
	movl	(%rax), %edx
	movq	1352(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	1272(%rsp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	leal	15(%rax), %ecx
	cmovns	%eax, %ecx
	movl	%ecx, %eax
	shrl	$31, %ecx
	sarl	$4, %eax
	addl	%ecx, %eax
	andl	$1, %eax
	subl	%ecx, %eax
	cmpl	$1, %eax
	je	.L1375
.L758:
	movsd	%xmm0, 920(%rsp)
	xorl	%eax, %eax
	cmpb	$0, 859(%rsp)
	je	.L759
	movq	632(%rsp), %rcx
	movq	176(%rsp), %r8
	movq	1200(%rsp), %r9
	movq	1344(%rsp), %r10
	movq	1360(%rsp), %r11
	.p2align 4,,10
.L760:
	movupd	(%r10,%rax), %xmm4
	movups	%xmm4, (%r9,%rax)
	movupd	(%r11,%rax), %xmm5
	movups	%xmm5, (%rcx,%rax)
	addq	$16, %rax
	cmpq	%r8, %rax
	jne	.L760
	movl	192(%rsp), %esi
	cmpl	%esi, 184(%rsp)
	je	.L762
	movq	400(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	392(%rsp), %rax
	movsd	%xmm0, (%rax)
	movq	696(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	488(%rsp), %rax
	movsd	%xmm0, (%rax)
.L762:
	movapd	%xmm6, %xmm10
	jmp	.L763
	.p2align 4,,10
.L825:
	movsd	.LC0(%rip), %xmm8
	pxor	%xmm9, %xmm9
	jmp	.L340
	.p2align 4,,10
.L608:
	movq	112(%rsp), %rax
	movq	%r12, 32(%rsp)
	movl	%r14d, %ecx
	movq	1232(%rsp), %r9
	movq	1208(%rsp), %r8
	movsd	360(%rsp), %xmm3
	movq	%rax, 48(%rsp)
	movq	1200(%rsp), %rdx
	movsd	%xmm3, 40(%rsp)
	call	fstocd
	movsd	752(%rsp), %xmm5
	movsd	760(%rsp), %xmm14
	movsd	%xmm5, 240(%rsp)
.L1314:
	movsd	768(%rsp), %xmm3
	movsd	744(%rsp), %xmm12
	movl	$-1, 352(%rsp)
	movsd	456(%rsp), %xmm10
	movsd	%xmm3, 336(%rsp)
	jmp	.L241
	.p2align 4,,10
.L616:
	leaq	928(%rsp), %rax
	movq	%r13, 48(%rsp)
	movsd	360(%rsp), %xmm5
	movl	%r14d, %ecx
	movq	%rax, 64(%rsp)
	movq	1360(%rsp), %rax
	movq	1232(%rsp), %r9
	movq	1208(%rsp), %r8
	movsd	%xmm5, 56(%rsp)
	movq	%rax, 40(%rsp)
	movq	1352(%rsp), %rax
	movq	1344(%rsp), %rdx
	movq	%rax, 32(%rsp)
	call	fstofd.constprop.5
	jmp	.L618
	.p2align 4,,10
.L615:
	movq	1360(%rsp), %rax
	movq	%r13, 32(%rsp)
	movl	%r14d, %ecx
	movq	1232(%rsp), %r9
	movq	1208(%rsp), %r8
	movsd	360(%rsp), %xmm5
	movq	%rax, 48(%rsp)
	movq	1344(%rsp), %rdx
	movsd	%xmm5, 40(%rsp)
	call	fstocd
	jmp	.L618
	.p2align 4,,10
.L1331:
	jne	.L787
	movapd	%xmm6, %xmm8
	movsd	.LC0(%rip), %xmm0
	jmp	.L785
	.p2align 4,,10
.L664:
	movq	1344(%rsp), %rbx
	movq	1200(%rsp), %rsi
	movsd	(%rbx,%rax,8), %xmm0
	subsd	(%rsi,%rax,8), %xmm0
	movq	496(%rsp), %rbx
	movq	1360(%rsp), %rsi
	movsd	%xmm0, (%rbx,%rax,8)
	movq	112(%rsp), %rbx
	movsd	(%rsi,%rax,8), %xmm0
	movq	128(%rsp), %rsi
	subsd	(%rbx,%rax,8), %xmm0
	movsd	%xmm0, (%rsi,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r14d
	jg	.L664
	jmp	.L667
	.p2align 4,,10
.L1373:
	movq	128(%rsp), %rax
	movq	%r14, 64(%rsp)
	movl	%r13d, %r8d
	movl	%r13d, %edx
	movsd	360(%rsp), %xmm3
	movl	$3, 88(%rsp)
	movq	%rax, 80(%rsp)
	movq	112(%rsp), %rax
	movq	%r15, 56(%rsp)
	movq	1200(%rsp), %r9
	movq	%rax, 48(%rsp)
	movq	1232(%rsp), %rax
	movl	1184(%rsp), %ecx
	movsd	%xmm3, 72(%rsp)
	movq	%rax, 40(%rsp)
	movq	1216(%rsp), %rax
	movq	%rax, 32(%rsp)
	call	fstofd
	jmp	.L224
	.p2align 4,,10
.L759:
	movq	1344(%rsp), %rbx
	movsd	(%rbx,%rax,8), %xmm0
	movq	1200(%rsp), %rbx
	movsd	%xmm0, (%rbx,%rax,8)
	movq	1360(%rsp), %rbx
	movsd	(%rbx,%rax,8), %xmm0
	movq	112(%rsp), %rbx
	movsd	%xmm0, (%rbx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r14d
	jg	.L759
	jmp	.L762
	.p2align 4,,10
.L756:
	movq	1232(%rsp), %rax
	movq	%r15, %r9
	movl	%r14d, %edx
	movl	1184(%rsp), %ecx
	movq	1344(%rsp), %r8
	movq	%rax, 32(%rsp)
	call	*1224(%rsp)
	jmp	.L663
	.p2align 4,,10
.L1344:
	movq	1384(%rsp), %rax
	movl	%r14d, 916(%rsp)
	movl	$1, 936(%rsp)
	movsd	(%rax), %xmm0
	movsd	%xmm0, (%r15)
	cmpl	$1, %r14d
	jle	.L622
	leal	-2(%r14), %eax
	movq	136(%rsp), %rsi
	xorl	%ebx, %ebx
	xorl	%ebp, %ebp
	addq	$2, %rax
	movl	1184(%rsp), %r9d
	movq	704(%rsp), %r10
	movl	$1, %r8d
	movq	%rax, 416(%rsp)
	.p2align 4,,10
.L626:
	movl	1184(%rsp), %edx
	movq	%r10, %rcx
	movl	%r8d, %edi
	movl	%r8d, %r11d
	subq	%r15, %rcx
	movq	1384(%rsp), %rax
	testl	%edx, %edx
	movq	%rbp, %rdx
	cmovs	%rbx, %rdx
	movsd	(%rax,%r8,8), %xmm0
	leaq	0(,%r8,8), %rax
	addq	%rax, %rdx
	movsd	%xmm0, 8(%r10)
	cmpq	%rdx, %rcx
	movl	1184(%rsp), %edx
	setl	%cl
	testl	%edx, %edx
	movq	%rbp, %rdx
	cmovns	%rbx, %rdx
	addq	%rax, %rdx
	cmpq	%rdx, %rsi
	setg	%dl
	orb	%dl, %cl
	je	.L623
	leal	-1(%r8), %edx
	cmpl	$22, %edx
	jbe	.L623
	movl	%r8d, %ecx
	leaq	(%r15,%rsi), %rdx
	addq	%r15, %rax
	movq	%r13, 320(%rsp)
	shrl	%ecx
	movq	%r8, 368(%rsp)
	movq	136(%rsp), %r13
	salq	$4, %rcx
	movq	296(%rsp), %r8
	addq	%rdx, %rcx
	.p2align 4,,10
.L624:
	movupd	(%rdx), %xmm0
	addq	$16, %rdx
	movlpd	%xmm0, (%rax)
	movhpd	%xmm0, (%rax,%r13)
	addq	%r8, %rax
	cmpq	%rdx, %rcx
	jne	.L624
	movl	%edi, %eax
	movq	320(%rsp), %r13
	movq	368(%rsp), %r8
	andl	$-2, %eax
	cmpl	%edi, %eax
	je	.L630
	leal	(%r9,%rax), %edx
	imull	1184(%rsp), %eax
	movslq	%edx, %rdx
	movsd	(%r15,%rdx,8), %xmm0
	addl	%r11d, %eax
	cltq
	movsd	%xmm0, (%r15,%rax,8)
.L630:
	movq	136(%rsp), %rax
	addq	$1, %r8
	addq	200(%rsp), %r10
	addl	1184(%rsp), %r9d
	addq	%rax, %rbx
	addq	%rax, %rsi
	cmpq	416(%rsp), %r8
	jne	.L626
	cmpb	$0, 861(%rsp)
	je	.L866
.L793:
	xorl	%eax, %eax
	.p2align 4,,10
.L632:
	movq	1344(%rsp), %rsi
	movq	216(%rsp), %rbx
	movupd	(%rsi,%rax), %xmm3
	movq	1200(%rsp), %rsi
	movupd	(%rsi,%rax), %xmm5
	movapd	%xmm3, %xmm0
	movq	1360(%rsp), %rsi
	subpd	%xmm5, %xmm0
	movups	%xmm0, (%rbx,%rax)
	movq	632(%rsp), %rbx
	movupd	(%rsi,%rax), %xmm3
	movq	256(%rsp), %rsi
	movupd	(%rbx,%rax), %xmm5
	movapd	%xmm3, %xmm0
	movaps	%xmm3, 320(%rsp)
	subpd	%xmm5, %xmm0
	movaps	%xmm5, 368(%rsp)
	movups	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpq	176(%rsp), %rax
	jne	.L632
	movl	192(%rsp), %esi
	cmpl	%esi, 184(%rsp)
	je	.L634
	movq	400(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	392(%rsp), %rax
	subsd	(%rax), %xmm0
	movq	576(%rsp), %rax
	movsd	%xmm0, (%rax)
	movq	696(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	488(%rsp), %rax
	subsd	(%rax), %xmm0
	movq	592(%rsp), %rax
	movsd	%xmm0, (%rax)
.L634:
	movq	224(%rsp), %rsi
	movq	208(%rsp), %rbx
	movq	160(%rsp), %rbp
	movq	128(%rsp), %rdi
	movq	%rsi, 32(%rsp)
	movq	%rsi, %r8
	movq	%rbx, %rcx
	movq	%rbp, %r9
	movq	%rdi, %rdx
	call	ddot_
	movq	%rsi, %r8
	movq	%rdi, %rdx
	movq	%rbx, %rcx
	movapd	%xmm0, %xmm9
	call	dnrm2_
	movq	%rsi, %r8
	movq	%rbp, %rdx
	movq	%rbx, %rcx
	movapd	%xmm0, %xmm8
	call	dnrm2_
	movsd	.LC19(%rip), %xmm7
	mulsd	%xmm8, %xmm7
	mulsd	%xmm0, %xmm7
	comisd	%xmm9, %xmm7
	ja	.L663
	movl	916(%rsp), %esi
	testl	%esi, %esi
	jle	.L636
	movq	216(%rsp), %rax
	xorl	%ebx, %ebx
	xorl	%r8d, %r8d
	leal	1(%rsi), %ebp
	movq	312(%rsp), %r9
	leaq	8(%rax), %rdi
	.p2align 4,,10
.L774:
	leal	1(%r12), %edx
	testl	%r12d, %r12d
	je	.L867
	movl	%edx, %r10d
	movq	216(%rsp), %rax
	leaq	(%r15,%rbx), %rcx
	pxor	%xmm1, %xmm1
	shrl	%r10d
	salq	$4, %r10
	addq	%rax, %r10
	.p2align 4,,10
.L638:
	movsd	(%rcx), %xmm0
	movq	136(%rsp), %r11
	addq	$16, %rax
	movupd	-16(%rax), %xmm4
	movhpd	(%rcx,%r11), %xmm0
	addq	296(%rsp), %rcx
	mulpd	%xmm4, %xmm0
	addsd	%xmm0, %xmm1
	unpckhpd	%xmm0, %xmm0
	addsd	%xmm0, %xmm1
	cmpq	%r10, %rax
	jne	.L638
	movl	%edx, %ecx
	andl	$-2, %ecx
	cmpl	%edx, %ecx
	je	.L639
.L637:
	movl	1184(%rsp), %eax
	imull	%ecx, %eax
	movslq	%ecx, %rcx
	addl	%r12d, %eax
	cltq
	movsd	(%r15,%rax,8), %xmm0
	movq	128(%rsp), %rax
	mulsd	(%rax,%rcx,8), %xmm0
	addsd	%xmm0, %xmm1
.L639:
	movl	%edx, %r12d
	cmpl	%edx, %esi
	je	.L640
	movl	%ebp, %eax
	movl	%esi, %r11d
	subl	%edx, %eax
	subl	%edx, %r11d
	cmpl	$2, %eax
	je	.L641
	movl	%r11d, %ecx
	leaq	(%rdi,%rbx), %r10
	xorl	%eax, %eax
	shrl	%ecx
	salq	$4, %rcx
	.p2align 4,,10
.L642:
	movupd	(%r10,%rax), %xmm2
	movupd	(%r9,%rax), %xmm4
	addq	$16, %rax
	mulpd	%xmm4, %xmm2
	addsd	%xmm2, %xmm1
	unpckhpd	%xmm2, %xmm2
	addsd	%xmm2, %xmm1
	cmpq	%rcx, %rax
	jne	.L642
	movl	%r11d, %eax
	andl	$-2, %eax
	addl	%eax, %edx
	cmpl	%r11d, %eax
	je	.L643
.L641:
	leal	(%r8,%rdx), %eax
	movslq	%edx, %rdx
	cltq
	movsd	(%r15,%rax,8), %xmm0
	movq	128(%rsp), %rax
	mulsd	(%rax,%rdx,8), %xmm0
	addsd	%xmm0, %xmm1
.L643:
	movq	344(%rsp), %rax
	addl	1184(%rsp), %r8d
	addq	200(%rsp), %r9
	movsd	%xmm1, (%rax,%rbx)
	addq	$8, %rbx
	jmp	.L774
	.p2align 4,,10
.L808:
	pxor	%xmm0, %xmm0
	xorl	%eax, %eax
	jmp	.L182
.L866:
	xorl	%eax, %eax
	.p2align 4,,10
.L631:
	movq	1344(%rsp), %rsi
	movq	112(%rsp), %rbx
	movsd	(%rsi,%rax,8), %xmm0
	movq	1200(%rsp), %rsi
	subsd	(%rsi,%rax,8), %xmm0
	movq	128(%rsp), %rsi
	movsd	%xmm0, (%rsi,%rax,8)
	movq	1360(%rsp), %rsi
	movsd	(%rsi,%rax,8), %xmm0
	subsd	(%rbx,%rax,8), %xmm0
	movq	160(%rsp), %rsi
	movsd	%xmm0, (%rsi,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r14d
	jg	.L631
	jmp	.L634
	.p2align 4,,10
.L1374:
	leal	-1(%r9), %eax
	movl	%eax, 168(%rsp)
.L227:
	leal	(%rdx,%r12), %eax
	movl	%eax, 176(%rsp)
	cltq
	leaq	-1(%rcx,%rax), %rax
	leaq	(%r15,%rax,8), %rdx
	movq	%rcx, %rax
	.p2align 4,,10
.L230:
	movsd	0(%rbp,%rax,8), %xmm0
	addq	$1, %rax
	movsd	%xmm0, (%rdx)
	addq	%r14, %rdx
	cmpl	%eax, %r13d
	jg	.L230
	movsd	8(%r15,%rbx), %xmm0
	movq	1384(%rsp), %rax
	addq	%r14, %rbp
	movl	168(%rsp), %r9d
	movl	176(%rsp), %edx
	movsd	%xmm0, (%rax,%rcx,8)
	movq	184(%rsp), %rax
	addq	$1, %rcx
	addq	%rax, %rbx
	addq	%rax, %rsi
	testl	%r9d, %r9d
	jne	.L232
	movq	192(%rsp), %r14
	movq	1240(%rsp), %r12
.L226:
	movq	1232(%rsp), %rax
	movq	%r15, %r9
	movl	%r13d, %edx
	movl	1184(%rsp), %ecx
	movq	1200(%rsp), %r8
	movl	$1, %ebx
	movq	%rax, 32(%rsp)
	call	*1224(%rsp)
	movq	248(%rsp), %rax
	movq	$0, 144(%rsp)
	movsd	.LC0(%rip), %xmm9
	movq	.LC2(%rip), %xmm6
	addq	$1, %rax
	movq	%rax, 432(%rsp)
	movq	136(%rsp), %rax
	addq	%r15, %rax
	movq	%rax, 704(%rsp)
	leaq	8(%r15), %rax
	movq	%rax, 152(%rsp)
	leaq	16(%r15), %rax
	movq	%rax, 168(%rsp)
.L791:
	movq	112(%rsp), %rax
	movapd	%xmm9, %xmm1
	movsd	-8(%rax,%rbx,8), %xmm0
	andpd	%xmm6, %xmm0
	call	Rf_fmax2
	movq	1200(%rsp), %rax
	movsd	-8(%r12,%rbx,8), %xmm1
	movapd	%xmm0, %xmm8
	movsd	-8(%rax,%rbx,8), %xmm0
	andpd	%xmm6, %xmm0
	call	Rf_fmax2
	movq	1384(%rsp), %rax
	divsd	%xmm0, %xmm8
	movsd	-8(%rax,%rbx,8), %xmm0
	movq	144(%rsp), %rax
	movsd	(%r15,%rax,8), %xmm10
	subsd	%xmm0, %xmm10
	andpd	%xmm6, %xmm0
	andpd	%xmm6, %xmm10
	movapd	%xmm8, %xmm1
	call	Rf_fmax2
	mulsd	%xmm7, %xmm0
	comisd	%xmm0, %xmm10
	ja	.L236
	cmpl	%ebx, %r13d
	jle	.L235
	movq	144(%rsp), %rsi
	movq	152(%rsp), %rdi
	movq	%rbx, 176(%rsp)
	movq	704(%rsp), %rcx
	leaq	0(,%rsi,8), %rax
	leaq	(%rax,%rcx), %rbp
	addq	%rax, %rdi
	movl	356(%rsp), %eax
	subl	%ebx, %eax
	movq	%rbp, %rbx
	addq	%rsi, %rax
	movq	168(%rsp), %rsi
	leaq	(%rsi,%rax,8), %rsi
	movq	%rsi, %rbp
	movq	136(%rsp), %rsi
	jmp	.L237
	.p2align 4,,10
.L1377:
	addq	$8, %rdi
	addq	%rsi, %rbx
	cmpq	%rbp, %rdi
	je	.L1376
.L237:
	movsd	(%rdi), %xmm0
	movapd	%xmm8, %xmm1
	movapd	%xmm0, %xmm10
	andpd	%xmm6, %xmm0
	subsd	(%rbx), %xmm10
	call	Rf_fmax2
	mulsd	%xmm7, %xmm0
	andpd	%xmm6, %xmm10
	comisd	%xmm0, %xmm10
	jbe	.L1377
.L236:
	movq	1272(%rsp), %rax
	movl	$-22, (%rax)
	jmp	.L167
	.p2align 4,,10
.L1376:
	movq	176(%rsp), %rbx
	movq	432(%rsp), %rsi
	addq	%rsi, 144(%rsp)
	addq	$1, %rbx
	jmp	.L791
.L235:
	movq	1272(%rsp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	js	.L167
	movl	1184(%rsp), %ebx
	leaq	8(%r15), %rsi
	movq	%rsi, 312(%rsp)
	leal	1(%rbx), %esi
	movl	%esi, 612(%rsp)
	jmp	.L219
	.p2align 4,,10
.L623:
	leaq	(%r15,%rsi), %rdx
	addq	%r15, %rax
	jmp	.L629
	.p2align 4,,10
.L865:
	movq	%rcx, %rdx
.L629:
	movsd	(%rdx), %xmm0
	leaq	8(%rdx), %rcx
	movsd	%xmm0, (%rax)
	addq	136(%rsp), %rax
	cmpq	%r10, %rdx
	jne	.L865
	jmp	.L630
	.p2align 4,,10
.L1375:
	movsd	%xmm0, 936(%rsp)
	leaq	.LC13(%rip), %rcx
	call	Rprintf
	leaq	.LC18(%rip), %rcx
	call	Rprintf
	movq	736(%rsp), %rbx
	movq	264(%rsp), %rcx
	movl	$1, %r8d
	movq	%rbx, %rdx
	call	Rf_printRealVector
	leaq	.LC14(%rip), %rcx
	call	Rprintf
	movq	1344(%rsp), %rcx
	movl	$1, %r8d
	movq	%rbx, %rdx
	call	Rf_printRealVector
	leaq	.LC15(%rip), %rcx
	call	Rprintf
	movl	$1, %r8d
	movl	$1, %edx
	movq	224(%rsp), %rcx
	call	Rf_printRealVector
	leaq	.LC16(%rip), %rcx
	call	Rprintf
	movq	1360(%rsp), %rcx
	movq	%rbx, %rdx
	movl	$1, %r8d
	call	Rf_printRealVector
	leaq	.LC17(%rip), %rcx
	call	Rprintf
	movq	1352(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	1392(%rsp), %rax
	movl	(%rax), %edx
	jmp	.L758
	.p2align 4,,10
.L476:
	movl	%eax, %edx
	xorl	%eax, %eax
	jmp	.L481
	.p2align 4,,10
.L843:
	movq	%rcx, %rax
.L481:
	movq	1344(%rsp), %rsi
	leaq	1(%rax), %rcx
	movsd	(%rsi,%rax,8), %xmm0
	movq	344(%rsp), %rsi
	movsd	%xmm0, (%rsi,%rax,8)
	cmpq	%rdx, %rax
	jne	.L843
	jmp	.L479
	.p2align 4,,10
.L597:
	movl	%eax, %edx
	xorl	%eax, %eax
	jmp	.L602
	.p2align 4,,10
.L861:
	movq	%rcx, %rax
.L602:
	movq	1344(%rsp), %rsi
	leaq	1(%rax), %rcx
	movsd	(%rsi,%rax,8), %xmm0
	movq	128(%rsp), %rsi
	movsd	%xmm0, (%rsi,%rax,8)
	cmpq	%rdx, %rax
	jne	.L861
	jmp	.L600
	.p2align 4,,10
.L812:
	xorl	%eax, %eax
	jmp	.L205
	.p2align 4,,10
.L813:
	movq	%rcx, %rax
.L205:
	movq	1200(%rsp), %rbx
	leaq	1(%rax), %rcx
	movsd	(%rbx,%rax,8), %xmm0
	movq	1344(%rsp), %rbx
	movsd	%xmm0, (%rbx,%rax,8)
	movq	112(%rsp), %rbx
	movsd	(%rbx,%rax,8), %xmm0
	movq	1360(%rsp), %rbx
	movsd	%xmm0, (%rbx,%rax,8)
	cmpq	272(%rsp), %rax
	jne	.L813
	jmp	.L208
	.p2align 4,,10
.L1339:
	call	sqrt
	movapd	%xmm8, %xmm3
	movl	888(%rsp), %eax
	subsd	%xmm10, %xmm3
	movsd	%xmm3, 240(%rsp)
	testl	%eax, %eax
	jg	.L788
	jmp	.L550
	.p2align 4,,10
.L942:
	movapd	%xmm6, %xmm8
	jmp	.L785
	.p2align 4,,10
.L757:
	movq	160(%rsp), %rax
	movq	%r13, 56(%rsp)
	movl	%r14d, %edx
	movsd	360(%rsp), %xmm4
	movq	%r15, 48(%rsp)
	movq	%rax, 80(%rsp)
	movq	128(%rsp), %rax
	movsd	%xmm4, 64(%rsp)
	movq	1208(%rsp), %r9
	movq	1344(%rsp), %r8
	movq	%rax, 72(%rsp)
	movq	1352(%rsp), %rax
	movl	1184(%rsp), %ecx
	movsd	(%rax), %xmm0
	movq	1232(%rsp), %rax
	movq	%rax, 32(%rsp)
	movsd	%xmm0, 40(%rsp)
	call	sndofd
	jmp	.L663
	.p2align 4,,10
.L619:
	movq	1392(%rsp), %rax
	movl	%r14d, %r13d
	movl	(%rax), %edx
	cmpl	$3, %r12d
	je	.L764
.L770:
	movq	1272(%rsp), %rax
	movl	(%rax), %ecx
	leal	7(%rcx), %eax
	testl	%ecx, %ecx
	cmovns	%ecx, %eax
	testb	$8, %al
	jne	.L766
	movq	1352(%rsp), %rax
	leaq	.LC13(%rip), %rcx
	movsd	(%rax), %xmm0
	movsd	%xmm0, 936(%rsp)
	call	Rprintf
	leaq	.LC14(%rip), %rcx
	call	Rprintf
	movq	736(%rsp), %rbx
	movq	1344(%rsp), %rcx
	movl	$1, %r8d
	movq	%rbx, %rdx
	call	Rf_printRealVector
	leaq	.LC15(%rip), %rcx
	call	Rprintf
	movl	$1, %r8d
	movl	$1, %edx
	movq	224(%rsp), %rcx
	call	Rf_printRealVector
	leaq	.LC16(%rip), %rcx
	call	Rprintf
	movq	1360(%rsp), %rcx
	movl	$1, %r8d
	movq	%rbx, %rdx
	call	Rf_printRealVector
	leaq	.LC17(%rip), %rcx
	call	Rprintf
	jmp	.L766
	.p2align 4,,10
.L1338:
	movsd	%xmm1, 240(%rsp)
	call	sqrt
	movsd	240(%rsp), %xmm1
	jmp	.L526
	.p2align 4,,10
.L640:
	leal	-1(%rsi), %eax
	movq	344(%rsp), %rsi
	movsd	%xmm1, (%rsi,%rax,8)
.L636:
	movq	224(%rsp), %rax
	movq	344(%rsp), %r9
	movq	128(%rsp), %rdx
	movq	208(%rsp), %rcx
	movq	%rax, 32(%rsp)
	movq	%rax, %r8
	call	ddot_
	cmpl	$1, 440(%rsp)
	movapd	%xmm0, %xmm7
	jne	.L644
	movapd	%xmm9, %xmm1
	movl	916(%rsp), %esi
	divsd	%xmm0, %xmm1
	mulsd	%xmm1, %xmm7
	testl	%esi, %esi
	jle	.L663
	movapd	%xmm1, %xmm2
	movl	%esi, %ebx
	leal	-1(%rsi), %ebp
	movq	%r15, %rcx
	xorl	%r10d, %r10d
	xorl	%r9d, %r9d
	unpcklpd	%xmm2, %xmm2
	movl	$1, %edi
	.p2align 4,,10
.L648:
	movq	344(%rsp), %rdx
	cmpl	%esi, %r9d
	movl	%edi, %r11d
	movl	%r9d, %eax
	cmovl	%ebx, %r11d
	movsd	(%rdx,%r9,8), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, (%rdx,%r9,8)
	cmpl	$1, %ebx
	je	.L645
	cmpl	%r9d, %esi
	jle	.L645
	movl	%r11d, %r8d
	xorl	%edx, %edx
	shrl	%r8d
	salq	$4, %r8
	.p2align 4,,10
.L646:
	movupd	(%rcx,%rdx), %xmm0
	mulpd	%xmm2, %xmm0
	movups	%xmm0, (%rcx,%rdx)
	addq	$16, %rdx
	cmpq	%r8, %rdx
	jne	.L646
	movl	%r11d, %edx
	andl	$-2, %edx
	addl	%edx, %eax
	cmpl	%r11d, %edx
	je	.L647
.L645:
	addl	%r10d, %eax
	cltq
	leaq	(%r15,%rax,8), %rax
	movsd	(%rax), %xmm0
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, (%rax)
.L647:
	leaq	1(%r9), %rax
	subl	$1, %ebx
	addl	1184(%rsp), %r10d
	addq	200(%rsp), %rcx
	cmpq	%r9, %rbp
	je	.L649
	movq	%rax, %r9
	jmp	.L648
	.p2align 4,,10
.L674:
	testl	%esi, %esi
	jle	.L675
.L680:
	movq	%r15, %r10
	xorl	%r8d, %r8d
	movl	$1, %r9d
	.p2align 4,,10
.L684:
	movl	%r9d, %r11d
	testl	%r8d, %r8d
	je	.L875
	movl	%r9d, %ecx
	pxor	%xmm1, %xmm1
	movq	256(%rsp), %rax
	movq	136(%rsp), %rbx
	shrl	%ecx
	movq	296(%rsp), %rdi
	movq	%r10, %rdx
	movapd	%xmm1, %xmm2
	salq	$4, %rcx
	addq	%rax, %rcx
	.p2align 4,,10
.L682:
	movsd	(%rdx), %xmm0
	movupd	(%rax), %xmm5
	addq	$16, %rax
	movhpd	(%rdx,%rbx), %xmm0
	addq	%rdi, %rdx
	mulpd	%xmm5, %xmm0
	movapd	%xmm0, %xmm1
	unpckhpd	%xmm0, %xmm0
	addsd	%xmm2, %xmm1
	movapd	%xmm0, %xmm2
	addsd	%xmm1, %xmm2
	cmpq	%rax, %rcx
	jne	.L682
	movl	%r11d, %eax
	movapd	%xmm2, %xmm1
	andl	$-2, %eax
	cmpl	%eax, %r11d
	je	.L683
.L681:
	movl	1184(%rsp), %edx
	movq	160(%rsp), %rbx
	imull	%eax, %edx
	cltq
	addl	%r8d, %edx
	movslq	%edx, %rdx
	movsd	(%r15,%rdx,8), %xmm0
	mulsd	(%rbx,%rax,8), %xmm0
	addsd	%xmm0, %xmm1
.L683:
	movq	344(%rsp), %rax
	addl	$1, %r8d
	addq	$8, %r10
	movsd	%xmm1, -8(%rax,%r9,8)
	addq	$1, %r9
	cmpl	%esi, %r8d
	jl	.L684
	movl	352(%rsp), %r8d
	testl	%r8d, %r8d
	je	.L780
	movsd	360(%rsp), %xmm9
.L781:
	movq	.LC2(%rip), %xmm8
	xorl	%ebx, %ebx
	jmp	.L690
	.p2align 4,,10
.L1378:
	addq	$1, %rbx
	cmpl	%ebx, 908(%rsp)
	jle	.L663
.L690:
	movq	128(%rsp), %rax
	movsd	(%rax,%rbx,8), %xmm7
	movq	344(%rsp), %rax
	subsd	(%rax,%rbx,8), %xmm7
	movq	1360(%rsp), %rax
	movsd	(%rax,%rbx,8), %xmm1
	movq	112(%rsp), %rax
	andpd	%xmm8, %xmm7
	movsd	(%rax,%rbx,8), %xmm0
	andpd	%xmm8, %xmm1
	andpd	%xmm8, %xmm0
	call	Rf_fmax2
	mulsd	%xmm9, %xmm0
	comisd	%xmm7, %xmm0
	ja	.L1378
	movl	908(%rsp), %eax
	movl	%eax, 320(%rsp)
	testl	%eax, %eax
	jle	.L1379
	leal	-1(%rax), %r11d
	cmpl	$1, %r11d
	jbe	.L691
	cmpb	$0, 862(%rsp)
	je	.L691
	shrl	%eax
	movapd	%xmm13, %xmm1
	movl	%eax, %edx
	unpcklpd	%xmm1, %xmm1
	xorl	%eax, %eax
	salq	$4, %rdx
	.p2align 4,,10
.L692:
	movq	216(%rsp), %rbx
	movq	584(%rsp), %rsi
	movupd	(%rbx,%rax), %xmm4
	movaps	%xmm4, 368(%rsp)
	movupd	(%rsi,%rax), %xmm4
	movapd	368(%rsp), %xmm3
	movapd	%xmm4, %xmm0
	movaps	%xmm4, 416(%rsp)
	mulpd	%xmm1, %xmm0
	subpd	%xmm0, %xmm3
	movups	%xmm3, (%rsi,%rax)
	addq	$16, %rax
	cmpq	%rax, %rdx
	jne	.L692
	movl	320(%rsp), %ebx
	movl	%ebx, %eax
	andl	$-2, %eax
	cmpl	%ebx, %eax
	je	.L693
	movq	344(%rsp), %rbx
	movq	128(%rsp), %rsi
	leaq	(%rbx,%rax,8), %rdx
	movsd	(%rsi,%rax,8), %xmm0
	movsd	(%rdx), %xmm1
	mulsd	%xmm13, %xmm1
	subsd	%xmm1, %xmm0
	movsd	%xmm0, (%rdx)
.L693:
	movapd	%xmm13, %xmm2
	divsd	%xmm10, %xmm2
.L776:
	movl	320(%rsp), %edx
	movapd	%xmm2, %xmm1
	xorl	%eax, %eax
	unpcklpd	%xmm1, %xmm1
	shrl	%edx
	salq	$4, %rdx
	.p2align 4,,10
.L699:
	movq	256(%rsp), %rsi
	movupd	(%rsi,%rax), %xmm3
	movapd	%xmm3, %xmm0
	movaps	%xmm3, 368(%rsp)
	mulpd	%xmm1, %xmm0
	movups	%xmm0, (%rsi,%rax)
	addq	$16, %rax
	cmpq	%rdx, %rax
	jne	.L699
	movl	320(%rsp), %esi
	movl	%esi, %eax
	andl	$-2, %eax
	cmpl	%esi, %eax
	je	.L696
.L777:
	movq	160(%rsp), %rsi
	cltq
	cmpl	$1, 320(%rsp)
	movl	%r11d, 416(%rsp)
	leaq	(%rsi,%rax,8), %rax
	mulsd	(%rax), %xmm2
	movsd	%xmm2, (%rax)
	jle	.L698
.L697:
	movl	320(%rsp), %eax
	movq	312(%rsp), %r8
	movq	848(%rsp), %rcx
	movq	704(%rsp), %r9
	subl	$2, %eax
	leaq	16(%r15,%rax,8), %r10
	.p2align 4,,10
.L702:
	movq	136(%rsp), %rbx
	movq	%r9, %rdx
	movq	%r8, %rax
	.p2align 4,,10
.L701:
	movsd	(%rax), %xmm0
	addq	$8, %rdx
	movsd	%xmm0, -8(%rdx)
	movq	$0x000000000, (%rax)
	addq	%rbx, %rax
	cmpq	%rdx, %rcx
	jne	.L701
	addq	$8, %r8
	addq	136(%rsp), %r9
	addq	200(%rsp), %rcx
	cmpq	%r8, %r10
	jne	.L702
	testl	%r11d, %r11d
	jle	.L1380
.L775:
	movslq	416(%rsp), %rax
	movq	160(%rsp), %rbx
	ucomisd	(%rbx,%rax,8), %xmm11
	jp	.L877
	jne	.L877
	movl	320(%rsp), %eax
	subl	$2, %eax
	cltq
	jmp	.L708
	.p2align 4,,10
.L1381:
	movq	160(%rsp), %rbx
	subq	$1, %rax
	ucomisd	8(%rbx,%rax,8), %xmm11
	jp	.L705
	jne	.L705
.L708:
	movl	%eax, 368(%rsp)
	testl	%eax, %eax
	jg	.L1381
.L707:
	movl	320(%rsp), %eax
	testl	%eax, %eax
	jle	.L1382
.L731:
	movl	320(%rsp), %edx
	xorl	%r8d, %r8d
	movl	1184(%rsp), %ecx
	movl	1184(%rsp), %r9d
	movq	584(%rsp), %rsi
	testl	%edx, %edx
	leaq	-1(%rdx), %rax
	movq	%rdx, %rbx
	cmovle	%r8, %rax
	leaq	-8(,%rdx,8), %rdx
	imulq	248(%rsp), %rax
	salq	$3, %rax
	testl	%ecx, %ecx
	movq	%r8, %rcx
	cmovs	%rax, %rcx
	addq	%r15, %rcx
	testl	%r9d, %r9d
	cmovs	%r8, %rax
	addq	%r15, %rax
	testl	%ebx, %ebx
	cmovle	%r8, %rdx
	addq	776(%rsp), %rdx
	addq	1384(%rsp), %rdx
	cmpq	%rdx, %rcx
	seta	%r8b
	cmpq	%rsi, %rax
	setb	%dl
	orb	%dl, %r8b
	je	.L723
	movq	256(%rsp), %rdi
	cmpq	%rdi, %rax
	setb	%dl
	cmpq	%rdi, %rcx
	seta	%al
	orl	%eax, %edx
	movl	1184(%rsp), %eax
	testl	%eax, %eax
	setne	%al
	cmpl	$7, %ebx
	setg	%cl
	andl	%ecx, %eax
	testb	%al, %dl
	je	.L723
	testl	%ebx, %ebx
	movl	$1, %ecx
	movq	160(%rsp), %rax
	movq	%rsi, %rdx
	cmovg	%ebx, %ecx
	movsd	(%rax), %xmm2
	movq	%r15, %rax
	movl	%ecx, %r8d
	shrl	%r8d
	unpcklpd	%xmm2, %xmm2
	salq	$4, %r8
	addq	%rsi, %r8
	.p2align 4,,10
.L724:
	movupd	(%rdx), %xmm0
	movsd	(%rax), %xmm1
	addq	$16, %rdx
	movq	136(%rsp), %rbx
	mulpd	%xmm2, %xmm0
	movhpd	(%rax,%rbx), %xmm1
	addpd	%xmm1, %xmm0
	movlpd	%xmm0, (%rax)
	movhpd	%xmm0, (%rax,%rbx)
	addq	296(%rsp), %rax
	cmpq	%rdx, %r8
	jne	.L724
	movl	%ecx, %eax
	andl	$-2, %eax
	cmpl	%ecx, %eax
	je	.L730
	movl	1184(%rsp), %edx
	movq	344(%rsp), %rbx
	imull	%eax, %edx
	movsd	(%rbx,%rax,8), %xmm0
	movq	160(%rsp), %rax
	mulsd	(%rax), %xmm0
	movslq	%edx, %rdx
	leaq	(%r15,%rdx,8), %rdx
	addsd	(%rdx), %xmm0
	movsd	%xmm0, (%rdx)
.L730:
	movl	368(%rsp), %eax
	testl	%eax, %eax
	jle	.L1312
	movl	320(%rsp), %ebx
	testl	%ebx, %ebx
	jle	.L734
	movl	368(%rsp), %eax
	movq	%r15, %rdi
	movl	$1, %r9d
	cmpl	%eax, %ebx
	cmovle	%ebx, %eax
	xorl	%ebp, %ebp
	movl	%eax, 448(%rsp)
	movq	136(%rsp), %rax
	addq	$15, %rax
	movq	%rax, 520(%rsp)
	.p2align 4,,10
.L738:
	movsd	(%rdi), %xmm7
	movl	%ebp, %ecx
	addl	$1, %ebp
	movq	%rdi, %rsi
	leaq	8(%rdi), %r10
	movl	%ebp, %r12d
	ucomisd	%xmm11, %xmm7
	jnp	.L1383
.L735:
	movslq	%r9d, %rax
	movapd	%xmm7, %xmm0
	movl	%ecx, 440(%rsp)
	movsd	(%r15,%rax,8), %xmm8
	movl	%r9d, 416(%rsp)
	movq	%r10, 512(%rsp)
	movapd	%xmm8, %xmm1
	call	hypot
	leal	-1(%rbx), %r8d
	movl	440(%rsp), %ecx
	xorpd	.LC8(%rip), %xmm8
	movl	320(%rsp), %r11d
	cmpl	$5, %r8d
	movapd	%xmm7, %xmm4
	movl	416(%rsp), %r9d
	divsd	%xmm0, %xmm8
	seta	%dl
	cmpl	%ecx, %r11d
	setg	%al
	testb	%al, %dl
	divsd	%xmm0, %xmm4
	movapd	%xmm8, %xmm0
	je	.L882
	cmpq	$30, 520(%rsp)
	jbe	.L882
	cmpl	%ecx, %r11d
	movl	$1, %eax
	movapd	%xmm4, %xmm7
	movq	512(%rsp), %r10
	cmovle	%eax, %ebx
	movapd	%xmm8, %xmm5
	unpcklpd	%xmm7, %xmm7
	movq	%rdi, %rax
	unpcklpd	%xmm5, %xmm5
	xorl	%edx, %edx
	movl	%ebx, %ecx
	shrl	%ecx
	.p2align 4,,10
.L747:
	movsd	(%rax), %xmm2
	movsd	8(%rax), %xmm1
	movapd	%xmm7, %xmm3
	addl	$1, %edx
	movq	136(%rsp), %rsi
	movapd	%xmm5, %xmm8
	movhpd	(%rax,%rsi), %xmm2
	movhpd	8(%rsi,%rax), %xmm1
	mulpd	%xmm2, %xmm3
	mulpd	%xmm1, %xmm8
	mulpd	%xmm5, %xmm2
	mulpd	%xmm7, %xmm1
	subpd	%xmm8, %xmm3
	addpd	%xmm2, %xmm1
	movlpd	%xmm3, (%rax)
	movhpd	%xmm3, (%rax,%rsi)
	movlpd	%xmm1, 8(%rax)
	movhpd	%xmm1, 8(%rsi,%rax)
	addq	296(%rsp), %rax
	cmpl	%ecx, %edx
	jne	.L747
	movl	%ebx, %ecx
	andl	$-2, %ecx
	movl	%ecx, %eax
	imulq	%rsi, %rax
	leaq	(%rdi,%rax), %rdx
	addq	%r10, %rax
	cmpl	%ebx, %ecx
	je	.L745
	movsd	(%rdx), %xmm2
	movsd	(%rax), %xmm1
	movapd	%xmm0, %xmm5
	movapd	%xmm4, %xmm3
	mulsd	%xmm1, %xmm5
	mulsd	%xmm2, %xmm3
	mulsd	%xmm4, %xmm1
	mulsd	%xmm2, %xmm0
	subsd	%xmm5, %xmm3
	addsd	%xmm0, %xmm1
	movsd	%xmm3, (%rdx)
	movsd	%xmm1, (%rax)
.L745:
	addq	200(%rsp), %rdi
	movl	%r8d, %ebx
	addl	612(%rsp), %r9d
	cmpl	448(%rsp), %ebp
	jl	.L738
	cmpl	368(%rsp), %ebp
	jge	.L1312
.L734:
	movl	1184(%rsp), %edx
	movslq	%r12d, %rcx
	movl	320(%rsp), %edi
	imull	%r12d, %edx
	subl	%r12d, %edi
	movslq	%edx, %rax
	leal	1(%r12,%rdx), %esi
	addq	%rcx, %rax
	leaq	(%r15,%rax,8), %rbx
	jmp	.L743
	.p2align 4,,10
.L739:
	movslq	%esi, %rax
	movsd	(%r15,%rax,8), %xmm1
	call	hypot
.L741:
	movl	320(%rsp), %eax
	subl	$1, %edi
	addq	200(%rsp), %rbx
	addl	612(%rsp), %esi
	subl	%edi, %eax
	cmpl	368(%rsp), %eax
	jge	.L1312
.L743:
	movsd	(%rbx), %xmm0
	ucomisd	%xmm11, %xmm0
	jp	.L739
	jne	.L739
	movl	320(%rsp), %ecx
	movl	%ecx, %eax
	subl	%edi, %eax
	cmpl	%eax, %ecx
	jle	.L741
	movq	%rbx, %rax
	xorl	%edx, %edx
	.p2align 4,,10
.L742:
	movupd	(%rax), %xmm0
	addl	$1, %edx
	shufpd	$1, %xmm0, %xmm0
	movups	%xmm0, (%rax)
	addq	136(%rsp), %rax
	cmpl	%edi, %edx
	jb	.L742
	jmp	.L741
	.p2align 4,,10
.L1383:
	jne	.L735
	movq	%rdi, %rax
	xorl	%edx, %edx
	cmpl	%ecx, 320(%rsp)
	jle	.L1313
	.p2align 4,,10
.L737:
	movupd	(%rax), %xmm0
	addl	$1, %edx
	shufpd	$1, %xmm0, %xmm0
	movups	%xmm0, (%rax)
	addq	136(%rsp), %rax
	cmpl	%edx, %ebx
	ja	.L737
.L1313:
	leal	-1(%rbx), %r8d
	jmp	.L745
	.p2align 4,,10
.L875:
	xorl	%eax, %eax
	pxor	%xmm1, %xmm1
	jmp	.L681
.L1382:
	movl	368(%rsp), %eax
	testl	%eax, %eax
	jg	.L734
	.p2align 4,,10
.L1312:
	movl	908(%rsp), %eax
	movl	%eax, 320(%rsp)
.L727:
	cmpl	$1, 320(%rsp)
	jle	.L663
	movl	$8, %r10d
	xorl	%ebx, %ebx
	movl	$1, %ecx
	xorl	%edi, %edi
	movl	1184(%rsp), %r9d
	movq	704(%rsp), %r11
	movq	136(%rsp), %rsi
	.p2align 4,,10
.L733:
	movl	1184(%rsp), %ebp
	movq	%r11, %rdx
	movq	%rdi, %rax
	movl	1184(%rsp), %r12d
	subq	%r15, %rdx
	testl	%ebp, %ebp
	cmovs	%rbx, %rax
	addq	%r10, %rax
	cmpq	%rax, %rdx
	movq	%rdi, %rax
	setl	%dl
	testl	%r12d, %r12d
	cmovns	%rbx, %rax
	addq	%r10, %rax
	cmpq	%rax, %rsi
	setg	%al
	orb	%al, %dl
	je	.L751
	leal	-1(%rcx), %eax
	cmpl	$22, %eax
	jbe	.L751
	movl	%ecx, %r8d
	leaq	(%r15,%rsi), %rax
	leaq	(%r15,%r10), %rdx
	shrl	%r8d
	salq	$4, %r8
	addq	%rax, %r8
	.p2align 4,,10
.L752:
	movupd	(%rax), %xmm0
	movq	136(%rsp), %rbp
	addq	$16, %rax
	movlpd	%xmm0, (%rdx)
	movhpd	%xmm0, (%rdx,%rbp)
	addq	296(%rsp), %rdx
	cmpq	%r8, %rax
	jne	.L752
	movl	%ecx, %eax
	andl	$-2, %eax
	cmpl	%eax, %ecx
	je	.L755
	leal	(%r9,%rax), %edx
	imull	1184(%rsp), %eax
	movslq	%edx, %rdx
	movsd	(%r15,%rdx,8), %xmm0
	addl	%ecx, %eax
	cltq
	movsd	%xmm0, (%r15,%rax,8)
.L755:
	movq	136(%rsp), %rax
	addl	$1, %ecx
	addq	$8, %r10
	addq	200(%rsp), %r11
	addl	1184(%rsp), %r9d
	addq	%rax, %rbx
	addq	%rax, %rsi
	cmpl	%ecx, 320(%rsp)
	jne	.L733
	jmp	.L663
	.p2align 4,,10
.L751:
	leaq	(%r15,%rsi), %rax
	leaq	(%r15,%r10), %rdx
	jmp	.L754
	.p2align 4,,10
.L883:
	movq	%r8, %rax
.L754:
	movsd	(%rax), %xmm0
	leaq	8(%rax), %r8
	movsd	%xmm0, (%rdx)
	addq	136(%rsp), %rdx
	cmpq	%r11, %rax
	jne	.L883
	jmp	.L755
	.p2align 4,,10
.L882:
	movl	320(%rsp), %eax
	.p2align 4,,10
.L746:
	movsd	(%rsi), %xmm2
	movsd	8(%rsi), %xmm1
	movapd	%xmm4, %xmm3
	subl	$1, %eax
	movapd	%xmm0, %xmm5
	mulsd	%xmm2, %xmm3
	mulsd	%xmm1, %xmm5
	mulsd	%xmm0, %xmm2
	mulsd	%xmm4, %xmm1
	subsd	%xmm5, %xmm3
	addsd	%xmm1, %xmm2
	movsd	%xmm3, (%rsi)
	movsd	%xmm2, 8(%rsi)
	addq	136(%rsp), %rsi
	cmpl	%ecx, %eax
	jg	.L746
	jmp	.L745
.L644:
	movl	916(%rsp), %ebx
	testl	%ebx, %ebx
	jle	.L663
.L649:
	movl	352(%rsp), %r11d
	testl	%r11d, %r11d
	je	.L650
	movq	.LC2(%rip), %xmm8
	xorl	%ebx, %ebx
	jmp	.L652
	.p2align 4,,10
.L1384:
	addq	$1, %rbx
	cmpl	%ebx, %ebp
	jle	.L663
.L652:
	movq	1360(%rsp), %rax
	movsd	(%rax,%rbx,8), %xmm1
	movq	112(%rsp), %rax
	movsd	(%rax,%rbx,8), %xmm0
	andpd	%xmm8, %xmm1
	andpd	%xmm8, %xmm0
	call	Rf_fmax2
	movq	160(%rsp), %rax
	mulsd	360(%rsp), %xmm0
	movl	916(%rsp), %ebp
	movsd	(%rax,%rbx,8), %xmm1
	movq	344(%rsp), %rax
	subsd	(%rax,%rbx,8), %xmm1
	andpd	%xmm8, %xmm1
	comisd	%xmm0, %xmm1
	jb	.L1384
.L651:
	testl	%ebp, %ebp
	jle	.L663
	movapd	%xmm9, %xmm5
	movapd	%xmm7, %xmm4
	movq	%r15, %rbx
	movq	%r15, %rax
	movq	584(%rsp), %rcx
	movl	%ebp, %esi
	xorl	%r12d, %r12d
	xorl	%edx, %edx
	movq	256(%rsp), %r11
	unpcklpd	%xmm5, %xmm5
	unpcklpd	%xmm4, %xmm4
	movq	$0, 416(%rsp)
	.p2align 4,,10
.L662:
	movl	%ebp, %edi
	movl	%esi, %r8d
	leaq	8(%r11), %r10
	movl	$8, %r9d
	subl	%esi, %edi
	salq	$3, %r8
	movq	%r10, 320(%rsp)
	leaq	16(%rax), %r10
	cmpl	%ebp, %edi
	cmovge	%r9, %r8
	leaq	8(%rcx), %r9
	addq	416(%rsp), %r8
	movq	%r9, 368(%rsp)
	leaq	16(%rcx), %r9
	addq	%r15, %r8
	cmpq	%r9, %rax
	setnb	440(%rsp)
	cmpq	%rcx, %r10
	setbe	%r9b
	orb	440(%rsp), %r9b
	movb	%r9b, 440(%rsp)
	leaq	16(%r11), %r9
	cmpq	%r9, %rax
	setnb	%r9b
	cmpq	%r11, %r10
	setbe	%r10b
	orl	%r9d, %r10d
	andb	440(%rsp), %r10b
	cmpl	$1, %esi
	setne	%r9b
	cmpl	%ebp, %edi
	setl	440(%rsp)
	andb	440(%rsp), %r9b
	andl	%r9d, %r10d
	cmpq	%r8, %r11
	setnb	%r9b
	cmpq	320(%rsp), %rax
	setnb	%r11b
	orl	%r11d, %r9d
	testb	%r9b, %r10b
	je	.L871
	cmpq	%r8, %rcx
	setnb	%r9b
	cmpq	368(%rsp), %rax
	setnb	%r8b
	orb	%r8b, %r9b
	je	.L871
	movq	160(%rsp), %r9
	cmpl	%ebp, %edi
	movl	$1, %r11d
	movq	832(%rsp), %r10
	cmovl	%esi, %r11d
	xorl	%r8d, %r8d
	movsd	(%r9,%rdx,8), %xmm3
	movq	344(%rsp), %r9
	addq	%rcx, %r10
	addq	840(%rsp), %rcx
	movsd	(%r9,%rdx,8), %xmm2
	movl	%r11d, %r9d
	unpcklpd	%xmm3, %xmm3
	shrl	%r9d
	unpcklpd	%xmm2, %xmm2
	salq	$4, %r9
	.p2align 4,,10
.L659:
	movupd	(%r10,%r8), %xmm0
	movupd	(%rcx,%r8), %xmm1
	mulpd	%xmm3, %xmm0
	mulpd	%xmm2, %xmm1
	divpd	%xmm5, %xmm0
	divpd	%xmm4, %xmm1
	subpd	%xmm1, %xmm0
	movupd	(%rax,%r8), %xmm1
	addpd	%xmm1, %xmm0
	movups	%xmm0, (%rax,%r8)
	addq	$16, %r8
	cmpq	%r9, %r8
	jne	.L659
	movl	%r11d, %ecx
	andl	$-2, %ecx
	addl	%ecx, %edi
	cmpl	%r11d, %ecx
	je	.L661
	movq	160(%rsp), %r11
	leal	(%r12,%rdi), %ecx
	movslq	%edi, %rdi
	movslq	%ecx, %rcx
	movsd	(%r11,%rdi,8), %xmm0
	mulsd	(%r11,%rdx,8), %xmm0
	leaq	(%r15,%rcx,8), %rcx
	movq	344(%rsp), %r11
	movsd	(%r11,%rdi,8), %xmm1
	mulsd	(%r11,%rdx,8), %xmm1
	divsd	%xmm9, %xmm0
	divsd	%xmm7, %xmm1
	subsd	%xmm1, %xmm0
	addsd	(%rcx), %xmm0
	movsd	%xmm0, (%rcx)
.L661:
	movq	200(%rsp), %rdi
	addq	$1, %rdx
	addq	%rdi, 416(%rsp)
	addq	136(%rsp), %rbx
	addl	1184(%rsp), %r12d
	addq	%rdi, %rax
	movq	320(%rsp), %r11
	movq	368(%rsp), %rcx
	subl	$1, %esi
	jne	.L662
	jmp	.L663
	.p2align 4,,10
.L871:
	movq	%rdx, %rcx
	.p2align 4,,10
.L658:
	movq	160(%rsp), %rdi
	movsd	(%rdi,%rdx,8), %xmm0
	mulsd	(%rdi,%rcx,8), %xmm0
	movq	344(%rsp), %rdi
	movsd	(%rdi,%rdx,8), %xmm1
	mulsd	(%rdi,%rcx,8), %xmm1
	divsd	%xmm9, %xmm0
	divsd	%xmm7, %xmm1
	subsd	%xmm1, %xmm0
	addsd	(%rbx,%rcx,8), %xmm0
	movsd	%xmm0, (%rbx,%rcx,8)
	addq	$1, %rcx
	cmpl	%ecx, %ebp
	jg	.L658
	jmp	.L661
	.p2align 4,,10
.L1346:
	movsd	.LC0(%rip), %xmm13
	jmp	.L680
.L867:
	xorl	%ecx, %ecx
	pxor	%xmm1, %xmm1
	jmp	.L637
.L877:
	movl	416(%rsp), %eax
	movl	%eax, 368(%rsp)
.L705:
	movslq	368(%rsp), %rdx
	movq	160(%rsp), %rax
	leaq	(%rax,%rdx,8), %rsi
	leal	-1(%rdx), %eax
	imull	1184(%rsp), %eax
	cltq
	addq	%rdx, %rax
	leaq	-8(%r15,%rax,8), %rdi
	movl	320(%rsp), %eax
	leal	1(%rax), %ebx
	movq	136(%rsp), %rax
	subl	%edx, %ebx
	addq	$15, %rax
	movq	%rax, 520(%rsp)
	.p2align 4,,10
.L722:
	movsd	-8(%rsi), %xmm7
	leal	-1(%rdx), %r8d
	movq	%rdi, %rbp
	leaq	8(%rdi), %r9
	ucomisd	%xmm11, %xmm7
	jnp	.L1385
.L710:
	movsd	(%rsi), %xmm8
	movapd	%xmm7, %xmm0
	movl	%edx, 512(%rsp)
	movl	%r8d, 448(%rsp)
	movapd	%xmm8, %xmm1
	movq	%r9, 440(%rsp)
	call	hypot
	movapd	%xmm7, %xmm4
	xorpd	.LC8(%rip), %xmm8
	movl	448(%rsp), %r8d
	cmpl	%r8d, 320(%rsp)
	movq	440(%rsp), %r9
	divsd	%xmm0, %xmm8
	movl	512(%rsp), %edx
	divsd	%xmm0, %xmm4
	movapd	%xmm8, %xmm0
	jle	.L719
	cmpq	$30, 520(%rsp)
	jbe	.L879
	leal	-1(%rbx), %eax
	cmpl	$5, %eax
	jbe	.L879
	movl	%ebx, %ecx
	movapd	%xmm4, %xmm7
	movapd	%xmm8, %xmm5
	movq	%rdi, %rax
	shrl	%ecx
	unpcklpd	%xmm7, %xmm7
	unpcklpd	%xmm5, %xmm5
	xorl	%edx, %edx
	.p2align 4,,10
.L717:
	movsd	(%rax), %xmm2
	movsd	8(%rax), %xmm1
	movapd	%xmm7, %xmm3
	addl	$1, %edx
	movq	136(%rsp), %r11
	movapd	%xmm5, %xmm8
	movhpd	(%rax,%r11), %xmm2
	movhpd	8(%r11,%rax), %xmm1
	mulpd	%xmm2, %xmm3
	mulpd	%xmm1, %xmm8
	mulpd	%xmm5, %xmm2
	mulpd	%xmm7, %xmm1
	subpd	%xmm8, %xmm3
	addpd	%xmm2, %xmm1
	movlpd	%xmm3, (%rax)
	movhpd	%xmm3, (%rax,%r11)
	movlpd	%xmm1, 8(%rax)
	movhpd	%xmm1, 8(%r11,%rax)
	addq	296(%rsp), %rax
	cmpl	%edx, %ecx
	jne	.L717
	movl	%ebx, %ecx
	andl	$-2, %ecx
	movl	%ecx, %eax
	imulq	%r11, %rax
	leaq	(%rdi,%rax), %rdx
	addq	%r9, %rax
	cmpl	%ebx, %ecx
	je	.L719
	movsd	(%rdx), %xmm2
	movsd	(%rax), %xmm1
	movapd	%xmm2, %xmm3
	movapd	%xmm1, %xmm5
	mulsd	%xmm0, %xmm5
	mulsd	%xmm4, %xmm3
	mulsd	%xmm4, %xmm1
	mulsd	%xmm2, %xmm0
	subsd	%xmm5, %xmm3
	addsd	%xmm0, %xmm1
	movsd	%xmm3, (%rdx)
	movsd	%xmm1, (%rax)
.L719:
	movsd	(%rsi), %xmm1
	movsd	-8(%rsi), %xmm0
	movl	%r8d, 440(%rsp)
	call	hypot
	movl	440(%rsp), %r8d
	movsd	%xmm0, -8(%rsi)
.L713:
	subq	$8, %rsi
	addq	824(%rsp), %rdi
	addl	$1, %ebx
	movl	%r8d, %edx
	testl	%r8d, %r8d
	jne	.L722
	jmp	.L707
	.p2align 4,,10
.L1385:
	jne	.L710
	movq	%rdi, %rax
	xorl	%edx, %edx
	cmpl	%r8d, 320(%rsp)
	jle	.L714
	.p2align 4,,10
.L712:
	movupd	(%rax), %xmm0
	addl	$1, %edx
	shufpd	$1, %xmm0, %xmm0
	movups	%xmm0, (%rax)
	addq	136(%rsp), %rax
	cmpl	%ebx, %edx
	jb	.L712
.L714:
	movsd	(%rsi), %xmm0
	movsd	%xmm0, -8(%rsi)
	jmp	.L713
.L879:
	movl	416(%rsp), %eax
	subl	$2, %edx
	.p2align 4,,10
.L716:
	movsd	0(%rbp), %xmm2
	movsd	8(%rbp), %xmm1
	subl	$1, %eax
	movapd	%xmm2, %xmm3
	movapd	%xmm1, %xmm5
	mulsd	%xmm4, %xmm3
	mulsd	%xmm0, %xmm5
	mulsd	%xmm4, %xmm1
	mulsd	%xmm0, %xmm2
	subsd	%xmm5, %xmm3
	addsd	%xmm1, %xmm2
	movsd	%xmm3, 0(%rbp)
	movsd	%xmm2, 8(%rbp)
	addq	136(%rsp), %rbp
	cmpl	%edx, %eax
	jne	.L716
	jmp	.L719
.L780:
	ucomisd	360(%rsp), %xmm11
	ja	.L802
.L686:
	testl	%esi, %esi
	jle	.L663
	movsd	688(%rsp), %xmm9
	jmp	.L781
.L764:
	movq	1352(%rsp), %rax
	movq	872(%rsp), %rbx
	movsd	920(%rsp), %xmm0
	movsd	%xmm0, (%rax)
	movq	864(%rsp), %rax
	cmpq	%rax, 1344(%rsp)
	setnb	%cl
	movq	408(%rsp), %rax
	cmpq	%rax, 1360(%rsp)
	setnb	%al
	orl	%ecx, %eax
	movzbl	863(%rsp), %ecx
	andb	649(%rsp), %al
	andb	609(%rsp), %al
	andl	%eax, %ecx
	cmpq	%rbx, 1344(%rsp)
	setnb	%al
	orb	648(%rsp), %al
	testb	%al, %cl
	je	.L885
	cmpq	%rbx, 1360(%rsp)
	movzbl	650(%rsp), %ebx
	setnb	%al
	orb	%al, %bl
	je	.L885
	xorl	%eax, %eax
	.p2align 4,,10
.L768:
	movq	1200(%rsp), %rsi
	movupd	(%rsi,%rax), %xmm5
	movq	1344(%rsp), %rsi
	movups	%xmm5, (%rsi,%rax)
	movq	632(%rsp), %rsi
	movupd	(%rsi,%rax), %xmm3
	movq	1360(%rsp), %rsi
	movaps	%xmm3, 112(%rsp)
	movups	%xmm3, (%rsi,%rax)
	addq	$16, %rax
	cmpq	176(%rsp), %rax
	jne	.L768
	movl	192(%rsp), %ebx
	cmpl	%ebx, 184(%rsp)
	je	.L770
	movq	392(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	400(%rsp), %rax
	movsd	%xmm0, (%rax)
	movq	488(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	696(%rsp), %rax
	movsd	%xmm0, (%rax)
	jmp	.L770
.L696:
	movl	%r11d, 416(%rsp)
	jmp	.L697
.L650:
	ucomisd	360(%rsp), %xmm11
	movl	$0, %ebx
	movq	.LC2(%rip), %xmm8
	jbe	.L653
	jmp	.L654
	.p2align 4,,10
.L1289:
	addq	$1, %rbx
	cmpl	%ebx, %ebp
	jle	.L663
.L653:
	movq	1360(%rsp), %rax
	movsd	(%rax,%rbx,8), %xmm1
	movq	112(%rsp), %rax
	movsd	(%rax,%rbx,8), %xmm0
	andpd	%xmm8, %xmm1
	andpd	%xmm8, %xmm0
	call	Rf_fmax2
	movq	160(%rsp), %rax
	mulsd	360(%rsp), %xmm0
	divsd	688(%rsp), %xmm0
	movl	916(%rsp), %ebp
	movsd	(%rax,%rbx,8), %xmm1
	movq	344(%rsp), %rax
	subsd	(%rax,%rbx,8), %xmm1
	andpd	%xmm8, %xmm1
	comisd	%xmm0, %xmm1
	jb	.L1289
	jmp	.L651
.L1379:
	subl	$1, %eax
	movl	%eax, 416(%rsp)
.L698:
	movl	416(%rsp), %r10d
	testl	%r10d, %r10d
	jg	.L775
	movl	416(%rsp), %eax
	cmpl	$1, 320(%rsp)
	movl	%eax, 368(%rsp)
	jne	.L727
.L723:
	movq	%r15, %rdx
	xorl	%eax, %eax
	.p2align 4,,10
.L729:
	movq	344(%rsp), %rbx
	movsd	(%rbx,%rax,8), %xmm0
	movq	160(%rsp), %rbx
	addq	$1, %rax
	mulsd	(%rbx), %xmm0
	addsd	(%rdx), %xmm0
	movsd	%xmm0, (%rdx)
	addq	136(%rsp), %rdx
	cmpl	%eax, 320(%rsp)
	jg	.L729
	jmp	.L730
.L691:
	movl	%r11d, %ecx
	xorl	%eax, %eax
	movq	344(%rsp), %rsi
	movq	128(%rsp), %rbx
	jmp	.L694
	.p2align 4,,10
.L876:
	movq	%rdx, %rax
.L694:
	movsd	(%rsi,%rax,8), %xmm1
	movsd	(%rbx,%rax,8), %xmm0
	leaq	1(%rax), %rdx
	mulsd	%xmm13, %xmm1
	subsd	%xmm1, %xmm0
	movsd	%xmm0, (%rsi,%rax,8)
	cmpq	%rcx, %rax
	jne	.L876
	movapd	%xmm13, %xmm2
	xorl	%eax, %eax
	cmpl	$1, 320(%rsp)
	divsd	%xmm10, %xmm2
	je	.L777
	jmp	.L776
.L622:
	cmpb	$0, 861(%rsp)
	jne	.L793
	movq	1344(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	1200(%rsp), %rax
	subsd	(%rax), %xmm0
	movq	128(%rsp), %rax
	movsd	%xmm0, (%rax)
	movq	1360(%rsp), %rax
	movsd	(%rax), %xmm0
	movq	112(%rsp), %rax
	subsd	(%rax), %xmm0
	movq	160(%rsp), %rax
	movsd	%xmm0, (%rax)
	jmp	.L634
.L873:
	movsd	.LC0(%rip), %xmm13
.L675:
	movl	352(%rsp), %ecx
	testl	%ecx, %ecx
	jne	.L663
	ucomisd	360(%rsp), %xmm11
	jbe	.L663
.L802:
	movsd	360(%rsp), %xmm0
	call	sqrt
	movl	908(%rsp), %esi
	jmp	.L686
	.p2align 4,,10
.L1337:
	call	sqrt
	jmp	.L519
.L885:
	xorl	%eax, %eax
	.p2align 4,,10
.L767:
	movq	1200(%rsp), %rsi
	movq	1344(%rsp), %rbx
	movsd	(%rsi,%rax,8), %xmm0
	movq	112(%rsp), %rsi
	movsd	%xmm0, (%rbx,%rax,8)
	movq	1360(%rsp), %rbx
	movsd	(%rsi,%rax,8), %xmm0
	movsd	%xmm0, (%rbx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %r13d
	jg	.L767
	jmp	.L770
.L1351:
	movapd	%xmm6, %xmm0
	call	sqrt
	jmp	.L405
.L1380:
	movl	%r11d, 368(%rsp)
	jmp	.L731
.L1325:
	call	sqrt
	jmp	.L196
.L1334:
	call	sqrt
	jmp	.L491
.L1349:
	call	sqrt
	jmp	.L383
.L1363:
	movsd	%xmm1, 416(%rsp)
	call	sqrt
	movsd	416(%rsp), %xmm1
	jmp	.L435
.L1356:
	call	sqrt
	jmp	.L337
.L1362:
	movsd	%xmm3, 520(%rsp)
	call	sqrt
	movq	1352(%rsp), %rax
	movsd	520(%rsp), %xmm3
	movsd	(%rax), %xmm1
	jmp	.L375
.L1360:
	movsd	%xmm3, 520(%rsp)
	call	sqrt
	movq	1352(%rsp), %rax
	movsd	520(%rsp), %xmm3
	movsd	(%rax), %xmm1
	jmp	.L370
.L1367:
	movsd	%xmm3, 520(%rsp)
	call	sqrt
	movq	1352(%rsp), %rax
	movsd	520(%rsp), %xmm3
	movsd	(%rax), %xmm15
	jmp	.L374
.L1341:
	call	sqrt
	jmp	.L185
.L1366:
	movsd	%xmm3, 520(%rsp)
	call	sqrt
	movq	1352(%rsp), %rax
	movsd	520(%rsp), %xmm3
	movsd	(%rax), %xmm5
	jmp	.L369
.L1365:
	movsd	752(%rsp), %xmm3
	movsd	760(%rsp), %xmm14
	movsd	%xmm3, 240(%rsp)
	jmp	.L1314
.L1368:
	movapd	%xmm6, %xmm0
	call	sqrt
	jmp	.L502
.L1345:
	call	sqrt
	jmp	.L670
.L1364:
	movapd	%xmm12, %xmm14
	movapd	%xmm10, %xmm6
	movl	$1, %ebx
	xorl	%esi, %esi
	movsd	320(%rsp), %xmm12
	jmp	.L378
.L1354:
	movapd	%xmm12, %xmm14
	movl	$1, %ebx
	xorl	%esi, %esi
	movsd	320(%rsp), %xmm12
	jmp	.L378
.L1386:
	addq	$1, %rbx
	cmpl	%ebx, %ebp
	jle	.L663
.L654:
	movq	1360(%rsp), %rax
	movsd	(%rax,%rbx,8), %xmm1
	movq	112(%rsp), %rax
	movsd	(%rax,%rbx,8), %xmm0
	andpd	%xmm8, %xmm1
	andpd	%xmm8, %xmm0
	call	Rf_fmax2
	movapd	%xmm0, %xmm10
	movsd	360(%rsp), %xmm0
	mulsd	%xmm0, %xmm10
	call	sqrt
	movq	160(%rsp), %rax
	divsd	688(%rsp), %xmm10
	movl	916(%rsp), %ebp
	movsd	(%rax,%rbx,8), %xmm0
	movq	344(%rsp), %rax
	subsd	(%rax,%rbx,8), %xmm0
	andpd	%xmm8, %xmm0
	comisd	%xmm10, %xmm0
	jb	.L1386
	jmp	.L651
.L814:
	movapd	%xmm6, %xmm8
	jmp	.L265
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC1:
	.long	1431655765
	.long	1070945621
	.align 16
.LC2:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 16
.LC4:
	.long	0
	.long	1071644672
	.long	0
	.long	1071644672
	.align 8
.LC5:
	.long	0
	.long	1071644672
	.align 8
.LC6:
	.long	0
	.long	1074266112
	.align 8
.LC7:
	.long	0
	.long	1076101120
	.align 16
.LC8:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC9:
	.long	0
	.long	-1074790400
	.align 8
.LC10:
	.long	0
	.long	1083129856
	.align 8
.LC11:
	.long	0
	.long	1018167296
	.align 8
.LC12:
	.long	-1717986918
	.long	1069128089
	.align 8
.LC19:
	.long	0
	.long	1045430272
	.align 8
.LC20:
	.long	67108864
	.long	1072693248
	.align 16
.LC21:
	.long	-1
	.long	2147483647
	.long	-1
	.long	2147483647
	.align 16
.LC22:
	.long	0
	.long	-2147483648
	.long	0
	.long	-2147483648
	.align 8
.LC23:
	.long	-350469331
	.long	1058682594
	.align 8
.LC24:
	.long	2061584302
	.long	1072672276
	.align 8
.LC25:
	.long	-1
	.long	2146435071
	.align 8
.LC26:
	.long	-1717986918
	.long	1072273817
	.align 8
.LC27:
	.long	-1717986918
	.long	1070176665
	.align 8
.LC28:
	.long	0
	.long	1072168960
	.align 8
.LC29:
	.long	0
	.long	1073217536
	.align 8
.LC30:
	.long	-755914244
	.long	1062232653
	.ident	"GCC: (Built by Jeroen for the R-project) 8.3.0"
	.def	pow;	.scl	2;	.type	32;	.endef
	.def	Rf_fmax2;	.scl	2;	.type	32;	.endef
	.def	sqrt;	.scl	2;	.type	32;	.endef
	.def	memset;	.scl	2;	.type	32;	.endef
	.def	Rf_fmin2;	.scl	2;	.type	32;	.endef
	.def	memcpy;	.scl	2;	.type	32;	.endef
	.def	dtrsl_;	.scl	2;	.type	32;	.endef
	.def	dnrm2_;	.scl	2;	.type	32;	.endef
	.def	ddot_;	.scl	2;	.type	32;	.endef
	.def	dscal_;	.scl	2;	.type	32;	.endef
	.def	Rprintf;	.scl	2;	.type	32;	.endef
	.def	Rf_printRealVector;	.scl	2;	.type	32;	.endef
	.def	hypot;	.scl	2;	.type	32;	.endef
