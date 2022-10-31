INCLUDE io.h
.586
.model flat

.data
nuc			DWORD 100 DUP (?), 0							; variable to hold user input of nucleotide string
prompt		BYTE   "Enter nucloetide string: ", 0
resultLbl	BYTE   "Total number of nucleotides: ", 0
resultLbl1	BYTE   "Amount of guanine: ", 0
resultLbl2	BYTE   "Amount of adenine: ", 0
resultLbl3	BYTE   "Amount of thymine: ", 0
resultLbl4	BYTE   "Amount of cytosine: ", 0
guanine		BYTE   ?
adenine		BYTE   ?
thymine		BYTE   ?
cytosine	BYTE   ?
total		DWORD  ?
guanine_percentage	BYTE	?
adenine_percentage	BYTE	?
thymine_percentage	BYTE	?
cytosine_percentage BYTE	?

.code
_MainProc proc
	 
	 input prompt, nuc, 100									; prompt user for nucleotide string

	 mov edi, 0												; clear data pointer
     mov edi, OFFSET nuc									; set data pointer to first char of nucleotide string
	 mov eax, 0 											; clear eax		al: counter for C	ah: counter for T
	 mov ebx, 0 											; clear ebx		al: counter for A	bh: counter for G
	 mov ecx, 0												; clear ecx		points to char of nucleotide being compared in loop
	 mov edx, 0 											; clear edx		holds askii values for nucleotides
	 mov ebp,0
	 


LP:															; loop to go through nucleotide string and check each char for matching nucleotide
	
	
	inc ebp													; increment ebp to keep track of total number
	mov edx,0
	mov edx,47415443h										; askii values of nucleotides "GATC" to check against string of nucleotides
															; G: guanine (askii: 47), A: adenine (askii: 41), T: thymine (askii: 54), C: cytosine (askii: 43)

	.if [edi] == dl											; if edi is pointing at 43 (C)
	inc al													; increment counter for C
	.endif
	
	ror edx,8												; dl = 54 (T)

	.if [edi] == dl											; if edi is pointing at 54 (T)
	inc ah                                                  ; increment counter for T
	.endif


	ror edx,8												; dl = 41 (T)

	.if [edi] == dl											; if edi is pointing at 41 (A)
	inc bl                                                  ; increment counter for A
	.endif

	ror edx,8												; dl = 47 (G)

	.if [edi] == dl											; if edi is pointing at 47 (G)
	inc bh                                                  ; increment counter for G
	.endif
	
	mov cl, [edi]											; move char to cl. when cl is 0, we have reached end of nucleotide string
	inc edi													; increment edi to point to next char in nucleotide string

	cmp cx, 0												; if cx is 0, we have reached end of nucleotide string
	jne LP													; if cx is not 0, repeat loop

 	dec ebp													; subtract 1 from ebp after loop to get final total amount of nucleotides
	mov total, ebp											; save number of nucleotides to memory

	mov cl, bh												; move guanine counter into cl for conversion

	wtoa guanine, cx										; convert dec to askii value in cx and place in guanine
	output resultLbl1, guanine								; output guanine count

	ror ecx, 16												; rotate ecx so cx is clear
	mov	cl, bl												; move adenine counter into cl for conversion

	wtoa adenine, cx										; convert dec to askii value in cx and place in adenine
	output resultLbl2, adenine								; output adenine count

	ror ecx, 16												; rotate ecx so cx is clear
	mov	cl, ah												; move thymine counter into cl for conversion

	wtoa thymine, cx										; convert dec to askii value in cx and place in thymine
 	output resultLbl3, thymine								; output thymine count

	ror ecx, 16												; rotate ecx so cx is clear
	mov	cl, al												; move cytosine counter into cl for conversion

	wtoa cytosine, cx										; convert dec to askii value in cx and place in cytosine
	output resultLbl4, cytosine								; output cytosine count

	mov total, ebp											; stores the amount of nucleotides in memory
	dtoa total, total										; converts into askii
	output resultLbl, total									; output total count

    ret														


_MainProc ENDP												; end of procedure _MainProc
END															; end of program