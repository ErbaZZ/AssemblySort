;
; file: sort.asm
; This program sort 3 inputted numbers in ascending order
;
; To create executable:
; NASM –f obj –d obj_type sort.asm
; BCC32 sort.obj driver.obj asm_io.obj
;
; Works like the following C program:
; #include <stdio.h>
;
; void main() {
;	  int num1;
;	  int num2;
;	  int num3;
;	  scanf("%d",&num1);
;	  scanf("%d",&num2);
;	  scanf("%d",&num3);
;	  if (num1 < num2) {
;	  	if (num1 < num3) {
;	  		if (num2 < num3) {
;	  			printf("%d\n",num1);
;	  			printf("%d\n",num2);
;	  			printf("%d\n",num3);
;	  		}
;	  		else {
;	  			printf("%d\n",num1);
;	  			printf("%d\n",num3);
;	  			printf("%d\n",num2);
;	  		}
;	  	}
;	  	else {
;	  		printf("%d\n",num3);
;	  		printf("%d\n",num1);
;	  		printf("%d\n",num2);
;	  	}
;	  }
;	  else {
;	  	if (num1 < num3) {
;	  		printf("%d\n",num2);
;	  		printf("%d\n",num1);
;	  		printf("%d\n",num3);
;	  	}
;	  	else {
;	  		if (num2 < num3) {
;	  			printf("%d\n",num2);
;	  			printf("%d\n",num3);
;	  			printf("%d\n",num1);
;	  		}
;	  		else {
;	  			printf("%d\n",num3);
;	  			printf("%d\n",num2);
;	  			printf("%d\n",num1);
;	  		}
;	  	}
;	  }
; }
;

%include "asm_io.inc"

segment _DATA public align=4 class=DATA use32
Message         db      "Please input 3 integers: ", 0


segment _BSS public align=4 class=BSS use32
num1           resd    1               ; Store input
num2           resd    1               ; Store input
num3           resd    1               ; Store input

group DGROUP _BSS _DATA

segment _TEXT public align=1 class=CODE use32
        global  _asm_main
_asm_main:
        enter   0,0                   ; setup routine
        pusha

        mov     eax, Message          ; printf("%s",Message);
        call    print_string
        call    print_nl

        call    read_int              ; scanf("%u", & num1 );
        mov     [num1], eax

        call    read_int              ; scanf("%u", & num2 );
        mov     [num2], eax

        call    read_int              ; scanf("%u", & num3 );
        mov     [num3], eax

        mov     eax, [num1]           ; if (num1 < num2)
        cmp     eax, [num2]
        jnl     else1

        cmp     eax, [num3]           ; if (num1 < num3)
        jnl     else21

        mov     eax, [num2]           ; if (num2 < num3)
        cmp     eax, [num3]
        jnl     else31

        mov     eax, [num1]           ; printf("%d\n",num1);
        call    print_int
        call    print_nl

        mov     eax, [num2]           ; printf("%d\n",num2);
        call    print_int
        call    print_nl

        mov     eax, [num3]           ; printf("%d\n",num3);
        call    print_int
        call    print_nl

        jmp     end

else31:
        mov     eax, [num1]           ; printf("%d\n",num1);
        call    print_int
        call    print_nl

        mov     eax, [num3]           ; printf("%d\n",num3);
        call    print_int
        call    print_nl

        mov     eax, [num2]           ; printf("%d\n",num2);
        call    print_int
        call    print_nl

        jmp     end

else21:
        mov     eax, [num3]           ; printf("%d\n",num3);
        call    print_int
        call    print_nl

        mov     eax, [num1]           ; printf("%d\n",num1);
        call    print_int
        call    print_nl

        mov     eax, [num2]           ; printf("%d\n",num2);
        call    print_int
        call    print_nl

        jmp     end
else1:
        mov     eax, [num1]           ; if (num1 < num3)
        cmp     eax, [num3]
        jnl     else22

        mov     eax, [num2]           ; printf("%d\n",num2);
        call    print_int
        call    print_nl

        mov     eax, [num1]           ; printf("%d\n",num1);
        call    print_int
        call    print_nl

        mov     eax, [num3]           ; printf("%d\n",num3);
        call    print_int
        call    print_nl

        jmp     end
else22:
        mov     eax, [num2]           ; if (num2 < num3)
        cmp     eax, [num3]
        jnl     else32

        mov     eax, [num2]           ; printf("%d\n",num2);
        call    print_int
        call    print_nl

        mov     eax, [num3]           ; printf("%d\n",num3);
        call    print_int
        call    print_nl

        mov     eax, [num1]           ; printf("%d\n",num1);
        call    print_int
        call    print_nl

        jmp     end

else32:
        mov     eax, [num3]           ; printf("%d\n",num3);
        call    print_int
        call    print_nl

        mov     eax, [num2]           ; printf("%d\n",num2);
        call    print_int
        call    print_nl

        mov     eax, [num1]           ; printf("%d\n",num1);
        call    print_int
        call    print_nl

end:
        mov     eax, 0
        leave
        ret
