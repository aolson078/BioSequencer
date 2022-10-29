INCLUDE io.h
.386
.model flat

.data
nuc			DWORD 100 DUP (?), 0							; variable to hold user input of nucleotide string
prompt		BYTE  "Enter nucloetide string: ", 0			
resultLbl	BYTE  "Frequency of each nucleotide: ", 0

.code
_MainProc proc
	 
	 input prompt, nuc, 100									; prompt user for nucleotide string

	 mov edi, 0												; clear data pointer
     mov edi, OFFSET nuc									; set data pointer to first char of nucleotide string
	 
	 mov eax, 0 											; clear eax		al: counter for C	ah: counter for T
	 mov ebx, 0 											; clear ebx		al: counter for A	bh: counter for G
	 mov ecx, 0												; clear ecx		points to char of nucleotide being compared in loop
	 mov edx, 0 											; clear edx		holds askii values for nucleotides

	 mov edx,47415443h										; askii values of nucleotides "GATC" to check against string of nucleotides
															; G: guanine (askii: 47), A: adenine (askii: 41), T: thymine (askii: 54), C: cytosine (askii: 43)

LP:															; loop to go through nucleotide string and check each char for matching nucleotide

	.if [edi] == dl											; if edi is pointing at 43 (C)
	inc al													; increment counter for C
	.endif
	
	ror edx,8												; dl = 54 (T)

	.if [edi] == dl											; if edi is pointing at 54 (T)
	inc ah                                                  ; increment counter for T
	.endif

	ror edx,8												; dl = 41 (T)

	.if [edi] == dl											; if edi is pointing at 41 (A)
	inc bl                                                  ; increment counter for t
	.endif

	ror edx,8												; dl = 47 (G)

	.if [edi] == dl											; if edi is pointing at 47 (G)
	inc bh                                                  ; increment counter for G
	.endif
	
	mov cl, [edi]											; move char to cl. when cl is 0, we have reached end of nucleotide string
	inc edi													; increment edi to point to next char in nucleotide string
	cmp cx, 0												; if cx is 0, we have reached end of nucleotide string
	jne LP													; if cx is not 0, repeat loop
    ret														; return from loop

_MainProc ENDP												; end of procedure _MainProc
END															; end of program