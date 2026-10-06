bits 64
default rel

; Here comes the defines
sys_read: equ 0    
sys_write: equ 1
sys_nanosleep: equ 35
sys_time: equ 201
sys_fcntl: equ 72

STDIN_FILENO: equ 0

F_SETFL: equ 0x0004
O_NONBLOCK: equ 0x0004

;screen clean definition
row_cells: equ 10 ; set to any (reasonable) value you wish
column_cells: equ 40 ; set to any (reasonable) value you wish

array_length: equ row_cells * column_cells + row_cells ; cells are mapped to bytes in the array and a new line char ends each row

;This is regarding the sleep time
timespec:
    tv_sec dq 0
    tv_nsec dq 20000000

;This is for cleaning up the screen
clear: db 27, "[2J", 27, "[H"
clear_length: equ $-clear


; Start Message
    msg1: db "                                                TECNOLOGICO DE COSTA RICA                                  ", 0xA, 0xD
    msg2: db "                                              ARQUITECTURA DE COMPUTADORAS I                                  ", 0xA, 0xD
    msg3: db "                                     VLADIMIR GONZALEZ MORERA  PABLO NAVARRO ROBLES                         ", 0xA, 0xD 
    msg4: db " ", 0xA
    msg5: db " ", 0xA
    msg6: db "        SSSSS  PPPPP  AAAAAA  CCCCC  EEEEE   IIIIII  NNN   NN  VVV   VVV  AAAAAA  DDDD   EEEEE  RRRRRR    SSSSS  ", 0xA,0xD
    msg7: db "       SS      PP  PP AA  AA  CC     EE        II    NN N  NN   VV   VV   AA  AA  DD DD  EE     RR   RR  SS      ", 0xA,0xD
    msg8: db "        SSSS   PPPPP  AAAAAA  CC     EEEE      II    NN  N NN    VV VV    AAAAAA  DD  DD EEEEE  RRRRRR    SSSSS  ", 0xA,0xD
    msg9: db "           SS  PP     AA  AA  CC     EE        II    NN   NNN     VVV     AA  AA  DD DD  EE     RR   RR       SS ", 0xA,0xD
    msg10: db "       SSSSS   PP     AA  AA  CCCCC  EEEEE   IIIIII  NN    NN      V      AA  AA  DDDD   EEEEE  RR   RR   SSSSS  ", 0xA, 0xD
    msg11: db " ", 0xA
    msg12: db " ", 0xA
    msg13: db "                                          PRESIONE CUALQUIER TECLA PARA INICIAR                             ", 0xA, 0xD


msg1_length: equ $-msg1
msg2_length: equ $-msg2
msg3_length: equ $-msg3
msg4_length: equ $-msg4
msg5_length: equ $-msg5

; Usefull macros

%macro setnonblocking 0
    mov rax, sys_fcntl
    mov rdi, STDIN_FILENO
    mov rsi, F_SETFL
    mov rdx, O_NONBLOCK
    syscall
%endmacro

%macro unsetnonblocking 0
    mov rax, sys_fcntl
    mov rdi, STDIN_FILENO
    mov rsi, F_SETFL
    mov rdx, 0
    syscall
%endmacro

%macro full_line 0
    times column_cells db "*"
    db 0x0a, 0xD
%endmacro



%macro hollow_line 0
    db "*"
    times column_cells-2 db " "
    db "*", 0x0a, 0xD
%endmacro

%macro print 2
    mov eax, sys_write
    mov edi, 1 ; stdout
    mov rsi, %1
    mov edx, %2
    syscall
%endmacro

%macro getchar 0
    mov rax, sys_read
    mov rdi, STDIN_FILENO
    mov rsi, input_char
    mov rdx, 1 ; number of bytes
    syscall ;read text input from keyboard
%endmacro

%macro sleeptime 0
    mov eax, sys_nanosleep
    mov rdi, timespec
    xor esi, esi ; ignore remaining time in case of call interruption
    syscall ; sleep for tv_sec seconds + tv_nsec nanoseconds
%endmacro
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global _start

section .bss
    input_char: resb 1



section .data

    board:
        full_line
        %rep 30
        hollow_line
        %endrep
        full_line

    board_size: equ $ - board

    gameoverboard: 
    
        %rep 5
        full_line
        %endrep
        
        %rep 9
        hollow_line
        %endrep
        
        gmsmg: db "            G A M E    O V E R", 0xA, 0xD
        
        %rep 9
        hollow_line
        %endrep
        
        %rep 5
        full_line
        %endrep
        
    gmboard_size: equ $ - gameoverboard

    level1board: 
    
        %rep 5
        full_line
        %endrep
        
        %rep 9
        hollow_line
        %endrep
        
        lvsmg: db "            L E V E L  2", 0xA, 0xD
        
        %rep 9
        hollow_line
        %endrep
        
        %rep 5
        full_line
        %endrep
        
    lvboard_size: equ $ - level1board
    
    level3board: 
    
        %rep 5
        full_line
        %endrep
        
        %rep 9
        hollow_line
        %endrep
        
        lv3smg: db "            L E V E L  3", 0xA, 0xD
        
        %rep 9
        hollow_line
        %endrep
        
        %rep 5
        full_line
        %endrep
        
    lv3board_size: equ $ - level3board

  level4board: 
    
        %rep 5
        full_line
        %endrep
        
        %rep 9
        hollow_line
        %endrep
        
        lv4smg: db "            L E V E L  4", 0xA, 0xD
        
        %rep 9
        hollow_line
        %endrep
        
        %rep 5
        full_line
        %endrep
        
    lv4board_size: equ $ - level4board

    level5board: 
    
        %rep 5
        full_line
        %endrep
        
        %rep 9
        hollow_line
        %endrep
        
        lv5smg: db "            L A S T  L E V E L", 0xA, 0xD
        
        %rep 9
        hollow_line
        %endrep
        
        %rep 5
        full_line
        %endrep
        
    lv5board_size: equ $ - level5board

    levelfboard: 
    
        %rep 5
        full_line
        %endrep
        
        %rep 9
        hollow_line
        %endrep
        
        lvfsmg: db "            Y O U  W I N", 0xA, 0xD
        
        %rep 9
        hollow_line
        %endrep
        
        %rep 5
        full_line
        %endrep
        
    lvfboard_size: equ $ - levelfboard

    ; Added for the terminal issue
    termios: times 36 db 0
    stdin: equ 0
    ICANON: equ 1<<1
    ECHO: equ 1<<3
    VTIME: equ 5
    VMIN: equ 6
    CC_C: equ 18

section .text
;;;;;;;;;;;;;;;;;;;;for the working of the terminal;;;;;;;;;;;;;;;;;
canonical_off:
    call read_stdin_termios

    ; clear canonical bit in local mode flags
    push rax
    mov eax, ICANON
    not eax
    and [termios+12], eax
    mov byte [termios+CC_C+VTIME], 0
    mov byte [termios+CC_C+VMIN], 0
    pop rax

    call write_stdin_termios
    ret

echo_off:
    call read_stdin_termios

    ; clear echo bit in local mode flags
    push rax
    mov eax, ECHO
    not eax
    and [termios+12], eax
    pop rax

    call write_stdin_termios
    ret

canonical_on:
    call read_stdin_termios

    ; set canonical bit in local mode flags
    or dword [termios+12], ICANON
    mov byte [termios+CC_C+VTIME], 0
    mov byte [termios+CC_C+VMIN], 1
    call write_stdin_termios
    ret

echo_on:
    call read_stdin_termios

    ; set echo bit in local mode flags
    or dword [termios+12], ECHO

    call write_stdin_termios
    ret

read_stdin_termios:
    push rax
    push rbx
    push rcx
    push rdx

    mov eax, 36h
    mov ebx, stdin
    mov ecx, 5401h
    mov edx, termios
    int 80h

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

write_stdin_termios:
    push rax
    push rbx
    push rcx
    push rdx

    mov eax, 36h
    mov ebx, stdin
    mov ecx, 5402h
    mov edx, termios
    int 80h

    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret

;;;;;;;;;;;;;;;;;;;;end for the working of the terminal;;;;;;;;;;;;

char_equal: equ 61
char_space: equ 32
char_O: equ 79
char_por: equ 37
char_shoot: equ 33
left_direction: equ -1
right_direction: equ 1

section .data

    pallet_position dq board + 40 + 29 * (column_cells + 2)
    pallet_size dq 3

    plane_size dq 1

    ball_y_pos: dq 28


    enemy1_x_pos dq 9
    enemy1_y_pos dq 10 

    enemy2_x_pos dq 12
    enemy2_y_pos dq 10 

    enemy3_x_pos dq 15
    enemy3_y_pos dq 10 

    enemy4_x_pos dq 18
    enemy4_y_pos dq 10

    enemy5_x_pos dq 21
    enemy5_y_pos dq 10 

    enemy6_x_pos dq 24
    enemy6_y_pos dq 10 

    enemy7_x_pos dq 27
    enemy7_y_pos dq 10 

    enemy8_x_pos dq 30
    enemy8_y_pos dq 10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;Segunda fila
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    enemy9_x_pos dq 9
    enemy9_y_pos dq 12 

    enemy10_x_pos dq 12
    enemy10_y_pos dq 12 

    enemy11_x_pos dq 15
    enemy11_y_pos dq 12 

    enemy12_x_pos dq 18
    enemy12_y_pos dq 12

    enemy13_x_pos dq 21
    enemy13_y_pos dq 12 

    enemy14_x_pos dq 24
    enemy14_y_pos dq 12 

    enemy15_x_pos dq 27
    enemy15_y_pos dq 12 

    enemy16_x_pos dq 30
    enemy16_y_pos dq 12
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;tercer fila
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    enemy17_x_pos dq 9
    enemy17_y_pos dq 14 

    enemy18_x_pos dq 12
    enemy18_y_pos dq 14 

    enemy19_x_pos dq 15
    enemy19_y_pos dq 14 

    enemy20_x_pos dq 18
    enemy20_y_pos dq 14

    enemy21_x_pos dq 21
    enemy21_y_pos dq 14 

    enemy22_x_pos dq 24
    enemy22_y_pos dq 14 

    enemy23_x_pos dq 27
    enemy23_y_pos dq 14 

    enemy24_x_pos dq 30
    enemy24_y_pos dq 14

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;Cuarta fila
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    enemy25_x_pos dq 9
    enemy25_y_pos dq 16 

    enemy26_x_pos dq 12
    enemy26_y_pos dq 16 

    enemy27_x_pos dq 15
    enemy27_y_pos dq 16 

    enemy28_x_pos dq 18
    enemy28_y_pos dq 16

    enemy29_x_pos dq 21
    enemy29_y_pos dq 16 

    enemy30_x_pos dq 24
    enemy30_y_pos dq 16

    enemy31_x_pos dq 27
    enemy31_y_pos dq 16 

    enemy32_x_pos dq 30
    enemy32_y_pos dq 16

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    wallx1 dq 8
    wally1 dq 24

    wallx2 dq 8
    wally2 dq 23

    wallx3 dq 9
    wally3 dq 23

    wallx4 dq 10
    wally4 dq 23

    wallx5 dq 10
    wally5 dq 24

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    wallx6 dq 15
    wally6 dq 24

    wallx7 dq 15
    wally7 dq 23

    wallx8 dq 16
    wally8 dq 23
    
    wallx9 dq 17
    wally9 dq 23

    wallx10 dq 17
    wally10 dq 24

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    wallx11 dq 22
    wally11 dq 24

    wallx12 dq 22
    wally12 dq 23

    wallx13 dq 23
    wally13 dq 23
    
    wallx14 dq 24
    wally14 dq 23

    wallx15 dq 24
    wally15 dq 24

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    wallx16 dq 29
    wally16 dq 24

    wallx17 dq 29
    wally17 dq 23

    wallx18 dq 30
    wally18 dq 23
    
    wallx19 dq 31
    wally19 dq 23

    wallx20 dq 31
    wally20 dq 24

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    enemy1_timer dq 1000000  
    enemy1_timer_counter dq 0

    shoot_y_pos: dq 29

    ball_active: dq 1

    ball_again: dq 1

    enemy1_active: dq 1  
    enemy2_active: dq 1  
    enemy3_active: dq 1
    enemy4_active: dq 1
    enemy5_active: dq 1  
    enemy6_active: dq 1  
    enemy7_active: dq 1
    enemy8_active: dq 1

    enemy9_active:  dq 1  
    enemy10_active: dq 1  
    enemy11_active: dq 1
    enemy12_active: dq 1
    enemy13_active: dq 1  
    enemy14_active: dq 1  
    enemy15_active: dq 1
    enemy16_active: dq 1

    enemy17_active: dq 1  
    enemy18_active: dq 1  
    enemy19_active: dq 1
    enemy20_active: dq 1
    enemy21_active: dq 1  
    enemy22_active: dq 1  
    enemy23_active: dq 1
    enemy24_active: dq 1

    enemy25_active: dq 1  
    enemy26_active: dq 1  
    enemy27_active: dq 1
    enemy28_active: dq 1
    enemy29_active: dq 1  
    enemy30_active: dq 1  
    enemy31_active: dq 1
    enemy32_active: dq 1

    one_active: dq 1

    enemy_move_time dq 120
    enemy_direction dq 1 

    enemy_move_time_2 dq 120
    enemy_direction_2 dq 1 

    enemy_move_time_3 dq 120
    enemy_direction_3 dq 1 

    enemy_move_time_4 dq 120
    enemy_direction_4 dq 1 

    enemy_move_time_5 dq 120
    enemy_direction_5 dq 1 

    enemy_move_time_6 dq 120
    enemy_direction_6 dq 1 

    enemy_move_time_7 dq 120
    enemy_direction_7 dq 1 

    enemy_move_time_8 dq 120
    enemy_direction_8 dq 1

    enemy_move_time_9 dq 120
    enemy_direction_9 dq 1 

    enemy_move_time_10 dq 120
    enemy_direction_10 dq 1 

    enemy_move_time_11 dq 120
    enemy_direction_11 dq 1 

    enemy_move_time_12 dq 120
    enemy_direction_12 dq 1 

    enemy_move_time_13 dq 120
    enemy_direction_13 dq 1 

    enemy_move_time_14 dq 120
    enemy_direction_14 dq 1 

    enemy_move_time_15 dq 120
    enemy_direction_15 dq 1 

    enemy_move_time_16 dq 120
    enemy_direction_16 dq 1


    enemy_move_time_17 dq 120
    enemy_direction_17 dq 1 

    enemy_move_time_18 dq 120
    enemy_direction_18 dq 1 

    enemy_move_time_19 dq 120
    enemy_direction_19 dq 1 

    enemy_move_time_20 dq 120
    enemy_direction_20 dq 1 

    enemy_move_time_21 dq 120
    enemy_direction_21 dq 1 

    enemy_move_time_22 dq 120
    enemy_direction_22 dq 1 

    enemy_move_time_23 dq 120
    enemy_direction_23 dq 1 

    enemy_move_time_24 dq 120
    enemy_direction_24 dq 1


    enemy_move_time_25 dq 120
    enemy_direction_25 dq 1 

    enemy_move_time_26 dq 120
    enemy_direction_26 dq 1 

    enemy_move_time_27 dq 120
    enemy_direction_27 dq 1 

    enemy_move_time_28 dq 120
    enemy_direction_28 dq 1 

    enemy_move_time_29 dq 120
    enemy_direction_29 dq 1 

    enemy_move_time_30 dq 120
    enemy_direction_30 dq 1 

    enemy_move_time_31 dq 120
    enemy_direction_31 dq 1 

    enemy_move_time_32 dq 120
    enemy_direction_32 dq 1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    score dq 0
    score_msg db "__Score: ", 0
    score_msg_length equ $ - score_msg
    score_x_pos dq 85 
    score_y_pos dq 1  

    lifes_count dq 3
    lifes_msg db "Lifes: ", 0
    lifes_msg_length equ $ - lifes_msg


    score_active dq 0
    active_points dq 1
    score_active_2 dq 0
    active_points_2 dq 1
    score_active_3 dq 0
    active_points_3 dq 1
    score_active_4 dq 0
    active_points_4 dq 1
    score_active_5 dq 0
    active_points_5 dq 1
    score_active_6 dq 0
    active_points_6 dq 1
    score_active_7 dq 0
    active_points_7 dq 1
    score_active_8 dq 0
    active_points_8 dq 1
    score_active_9 dq 0
    active_points_9 dq 1
    score_active_10 dq 0
    active_points_10 dq 1
    score_active_11 dq 0
    active_points_11 dq 1
    score_active_12 dq 0
    active_points_12 dq 1
    score_active_13 dq 0
    active_points_13 dq 1
    score_active_14 dq 0
    active_points_14 dq 1
    score_active_15 dq 0
    active_points_15 dq 1
    score_active_16 dq 0
    active_points_16 dq 1

    score_active_17 dq 0
    active_points_17 dq 1
    score_active_18 dq 0
    active_points_18 dq 1
    score_active_19 dq 0
    active_points_19 dq 1
    score_active_20 dq 0
    active_points_20 dq 1
    score_active_21 dq 0
    active_points_21 dq 1
    score_active_22 dq 0
    active_points_22 dq 1
    score_active_23 dq 0
    active_points_23 dq 1
    score_active_24 dq 0
    active_points_24 dq 1
    score_active_25 dq 0
    active_points_25 dq 1
    score_active_26 dq 0
    active_points_26 dq 1
    score_active_27 dq 0
    active_points_27 dq 1
    score_active_28 dq 0
    active_points_28 dq 1
    score_active_29 dq 0
    active_points_29 dq 1
    score_active_30 dq 0
    active_points_30 dq 1
    score_active_31 dq 0
    active_points_31 dq 1
    score_active_32 dq 0
    active_points_32 dq 1

    timer_enemy dq 60

    timer_enemy_6 dq 60

    timer_enemy_11 dq 60

    timer_enemy_22 dq 60

    bomb_cycle_timer dq 10 ;
    bomb_cycle_timer_6 dq 10 ;
    bomb_cycle_timer_11 dq 10 ;
    bomb_cycle_timer_22 dq 10 ;


    bomb_timer dq 10

    bomb_y_pos_6: dq 1
    bomb_x_pos_6: dq 0 ; Posición X de la bomba

    bomb_y_pos: dq 1
    bomb_x_pos: dq 0 ; Posición X de la bomba

    bomb_y_pos_11: dq 1
    bomb_x_pos_11: dq 0 ; Posición X de la bomba

    bomb_y_pos_22: dq 1
    bomb_x_pos_22: dq 0 ; Posición X de la bomba

    bomb_active: dq 0 ; Estado de la bomba: 0 inactiva, 1 activa
    bomb_active_6: dq 0 ; Estado de la bomba: 0 inactiva, 1 activa
    bomb_active_11: dq 0 ; Estado de la bomba: 0 inactiva, 1 activa
    bomb_active_22: dq 0 ; Estado de la bomba: 0 inactiva, 1 activa
    bomb_act: dq 1
    ene1_act dq 1
    react dq 1

    active_lifes dq 1
    active_lifes_2 dq 1
    active_lifes_3 dq 1
    active_lifes_4 dq 1

    ban_level dq 1
    ban_level_2 dq 1
    ban_level_3 dq 1
    ban_level_4 dq 1
    ban_level_f dq 1
    prueba dq 1

    space_invaders_cmd db "./space_invaders", 0  
    space_invaders_argv dq 0                    
    space_invaders_envp dq 0   

    enemy_visibility_time dq 100  ; Temporizador para la visibilidad
    enemy_visible dq 1           ; 1 si es visible, 0 si no lo es

    enemy_move_time_0 dq 50
    enemy_direction_0 dq 1 

    enemy0_active: dq 1 

    enemy0_x_pos: dq 18
    enemy0_y_pos: dq 5                 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

section .bss
    score_str resb 20 
    lifes_str resb 20 

section .text

;    Function: print_pallet
; This function moves the pallet in the game
; Arguments: none
;
; Return;
;    void
print_pallet:
    mov r8, [pallet_position]
    mov rcx, [pallet_size]

.write_pallet:

    mov byte [r8 - 22], '#'
    mov byte [r8 + 20], '='
    inc r8
    dec rcx
    jnz .write_pallet

    sub r8, column_cells + 26
    mov byte [r8], 'A'
    dec rcx

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


print_enemy_0:
    mov r10, 0
    cmp [enemy0_active], r10
    je .no_active

    call move_enemies_0

    ; Verificar el estado de visibilidad
    mov r11, [enemy_visible]
    cmp r11, 1
    jne .no_active  ; No dibujar si no es visible

    ; Obtener la posición actual del enemigo
    mov r8, [enemy0_x_pos]
    mov r9, [enemy0_y_pos]

    ; Dibujar el enemigo en la nueva posición
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax

    mov byte [r8], '@'

.no_active:
    ret

toggle_enemy_visibility:
    mov r8, [enemy_visibility_time]
    dec r8
    mov [enemy_visibility_time], r8
    cmp r8, 0
    jne .no_toggle

    ; Alternar el estado de visibilidad
    mov r9, [enemy_visible]
    xor r9, 1  ; Cambiar entre 0 y 1
    mov [enemy_visible], r9

    ; Resetear el temporizador
    mov r8, 100
    mov [enemy_visibility_time], r8

.no_toggle:
    ret

move_enemies_0:
    mov r8, [enemy_move_time_0]
    dec r8
    mov [enemy_move_time_0], r8
    cmp r8, 40
    jne .no_move_enemy_0

    ; Borra la posición anterior del enemigo
    call delete_enemy_0

    mov r11, [enemy0_x_pos]
    mov r9, [enemy_direction_0]

    ; Si llega al borde derecho, cambia de dirección sin bajar una row
    cmp r11, 35
    jne .check_left_0

    mov r9, -1
    mov [enemy_direction_0], r9
    jmp .update_position_0

    ; al llegar al borde izquierdo, cambia de dirección
.check_left_0:
    cmp r11, 5
    jne .update_position_0

    mov r9, 1
    mov [enemy_direction_0], r9

.update_position_0:
    add r11, r9
    mov [enemy0_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_0], r8

.no_move_enemy_0:
    ret
delete_enemy_0:
    ; Obtener la posición del enemigo
    mov r9, [enemy0_y_pos]      
    mov rcx, [enemy0_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;    Function: print_enemy1
; This function draw the enemy1
; Arguments: none
;
; Return:
;    Void
print_enemy_1:

    mov r10, 0
    cmp [enemy1_active], r10
    je .no_active

    call move_enemies

    ; Obtener la posición actual del enemigo
    mov r8, [enemy1_x_pos]
    mov r9, [enemy1_y_pos]

    ; Dibujar el enemigo en la nueva posición
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'W'

.no_active:
    ret

move_enemies:
    mov r8, [enemy_move_time]
    dec r8
    mov [enemy_move_time], r8
    cmp r8, 20
    jne .no_move_enemy

    ; Borra la posición anterior del enemigo
    call delete_enemy

    mov r11, [enemy1_x_pos]
    mov r9, [enemy_direction]

    ;Si llega al borde derecho, cambia de dirección y baja una row
    cmp r11, 14
    jne .move_enemy

    add byte [enemy1_y_pos], 1
    mov r9, -1
    mov [enemy_direction], r9
    jmp .update_position

    ; al llegar al borde izquierdo, cambia de dirección
.move_enemy:
    cmp r11, 5
    jne .update_position

    mov r9, 1
    mov [enemy_direction], r9

.update_position:
    add r11, r9
    mov [enemy1_x_pos], r11
    mov r8, 60
    mov [enemy_move_time], r8

.no_move_enemy:
    ret

delete_enemy:

    ; Obtener la posición del enemigo
    mov r9, [enemy1_y_pos]      
    mov rcx, [enemy1_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_2: 

    mov r10, 0
    cmp [enemy2_active], r10
    je .no_active_2

    call move_enemies_2

    mov r8, [enemy2_x_pos]
    mov r9, [enemy2_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'W'

.no_active_2:
    ret

move_enemies_2:
    mov r8, [enemy_move_time_2]
    dec r8
    mov [enemy_move_time_2], r8
    cmp r8, 20
    jne .no_move_enemy_2

    call delete_enemy_2

    mov r11, [enemy2_x_pos]
    mov r9, [enemy_direction_2]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 17
    jne .move_enemy_2

    add byte [enemy2_y_pos], 1
    mov r9, -1
    mov [enemy_direction_2], r9
    jmp .update_position_2

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_2:
    cmp r11, 8
    jne .update_position_2

    mov r9, 1
    mov [enemy_direction_2], r9

.update_position_2:
    add r11, r9
    mov [enemy2_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_2], r8

.no_move_enemy_2:
    ret

delete_enemy_2:
    ; Obtener la posición del enemigo
    mov r9, [enemy2_y_pos]      
    mov rcx, [enemy2_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_3: 

    mov r10, 0
    cmp [enemy3_active], r10
    je .no_active_3

    call move_enemies_3

    mov r8, [enemy3_x_pos]
    mov r9, [enemy3_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'W'

.no_active_3:
    ret

move_enemies_3:
    mov r8, [enemy_move_time_3]
    dec r8
    mov [enemy_move_time_3], r8
    cmp r8, 20
    jne .no_move_enemy_3

    call delete_enemy_3

    mov r11, [enemy3_x_pos]
    mov r9, [enemy_direction_3]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 20
    jne .move_enemy_3

    add byte [enemy3_y_pos], 1
    mov r9, -1
    mov [enemy_direction_3], r9
    jmp .update_position_3

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_3:
    cmp r11, 11
    jne .update_position_3

    mov r9, 1
    mov [enemy_direction_3], r9

.update_position_3:
    add r11, r9
    mov [enemy3_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_3], r8

.no_move_enemy_3:
    ret

delete_enemy_3:
    ; Obtener la posición del enemigo
    mov r9, [enemy3_y_pos]      
    mov rcx, [enemy3_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_4: 

    mov r10, 0
    cmp [enemy4_active], r10
    je .no_active_4

    call move_enemies_4

    mov r8, [enemy4_x_pos]
    mov r9, [enemy4_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'W'

.no_active_4:
    ret

move_enemies_4:
    mov r8, [enemy_move_time_4]
    dec r8
    mov [enemy_move_time_4], r8
    cmp r8, 20
    jne .no_move_enemy_4

    call delete_enemy_4

    mov r11, [enemy4_x_pos]
    mov r9, [enemy_direction_4]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 23
    jne .move_enemy_4

    add byte [enemy4_y_pos], 1
    mov r9, -1
    mov [enemy_direction_4], r9
    jmp .update_position_4

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_4:
    cmp r11, 14
    jne .update_position_4

    mov r9, 1
    mov [enemy_direction_4], r9

.update_position_4:
    add r11, r9
    mov [enemy4_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_4], r8

.no_move_enemy_4:
    ret

delete_enemy_4:
    ; Obtener la posición del enemigo
    mov r9, [enemy4_y_pos]      
    mov rcx, [enemy4_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_5:

    mov r10, 0
    cmp [enemy5_active], r10
    je .no_active_5

    call move_enemies_5

    ; Obtener la posición actual del enemigo
    mov r8, [enemy5_x_pos]
    mov r9, [enemy5_y_pos]

    ; Dibujar el enemigo en la nueva posición
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'W'

.no_active_5:
    ret

move_enemies_5:
    mov r8, [enemy_move_time_5]
    dec r8
    mov [enemy_move_time_5], r8
    cmp r8, 20
    jne .no_move_enemy_5

    ; Borra la posición anterior del enemigo
    call delete_enemy_5

    mov r11, [enemy5_x_pos]
    mov r9, [enemy_direction_5]

    ;Si llega al borde derecho, cambia de dirección y baja una row
    cmp r11, 26
    jne .move_enemy_5

    add byte [enemy5_y_pos], 1
    mov r9, -1
    mov [enemy_direction_5], r9
    jmp .update_position_5

    ; al llegar al borde izquierdo, cambia de dirección
.move_enemy_5:
    cmp r11, 17
    jne .update_position_5

    mov r9, 1
    mov [enemy_direction_5], r9

.update_position_5:
    add r11, r9
    mov [enemy5_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_5], r8

.no_move_enemy_5:
    ret

delete_enemy_5:
    ; Obtener la posición del enemigo
    mov r9, [enemy5_y_pos]      
    mov rcx, [enemy5_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_6: 

    mov r10, 0
    cmp [enemy6_active], r10
    je .no_active_6

    call move_enemies_6

    mov r8, [enemy6_x_pos]
    mov r9, [enemy6_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'W'

.no_active_6:
    ret

move_enemies_6:
    mov r8, [enemy_move_time_6]
    dec r8
    mov [enemy_move_time_6], r8
    cmp r8, 20
    jne .no_move_enemy_6

    call delete_enemy_6

    mov r11, [enemy6_x_pos]
    mov r9, [enemy_direction_6]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 29
    jne .move_enemy_6

    add byte [enemy6_y_pos], 1
    mov r9, -1
    mov [enemy_direction_6], r9
    jmp .update_position_6

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_6:
    cmp r11, 20
    jne .update_position_6

    mov r9, 1
    mov [enemy_direction_6], r9

.update_position_6:
    add r11, r9
    mov [enemy6_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_6], r8

.no_move_enemy_6:
    ret

delete_enemy_6:
    ; Obtener la posición del enemigo
    mov r9, [enemy6_y_pos]      
    mov rcx, [enemy6_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_7: 

    mov r10, 0
    cmp [enemy7_active], r10
    je .no_active_7

    call move_enemies_7

    mov r8, [enemy7_x_pos]
    mov r9, [enemy7_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'W'

.no_active_7:
    ret

move_enemies_7:
    mov r8, [enemy_move_time_7]
    dec r8
    mov [enemy_move_time_7], r8
    cmp r8, 20
    jne .no_move_enemy_7

    call delete_enemy_7

    mov r11, [enemy7_x_pos]
    mov r9, [enemy_direction_7]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 32
    jne .move_enemy_7

    add byte [enemy7_y_pos], 1
    mov r9, -1
    mov [enemy_direction_7], r9
    jmp .update_position_7

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_7:
    cmp r11, 23
    jne .update_position_7

    mov r9, 1
    mov [enemy_direction_7], r9

.update_position_7:
    add r11, r9
    mov [enemy7_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_7], r8

.no_move_enemy_7:
    ret

delete_enemy_7:
    ; Obtener la posición del enemigo
    mov r9, [enemy7_y_pos]      
    mov rcx, [enemy7_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_8: 

    mov r10, 0
    cmp [enemy8_active], r10
    je .no_active_8

    call move_enemies_8

    mov r8, [enemy8_x_pos]
    mov r9, [enemy8_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'W'

.no_active_8:
    ret

move_enemies_8:
    mov r8, [enemy_move_time_8]
    dec r8
    mov [enemy_move_time_8], r8
    cmp r8, 20
    jne .no_move_enemy_8

    call delete_enemy_8

    mov r11, [enemy8_x_pos]
    mov r9, [enemy_direction_8]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 35
    jne .move_enemy_8

    add byte [enemy8_y_pos], 1
    mov r9, -1
    mov [enemy_direction_8], r9
    jmp .update_position_8

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_8:
    cmp r11, 26
    jne .update_position_8

    mov r9, 1
    mov [enemy_direction_8], r9

.update_position_8:
    add r11, r9
    mov [enemy8_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_8], r8

.no_move_enemy_8:
    ret

delete_enemy_8:
    ; Obtener la posición del enemigo
    mov r9, [enemy8_y_pos]      
    mov rcx, [enemy8_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;Segunda Fila 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_9:

    mov r10, 0
    cmp [enemy9_active], r10
    je .no_active_9

    call move_enemies_9

    ; Obtener la posición actual del enemigo
    mov r8, [enemy9_x_pos]
    mov r9, [enemy9_y_pos]

    ; Dibujar el enemigo en la nueva posición
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'H'

.no_active_9:
    ret

move_enemies_9:
    mov r8, [enemy_move_time_9]
    dec r8
    mov [enemy_move_time_9], r8
    cmp r8, 20
    jne .no_move_enemy_9

    ; Borra la posición anterior del enemigo
    call delete_enemy_9

    mov r11, [enemy9_x_pos]
    mov r9, [enemy_direction_9]

    ;Si llega al borde derecho, cambia de dirección y baja una row
    cmp r11, 14
    jne .move_enemy_9

    add byte [enemy9_y_pos], 1
    mov r9, -1
    mov [enemy_direction_9], r9
    jmp .update_position_9

    ; al llegar al borde izquierdo, cambia de dirección
.move_enemy_9:
    cmp r11, 5
    jne .update_position_9

    mov r9, 1
    mov [enemy_direction_9], r9

.update_position_9:
    add r11, r9
    mov [enemy9_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_9], r8

.no_move_enemy_9:
    ret

delete_enemy_9:

    ; Obtener la posición del enemigo
    mov r9, [enemy9_y_pos]      
    mov rcx, [enemy9_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_10: 

    mov r10, 0
    cmp [enemy10_active], r10
    je .no_active_10

    call move_enemies_10

    mov r8, [enemy10_x_pos]
    mov r9, [enemy10_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'H'

.no_active_10:
    ret

move_enemies_10:
    mov r8, [enemy_move_time_10]
    dec r8
    mov [enemy_move_time_10], r8
    cmp r8, 20
    jne .no_move_enemy_10

    call delete_enemy_10

    mov r11, [enemy10_x_pos]
    mov r9, [enemy_direction_10]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 17
    jne .move_enemy_10

    add byte [enemy10_y_pos], 1
    mov r9, -1
    mov [enemy_direction_10], r9
    jmp .update_position_10

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_10:
    cmp r11, 8
    jne .update_position_10

    mov r9, 1
    mov [enemy_direction_10], r9

.update_position_10:
    add r11, r9
    mov [enemy10_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_10], r8

.no_move_enemy_10:
    ret

delete_enemy_10:
    ; Obtener la posición del enemigo
    mov r9, [enemy10_y_pos]      
    mov rcx, [enemy10_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_enemy_11:
    mov r10, 0
    cmp [enemy11_active], r10
    je .no_active_11

    call move_enemies_11

    mov r8, [enemy11_x_pos]
    mov r9, [enemy11_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'H'

.no_active_11:
    ret

move_enemies_11:
    mov r8, [enemy_move_time_11]
    dec r8
    mov [enemy_move_time_11], r8
    cmp r8, 20
    jne .no_move_enemy_11

    call delete_enemy_11

    mov r11, [enemy11_x_pos]
    mov r9, [enemy_direction_11]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 20
    jne .move_enemy_11

    add byte [enemy11_y_pos], 1
    mov r9, -1
    mov [enemy_direction_11], r9
    jmp .update_position_11

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_11:
    cmp r11, 11
    jne .update_position_11

    mov r9, 1
    mov [enemy_direction_11], r9

.update_position_11:
    add r11, r9
    mov [enemy11_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_11], r8

.no_move_enemy_11:
    ret

delete_enemy_11:
    ; Obtener la posición del enemigo
    mov r9, [enemy11_y_pos]      
    mov rcx, [enemy11_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_12: 

    mov r10, 0
    cmp [enemy12_active], r10
    je .no_active_12

    call move_enemies_12

    mov r8, [enemy12_x_pos]
    mov r9, [enemy12_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'H'

.no_active_12:
    ret

move_enemies_12:
    mov r8, [enemy_move_time_12]
    dec r8
    mov [enemy_move_time_12], r8
    cmp r8, 20
    jne .no_move_enemy_12

    call delete_enemy_12

    mov r11, [enemy12_x_pos]
    mov r9, [enemy_direction_12]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 23
    jne .move_enemy_12

    add byte [enemy12_y_pos], 1
    mov r9, -1
    mov [enemy_direction_12], r9
    jmp .update_position_12

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_12:
    cmp r11, 14
    jne .update_position_12

    mov r9, 1
    mov [enemy_direction_12], r9

.update_position_12:
    add r11, r9
    mov [enemy12_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_12], r8

.no_move_enemy_12:
    ret

delete_enemy_12:
    ; Obtener la posición del enemigo
    mov r9, [enemy12_y_pos]      
    mov rcx, [enemy12_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_13:

    mov r10, 0
    cmp [enemy13_active], r10
    je .no_active_13

    call move_enemies_13

    ; Obtener la posición actual del enemigo
    mov r8, [enemy13_x_pos]
    mov r9, [enemy13_y_pos]

    ; Dibujar el enemigo en la nueva posición
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'H'

.no_active_13:
    ret

move_enemies_13:
    mov r8, [enemy_move_time_13]
    dec r8
    mov [enemy_move_time_13], r8
    cmp r8, 20
    jne .no_move_enemy_13

    ; Borra la posición anterior del enemigo
    call delete_enemy_13

    mov r11, [enemy13_x_pos]
    mov r9, [enemy_direction_13]

    ;Si llega al borde derecho, cambia de dirección y baja una row
    cmp r11, 26
    jne .move_enemy_13

    add byte [enemy13_y_pos], 1
    mov r9, -1
    mov [enemy_direction_13], r9
    jmp .update_position_13

    ; al llegar al borde izquierdo, cambia de dirección
.move_enemy_13:
    cmp r11, 17
    jne .update_position_13

    mov r9, 1
    mov [enemy_direction_13], r9

.update_position_13:
    add r11, r9
    mov [enemy13_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_13], r8

.no_move_enemy_13:
    ret

delete_enemy_13:
    ; Obtener la posición del enemigo
    mov r9, [enemy13_y_pos]      
    mov rcx, [enemy13_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_14: 

    mov r10, 0
    cmp [enemy14_active], r10
    je .no_active_14

    call move_enemies_14

    mov r8, [enemy14_x_pos]
    mov r9, [enemy14_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'H'

.no_active_14:
    ret

move_enemies_14:
    mov r8, [enemy_move_time_14]
    dec r8
    mov [enemy_move_time_14], r8
    cmp r8, 20
    jne .no_move_enemy_14

    call delete_enemy_14

    mov r11, [enemy14_x_pos]
    mov r9, [enemy_direction_14]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 29
    jne .move_enemy_14

    add byte [enemy14_y_pos], 1
    mov r9, -1
    mov [enemy_direction_14], r9
    jmp .update_position_14

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_14:
    cmp r11, 20
    jne .update_position_14

    mov r9, 1
    mov [enemy_direction_14], r9

.update_position_14:
    add r11, r9
    mov [enemy14_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_14], r8

.no_move_enemy_14:
    ret

delete_enemy_14:
    ; Obtener la posición del enemigo
    mov r9, [enemy14_y_pos]      
    mov rcx, [enemy14_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_15: 

    mov r10, 0
    cmp [enemy15_active], r10
    je .no_active_15

    call move_enemies_15

    mov r8, [enemy15_x_pos]
    mov r9, [enemy15_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'H'

.no_active_15:
    ret

move_enemies_15:
    mov r8, [enemy_move_time_15]
    dec r8
    mov [enemy_move_time_15], r8
    cmp r8, 20
    jne .no_move_enemy_15

    call delete_enemy_15

    mov r11, [enemy15_x_pos]
    mov r9, [enemy_direction_15]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 32
    jne .move_enemy_15

    add byte [enemy15_y_pos], 1
    mov r9, -1
    mov [enemy_direction_15], r9
    jmp .update_position_15

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_15:
    cmp r11, 23
    jne .update_position_15

    mov r9, 1
    mov [enemy_direction_15], r9

.update_position_15:
    add r11, r9
    mov [enemy15_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_15], r8

.no_move_enemy_15:
    ret

delete_enemy_15:
    ; Obtener la posición del enemigo
    mov r9, [enemy15_y_pos]      
    mov rcx, [enemy15_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_16: 

    mov r10, 0
    cmp [enemy16_active], r10
    je .no_active_16

    call move_enemies_16

    mov r8, [enemy16_x_pos]
    mov r9, [enemy16_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'H'

.no_active_16:
    ret

move_enemies_16:
    mov r8, [enemy_move_time_16]
    dec r8
    mov [enemy_move_time_16], r8
    cmp r8, 20
    jne .no_move_enemy_16

    call delete_enemy_16

    mov r11, [enemy16_x_pos]
    mov r9, [enemy_direction_16]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 35
    jne .move_enemy_16

    add byte [enemy16_y_pos], 1
    mov r9, -1
    mov [enemy_direction_16], r9
    jmp .update_position_16

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_16:
    cmp r11, 26
    jne .update_position_16

    mov r9, 1
    mov [enemy_direction_16], r9

.update_position_16:
    add r11, r9
    mov [enemy16_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_16], r8

.no_move_enemy_16:
    ret

delete_enemy_16:
    ; Obtener la posición del enemigo
    mov r9, [enemy16_y_pos]      
    mov rcx, [enemy16_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;Tercera Fila 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_17:

    mov r10, 0
    cmp [enemy17_active], r10
    je .no_active_17

    call move_enemies_17

    ; Obtener la posición actual del enemigo
    mov r8, [enemy17_x_pos]
    mov r9, [enemy17_y_pos]

    ; Dibujar el enemigo en la nueva posición
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'U'

.no_active_17:
    ret

move_enemies_17:
    mov r8, [enemy_move_time_17]
    dec r8
    mov [enemy_move_time_17], r8
    cmp r8, 20
    jne .no_move_enemy_17

    ; Borra la posición anterior del enemigo
    call delete_enemy_17

    mov r11, [enemy17_x_pos]
    mov r9, [enemy_direction_17]

    ;Si llega al borde derecho, cambia de dirección y baja una row
    cmp r11, 14
    jne .move_enemy_17

    add byte [enemy17_y_pos], 1
    mov r9, -1
    mov [enemy_direction_17], r9
    jmp .update_position_17

    ; al llegar al borde izquierdo, cambia de dirección
.move_enemy_17:
    cmp r11, 5
    jne .update_position_17

    mov r9, 1
    mov [enemy_direction_17], r9

.update_position_17:
    add r11, r9
    mov [enemy17_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_17], r8

.no_move_enemy_17:
    ret

delete_enemy_17:

    ; Obtener la posición del enemigo
    mov r9, [enemy17_y_pos]      
    mov rcx, [enemy17_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_18: 

    mov r10, 0
    cmp [enemy18_active], r10
    je .no_active_18

    call move_enemies_18

    mov r8, [enemy18_x_pos]
    mov r9, [enemy18_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'U'

.no_active_18:
    ret

move_enemies_18:
    mov r8, [enemy_move_time_18]
    dec r8
    mov [enemy_move_time_18], r8
    cmp r8, 20
    jne .no_move_enemy_18

    call delete_enemy_18

    mov r11, [enemy18_x_pos]
    mov r9, [enemy_direction_18]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 17
    jne .move_enemy_18

    add byte [enemy18_y_pos], 1
    mov r9, -1
    mov [enemy_direction_18], r9
    jmp .update_position_18

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_18:
    cmp r11, 8
    jne .update_position_18

    mov r9, 1
    mov [enemy_direction_18], r9

.update_position_18:
    add r11, r9
    mov [enemy18_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_18], r8

.no_move_enemy_18:
    ret

delete_enemy_18:
    ; Obtener la posición del enemigo
    mov r9, [enemy18_y_pos]      
    mov rcx, [enemy18_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_enemy_19:
    mov r10, 0
    cmp [enemy19_active], r10
    je .no_active_19

    call move_enemies_19

    mov r8, [enemy19_x_pos]
    mov r9, [enemy19_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'U'

.no_active_19:
    ret

move_enemies_19:
    mov r8, [enemy_move_time_19]
    dec r8
    mov [enemy_move_time_19], r8
    cmp r8, 20
    jne .no_move_enemy_19

    call delete_enemy_19

    mov r11, [enemy19_x_pos]
    mov r9, [enemy_direction_19]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 20
    jne .move_enemy_19

    add byte [enemy19_y_pos], 1
    mov r9, -1
    mov [enemy_direction_19], r9
    jmp .update_position_19

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_19:
    cmp r11, 11
    jne .update_position_19

    mov r9, 1
    mov [enemy_direction_19], r9

.update_position_19:
    add r11, r9
    mov [enemy19_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_19], r8

.no_move_enemy_19:
    ret

delete_enemy_19:
    ; Obtener la posición del enemigo
    mov r9, [enemy19_y_pos]      
    mov rcx, [enemy19_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_20: 

    mov r10, 0
    cmp [enemy20_active], r10
    je .no_active_20

    call move_enemies_20

    mov r8, [enemy20_x_pos]
    mov r9, [enemy20_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'U'

.no_active_20:
    ret

move_enemies_20:
    mov r8, [enemy_move_time_20]
    dec r8
    mov [enemy_move_time_20], r8
    cmp r8, 20
    jne .no_move_enemy_20

    call delete_enemy_20

    mov r11, [enemy20_x_pos]
    mov r9, [enemy_direction_20]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 23
    jne .move_enemy_20

    add byte [enemy20_y_pos], 1
    mov r9, -1
    mov [enemy_direction_20], r9
    jmp .update_position_20

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_20:
    cmp r11, 14
    jne .update_position_20

    mov r9, 1
    mov [enemy_direction_20], r9

.update_position_20:
    add r11, r9
    mov [enemy20_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_20], r8

.no_move_enemy_20:
    ret

delete_enemy_20:
    ; Obtener la posición del enemigo
    mov r9, [enemy20_y_pos]      
    mov rcx, [enemy20_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_21:

    mov r10, 0
    cmp [enemy21_active], r10
    je .no_active_21

    call move_enemies_21

    ; Obtener la posición actual del enemigo
    mov r8, [enemy21_x_pos]
    mov r9, [enemy21_y_pos]

    ; Dibujar el enemigo en la nueva posición
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'U'

.no_active_21:
    ret

move_enemies_21:
    mov r8, [enemy_move_time_21]
    dec r8
    mov [enemy_move_time_21], r8
    cmp r8, 20
    jne .no_move_enemy_21

    ; Borra la posición anterior del enemigo
    call delete_enemy_21

    mov r11, [enemy21_x_pos]
    mov r9, [enemy_direction_21]

    ;Si llega al borde derecho, cambia de dirección y baja una row
    cmp r11, 26
    jne .move_enemy_21

    add byte [enemy21_y_pos], 1
    mov r9, -1
    mov [enemy_direction_21], r9
    jmp .update_position_21

    ; al llegar al borde izquierdo, cambia de dirección
.move_enemy_21:
    cmp r11, 17
    jne .update_position_21

    mov r9, 1
    mov [enemy_direction_21], r9

.update_position_21:
    add r11, r9
    mov [enemy21_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_21], r8

.no_move_enemy_21:
    ret

delete_enemy_21:
    ; Obtener la posición del enemigo
    mov r9, [enemy21_y_pos]      
    mov rcx, [enemy21_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_22: 

    mov r10, 0
    cmp [enemy22_active], r10
    je .no_active_22

    call move_enemies_22

    mov r8, [enemy22_x_pos]
    mov r9, [enemy22_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'U'

.no_active_22:
    ret

move_enemies_22:
    mov r8, [enemy_move_time_22]
    dec r8
    mov [enemy_move_time_22], r8
    cmp r8, 20
    jne .no_move_enemy_22

    call delete_enemy_22

    mov r11, [enemy22_x_pos]
    mov r9, [enemy_direction_22]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 29
    jne .move_enemy_22

    add byte [enemy22_y_pos], 1
    mov r9, -1
    mov [enemy_direction_22], r9
    jmp .update_position_22

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_22:
    cmp r11, 20
    jne .update_position_22

    mov r9, 1
    mov [enemy_direction_22], r9

.update_position_22:
    add r11, r9
    mov [enemy22_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_22], r8

.no_move_enemy_22:
    ret

delete_enemy_22:
    ; Obtener la posición del enemigo
    mov r9, [enemy22_y_pos]      
    mov rcx, [enemy22_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_23: 

    mov r10, 0
    cmp [enemy23_active], r10
    je .no_active_23

    call move_enemies_23

    mov r8, [enemy23_x_pos]
    mov r9, [enemy23_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'U'

.no_active_23:
    ret

move_enemies_23:
    mov r8, [enemy_move_time_23]
    dec r8
    mov [enemy_move_time_23], r8
    cmp r8, 20
    jne .no_move_enemy_23

    call delete_enemy_23

    mov r11, [enemy23_x_pos]
    mov r9, [enemy_direction_23]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 32
    jne .move_enemy_23

    add byte [enemy23_y_pos], 1
    mov r9, -1
    mov [enemy_direction_23], r9
    jmp .update_position_23

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_23:
    cmp r11, 23
    jne .update_position_23

    mov r9, 1
    mov [enemy_direction_23], r9

.update_position_23:
    add r11, r9
    mov [enemy23_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_23], r8

.no_move_enemy_23:
    ret

delete_enemy_23:
    ; Obtener la posición del enemigo
    mov r9, [enemy23_y_pos]      
    mov rcx, [enemy23_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_24: 

    mov r10, 0
    cmp [enemy24_active], r10
    je .no_active_24

    call move_enemies_24

    mov r8, [enemy24_x_pos]
    mov r9, [enemy24_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'U'

.no_active_24:
    ret

move_enemies_24:
    mov r8, [enemy_move_time_24]
    dec r8
    mov [enemy_move_time_24], r8
    cmp r8, 20
    jne .no_move_enemy_24

    call delete_enemy_24

    mov r11, [enemy24_x_pos]
    mov r9, [enemy_direction_24]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 35
    jne .move_enemy_24

    add byte [enemy24_y_pos], 1
    mov r9, -1
    mov [enemy_direction_24], r9
    jmp .update_position_24

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_24:
    cmp r11, 26
    jne .update_position_24

    mov r9, 1
    mov [enemy_direction_24], r9

.update_position_24:
    add r11, r9
    mov [enemy24_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_24], r8

.no_move_enemy_24:
    ret

delete_enemy_24:
    ; Obtener la posición del enemigo
    mov r9, [enemy24_y_pos]      
    mov rcx, [enemy24_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                    ;cuarta Fila 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_25:

    mov r10, 0
    cmp [enemy25_active], r10
    je .no_active_25

    call move_enemies_25

    ; Obtener la posición actual del enemigo
    mov r8, [enemy25_x_pos]
    mov r9, [enemy25_y_pos]

    ; Dibujar el enemigo en la nueva posición
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'X'

.no_active_25:
    ret

move_enemies_25:
    mov r8, [enemy_move_time_25]
    dec r8
    mov [enemy_move_time_25], r8
    cmp r8, 20
    jne .no_move_enemy_25

    ; Borra la posición anterior del enemigo
    call delete_enemy_25

    mov r11, [enemy25_x_pos]
    mov r9, [enemy_direction_25]

    ;Si llega al borde derecho, cambia de dirección y baja una row
    cmp r11, 14
    jne .move_enemy_25

    add byte [enemy25_y_pos], 1
    mov r9, -1
    mov [enemy_direction_25], r9
    jmp .update_position_25

    ; al llegar al borde izquierdo, cambia de dirección
.move_enemy_25:
    cmp r11, 5
    jne .update_position_25

    mov r9, 1
    mov [enemy_direction_25], r9

.update_position_25:
    add r11, r9
    mov [enemy25_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_25], r8

.no_move_enemy_25:
    ret

delete_enemy_25:

    ; Obtener la posición del enemigo
    mov r9, [enemy25_y_pos]      
    mov rcx, [enemy25_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   

    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_26: 

    mov r10, 0
    cmp [enemy26_active], r10
    je .no_active_26

    call move_enemies_26

    mov r8, [enemy26_x_pos]
    mov r9, [enemy26_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'X'

.no_active_26:
    ret

move_enemies_26:
    mov r8, [enemy_move_time_26]
    dec r8
    mov [enemy_move_time_26], r8
    cmp r8, 20
    jne .no_move_enemy_26

    call delete_enemy_26

    mov r11, [enemy26_x_pos]
    mov r9, [enemy_direction_26]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 17
    jne .move_enemy_26

    add byte [enemy26_y_pos], 1
    mov r9, -1
    mov [enemy_direction_26], r9
    jmp .update_position_26

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_26:
    cmp r11, 8
    jne .update_position_26

    mov r9, 1
    mov [enemy_direction_26], r9

.update_position_26:
    add r11, r9
    mov [enemy26_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_26], r8

.no_move_enemy_26:
    ret

delete_enemy_26:
    ; Obtener la posición del enemigo
    mov r9, [enemy26_y_pos]      
    mov rcx, [enemy26_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_enemy_27:
    mov r10, 0
    cmp [enemy27_active], r10
    je .no_active_27

    call move_enemies_27

    mov r8, [enemy27_x_pos]
    mov r9, [enemy27_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'X'

.no_active_27:
    ret

move_enemies_27:
    mov r8, [enemy_move_time_27]
    dec r8
    mov [enemy_move_time_27], r8
    cmp r8, 20
    jne .no_move_enemy_27

    call delete_enemy_27

    mov r11, [enemy27_x_pos]
    mov r9, [enemy_direction_27]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 20
    jne .move_enemy_27

    add byte [enemy27_y_pos], 1
    mov r9, -1
    mov [enemy_direction_27], r9
    jmp .update_position_27

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_27:
    cmp r11, 11
    jne .update_position_27

    mov r9, 1
    mov [enemy_direction_27], r9

.update_position_27:
    add r11, r9
    mov [enemy27_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_27], r8

.no_move_enemy_27:
    ret

delete_enemy_27:
    ; Obtener la posición del enemigo
    mov r9, [enemy27_y_pos]      
    mov rcx, [enemy27_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_28: 

    mov r10, 0
    cmp [enemy28_active], r10
    je .no_active_28

    call move_enemies_28

    mov r8, [enemy28_x_pos]
    mov r9, [enemy28_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'X'

.no_active_28:
    ret

move_enemies_28:
    mov r8, [enemy_move_time_28]
    dec r8
    mov [enemy_move_time_28], r8
    cmp r8, 20
    jne .no_move_enemy_28

    call delete_enemy_28

    mov r11, [enemy28_x_pos]
    mov r9, [enemy_direction_28]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 23
    jne .move_enemy_28

    add byte [enemy28_y_pos], 1
    mov r9, -1
    mov [enemy_direction_28], r9
    jmp .update_position_28

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_28:
    cmp r11, 14
    jne .update_position_28

    mov r9, 1
    mov [enemy_direction_28], r9

.update_position_28:
    add r11, r9
    mov [enemy28_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_28], r8

.no_move_enemy_28:
    ret

delete_enemy_28:
    ; Obtener la posición del enemigo
    mov r9, [enemy28_y_pos]      
    mov rcx, [enemy28_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_29:

    mov r10, 0
    cmp [enemy29_active], r10
    je .no_active_29

    call move_enemies_29

    ; Obtener la posición actual del enemigo
    mov r8, [enemy29_x_pos]
    mov r9, [enemy29_y_pos]

    ; Dibujar el enemigo en la nueva posición
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'X'

.no_active_29:
    ret

move_enemies_29:
    mov r8, [enemy_move_time_29]
    dec r8
    mov [enemy_move_time_29], r8
    cmp r8, 20
    jne .no_move_enemy_29

    ; Borra la posición anterior del enemigo
    call delete_enemy_29

    mov r11, [enemy29_x_pos]
    mov r9, [enemy_direction_29]

    ;Si llega al borde derecho, cambia de dirección y baja una row
    cmp r11, 26
    jne .move_enemy_29

    add byte [enemy29_y_pos], 1
    mov r9, -1
    mov [enemy_direction_29], r9
    jmp .update_position_29

    ; al llegar al borde izquierdo, cambia de dirección
.move_enemy_29:
    cmp r11, 17
    jne .update_position_29

    mov r9, 1
    mov [enemy_direction_29], r9

.update_position_29:
    add r11, r9
    mov [enemy29_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_29], r8

.no_move_enemy_29:
    ret

delete_enemy_29:
    ; Obtener la posición del enemigo
    mov r9, [enemy29_y_pos]      
    mov rcx, [enemy29_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   

    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_30: 

    mov r10, 0
    cmp [enemy30_active], r10
    je .no_active_30

    call move_enemies_30

    mov r8, [enemy30_x_pos]
    mov r9, [enemy30_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'X'

.no_active_30:
    ret

move_enemies_30:
    mov r8, [enemy_move_time_30]
    dec r8
    mov [enemy_move_time_30], r8
    cmp r8, 20
    jne .no_move_enemy_30

    call delete_enemy_30

    mov r11, [enemy30_x_pos]
    mov r9, [enemy_direction_30]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 29
    jne .move_enemy_30

    add byte [enemy30_y_pos], 1
    mov r9, -1
    mov [enemy_direction_30], r9
    jmp .update_position_30

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_30:
    cmp r11, 20
    jne .update_position_30

    mov r9, 1
    mov [enemy_direction_30], r9

.update_position_30:
    add r11, r9
    mov [enemy30_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_30], r8

.no_move_enemy_30:
    ret

delete_enemy_30:
    ; Obtener la posición del enemigo
    mov r9, [enemy30_y_pos]      
    mov rcx, [enemy30_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_31: 

    mov r10, 0
    cmp [enemy31_active], r10
    je .no_active_31

    call move_enemies_31

    mov r8, [enemy31_x_pos]
    mov r9, [enemy31_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'X'

.no_active_31:
    ret

move_enemies_31:
    mov r8, [enemy_move_time_31]
    dec r8
    mov [enemy_move_time_31], r8
    cmp r8, 20
    jne .no_move_enemy_31

    call delete_enemy_31

    mov r11, [enemy31_x_pos]
    mov r9, [enemy_direction_31]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 32
    jne .move_enemy_31

    add byte [enemy31_y_pos], 1
    mov r9, -1
    mov [enemy_direction_31], r9
    jmp .update_position_31

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_31:
    cmp r11, 23
    jne .update_position_31

    mov r9, 1
    mov [enemy_direction_31], r9

.update_position_31:
    add r11, r9
    mov [enemy31_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_31], r8

.no_move_enemy_31:
    ret

delete_enemy_31:
    ; Obtener la posición del enemigo
    mov r9, [enemy31_y_pos]      
    mov rcx, [enemy31_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_enemy_32: 

    mov r10, 0
    cmp [enemy32_active], r10
    je .no_active_32

    call move_enemies_32

    mov r8, [enemy32_x_pos]
    mov r9, [enemy32_y_pos]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'X'

.no_active_32:
    ret

move_enemies_32:
    mov r8, [enemy_move_time_32]
    dec r8
    mov [enemy_move_time_32], r8
    cmp r8, 20
    jne .no_move_enemy_32

    call delete_enemy_32

    mov r11, [enemy32_x_pos]
    mov r9, [enemy_direction_32]

    ; Si llega al borde derecho, cambia de dirección y baja una línea
    cmp r11, 35
    jne .move_enemy_32

    add byte [enemy32_y_pos], 1
    mov r9, -1
    mov [enemy_direction_32], r9
    jmp .update_position_32

    ; Si llega al borde izquierdo, cambia de dirección
.move_enemy_32:
    cmp r11, 26
    jne .update_position_32

    mov r9, 1
    mov [enemy_direction_32], r9

.update_position_32:
    add r11, r9
    mov [enemy32_x_pos], r11
    mov r8, 60
    mov [enemy_move_time_32], r8

.no_move_enemy_32:
    ret

delete_enemy_32:
    ; Obtener la posición del enemigo
    mov r9, [enemy32_y_pos]      
    mov rcx, [enemy32_x_pos]     
    add rcx, board             

    ; Calcular la dirección final en memoria
    mov rax, column_cells + 2  
    imul rax, r9               
    add rcx, rax               
    mov byte [rcx], char_space   
    ret

print_wall_1: 

    mov r8, [wallx1]
    mov r9, [wally1]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_2: 

    mov r8, [wallx2]
    mov r9, [wally2]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_3: 

    mov r8, [wallx3]
    mov r9, [wally3]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_4: 

    mov r8, [wallx4]
    mov r9, [wally4]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_5: 

    mov r8, [wallx5]
    mov r9, [wally5]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_6: 

    mov r8, [wallx6]
    mov r9, [wally6]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_7: 

    mov r8, [wallx7]
    mov r9, [wally7]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_8: 

    mov r8, [wallx8]
    mov r9, [wally8]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_9: 

    mov r8, [wallx9]
    mov r9, [wally9]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_10: 

    mov r8, [wallx10]
    mov r9, [wally10]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_11: 

    mov r8, [wallx11]
    mov r9, [wally11]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_12: 

    mov r8, [wallx12]
    mov r9, [wally12]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_13: 

    mov r8, [wallx13]
    mov r9, [wally13]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_14: 

    mov r8, [wallx14]
    mov r9, [wally14]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_15: 

    mov r8, [wallx15]
    mov r9, [wally15]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_16: 

    mov r8, [wallx16]
    mov r9, [wally16]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_17: 

    mov r8, [wallx17]
    mov r9, [wally17]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_18: 

    mov r8, [wallx18]
    mov r9, [wally18]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_19: 

    mov r8, [wallx19]
    mov r9, [wally19]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret

print_wall_20: 

    mov r8, [wallx20]
    mov r9, [wally20]

    ; Dibujar el enemigo
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov byte [r8], 'M'

    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                 ; Funcion de disparo  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

update_shoot:

    mov r13, 0
    mov r11,[ball_active]
    cmp r11, r13
    je .reset_shoot_flag

    mov r8, [ball_y_pos]
    cmp r8, board + column_cells + 2
    jbe .reset


    mov r10, 0
    cmp [ene1_act], r10
    ;je .no_coli

    ;Collision con enemigo 1
    mov r14, [enemy1_x_pos]
    mov r9, [enemy1_y_pos]
    add r14, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r14, rax

    mov r11, [ball_y_pos]
    cmp r14, r11
    je .no_shoot
 
    ;Collision con enemigo 2
    mov r13, [enemy2_x_pos]
    mov r9, [enemy2_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_2

    ;Collision con enemigo 3
    mov r13, [enemy3_x_pos]
    mov r9, [enemy3_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_3

    ;Collision con enemigo 4
    mov r14, [enemy4_x_pos]
    mov r9, [enemy4_y_pos]
    add r14, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r14, rax

    mov r11, [ball_y_pos]
    cmp r14, r11
    je .no_shoot_4
    
    ;Collision con enemigo 5
    mov r13, [enemy5_x_pos]
    mov r9, [enemy5_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_5

    ;Collision con enemigo 6
    mov r13, [enemy6_x_pos]
    mov r9, [enemy6_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_6

    ;Collision con enemigo 7
    mov r13, [enemy7_x_pos]
    mov r9, [enemy7_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_7

    ;Collision con enemigo 8
    mov r13, [enemy8_x_pos]
    mov r9, [enemy8_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;segunda fila
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;Collision con enemigo 9
    mov r14, [enemy9_x_pos]
    mov r9, [enemy9_y_pos]
    add r14, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r14, rax

    mov r11, [ball_y_pos]
    cmp r14, r11
    je .no_shoot_9
    
    ;Collision con enemigo 10
    mov r13, [enemy10_x_pos]
    mov r9, [enemy10_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_10

    ;Collision con enemigo 11
    mov r13, [enemy11_x_pos]
    mov r9, [enemy11_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_11

    ;Collision con enemigo 12
    mov r14, [enemy12_x_pos]
    mov r9,  [enemy12_y_pos]
    add r14, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r14, rax

    mov r11, [ball_y_pos]
    cmp r14, r11
    je .no_shoot_12
    
    ;Collision con enemigo 13
    mov r13, [enemy13_x_pos]
    mov r9, [enemy13_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_13

    ;Collision con enemigo 14
    mov r13, [enemy14_x_pos]
    mov r9, [enemy14_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_14

    ;Collision con enemigo 15
    mov r13, [enemy15_x_pos]
    mov r9, [enemy15_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_15

    ;Collision con enemigo 16
    mov r13, [enemy16_x_pos]
    mov r9, [enemy16_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_16
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;Tercer fila
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;Collision con enemigo 17
    mov r14, [enemy17_x_pos]
    mov r9, [enemy17_y_pos]
    add r14, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r14, rax

    mov r11, [ball_y_pos]
    cmp r14, r11
    je .no_shoot_17
    
    ;Collision con enemigo 18
    mov r13, [enemy18_x_pos]
    mov r9, [enemy18_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_18

    ;Collision con enemigo 19
    mov r13, [enemy19_x_pos]
    mov r9, [enemy19_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_19

    ;Collision con enemigo 20
    mov r14, [enemy20_x_pos]
    mov r9,  [enemy20_y_pos]
    add r14, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r14, rax

    mov r11, [ball_y_pos]
    cmp r14, r11
    je .no_shoot_20
    
    ;Collision con enemigo 21
    mov r13, [enemy21_x_pos]
    mov r9, [enemy21_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_21

    ;Collision con enemigo 22
    mov r13, [enemy22_x_pos]
    mov r9, [enemy22_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_22

    ;Collision con enemigo 23
    mov r13, [enemy23_x_pos]
    mov r9, [enemy23_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_23

    ;Collision con enemigo 24
    mov r13, [enemy24_x_pos]
    mov r9, [enemy24_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_24
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;Cuarta fila
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;Collision con enemigo 25
    mov r14, [enemy25_x_pos]
    mov r9, [enemy25_y_pos]
    add r14, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r14, rax

    mov r11, [ball_y_pos]
    cmp r14, r11
    je .no_shoot_25
    
    ;Collision con enemigo 26
    mov r13, [enemy26_x_pos]
    mov r9, [enemy26_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_26

    ;Collision con enemigo 27
    mov r13, [enemy27_x_pos]
    mov r9, [enemy27_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_27

    ;Collision con enemigo 28
    mov r14, [enemy28_x_pos]
    mov r9,  [enemy28_y_pos]
    add r14, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r14, rax

    mov r11, [ball_y_pos]
    cmp r14, r11
    je .no_shoot_28
    
    ;Collision con enemigo 29
    mov r13, [enemy29_x_pos]
    mov r9, [enemy29_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_29

    ;Collision con enemigo 30
    mov r13, [enemy30_x_pos]
    mov r9, [enemy30_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_30

    ;Collision con enemigo 31
    mov r13, [enemy31_x_pos]
    mov r9, [enemy31_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_31

    ;Collision con enemigo 32
    mov r13, [enemy32_x_pos]
    mov r9, [enemy32_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_32
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov r13, [wallx1]
    mov r12, [wally1]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_1

    mov r13, [wallx2]
    mov r12, [wally2]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_2

    mov r13, [wallx3]
    mov r12, [wally3]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_3

    mov r13, [wallx4]
    mov r12, [wally4]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_4

    mov r13, [wallx5]
    mov r12, [wally5]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_5

    mov r13, [wallx6]
    mov r12, [wally16]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_6

    mov r13, [wallx7]
    mov r12, [wally7]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_7

    mov r13, [wallx8]
    mov r12, [wally8]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_8

    mov r13, [wallx9]
    mov r12, [wally9]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_9

    mov r13, [wallx10]
    mov r12, [wally10]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_10

    mov r13, [wallx11]
    mov r12, [wally11]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_11

    mov r13, [wallx12]
    mov r12, [wally12]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_12

    mov r13, [wallx13]
    mov r12, [wally13]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_13

    mov r13, [wallx14]
    mov r12, [wally14]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_14

    mov r13, [wallx15]
    mov r12, [wally15]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_15

    mov r13, [wallx16]
    mov r12, [wally16]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_16

    mov r13, [wallx17]
    mov r12, [wally17]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_17

    mov r13, [wallx18]
    mov r12, [wally18]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_18

    mov r13, [wallx19]
    mov r12, [wally19]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_19

    mov r13, [wallx20]
    mov r12, [wally20]
    add r13, board
    mov rcx, r12
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    ;je .no_wall_20

    ;Collision con enemigo 0
    mov r13, [enemy0_x_pos]
    mov r9, [enemy0_y_pos]
    add r13, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r13, rax

    mov r11, [ball_y_pos]
    cmp r13, r11
    je .no_shoot_0

    ; Mover la bala hacia arriba
    sub r8, column_cells + 2
    mov [ball_y_pos], r8

    ;Borrar posicion anterior y dibujar la siguiente
    mov byte [r8 + column_cells + 2], char_space
    mov byte [r8], '*'
    ret

.reset_shoot_flag:

    ret

.reset:
    mov r12, 0
    mov [one_active], r12   ; Desactivar la bala
    ret

.no_shoot: 
    mov r12, 1
    mov [score_active], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy1_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret

.no_shoot_2:
    mov r12, 1
    mov [score_active_2], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy2_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_3:
    mov r12, 1
    mov [score_active_3], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy3_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret
.no_shoot_4:
    mov r12, 1
    mov [score_active_4], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy4_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret

.no_shoot_5:
    mov r12, 1
    mov [score_active_5], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy5_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_6:
    mov r12, 1
    mov [score_active_6], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy6_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret
.no_shoot_7:
    mov r12, 1
    mov [score_active_7], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy7_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_8:
    mov r12, 1
    mov [score_active_8], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy8_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret  
.no_shoot_9:
    mov r12, 1
    mov [score_active_9], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy9_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret

.no_shoot_10:
    mov r12, 1
    mov [score_active_10], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy10_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_11:
    mov r12, 1
    mov [score_active_11], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy11_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret
.no_shoot_12:
    mov r12, 1
    mov [score_active_12], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy12_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret

.no_shoot_13:
    mov r12, 1
    mov [score_active_13], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy13_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_14:
    mov r12, 1
    mov [score_active_14], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy14_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret
.no_shoot_15:
    mov r12, 1
    mov [score_active_15], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy15_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_16:
    mov r12, 1
    mov [score_active_16], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy16_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret  
.no_shoot_17:
    mov r12, 1
    mov [score_active_17], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy17_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret

.no_shoot_18:
    mov r12, 1
    mov [score_active_18], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy18_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_19:
    mov r12, 1
    mov [score_active_19], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy19_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret
.no_shoot_20:
    mov r12, 1
    mov [score_active_20], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy20_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret

.no_shoot_21:
    mov r12, 1
    mov [score_active_21], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy21_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_22:
    mov r12, 1
    mov [score_active_22], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy22_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret
.no_shoot_23:
    mov r12, 1
    mov [score_active_23], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy23_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_24:
    mov r12, 1
    mov [score_active_24], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy24_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret 
.no_shoot_25:
    mov r12, 1
    mov [score_active_25], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy25_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret

.no_shoot_26:
    mov r12, 1
    mov [score_active_26], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy26_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_27:
    mov r12, 1
    mov [score_active_27], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy27_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret
.no_shoot_28:
    mov r12, 1
    mov [score_active_28], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy28_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret

.no_shoot_29:
    mov r12, 1
    mov [score_active_29], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy29_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_30:
    mov r12, 1
    mov [score_active_30], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy30_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret

.no_shoot_31:
    mov r12, 1
    mov [score_active_31], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy31_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space

    ret
.no_shoot_32:
    mov r12, 1
    mov [score_active_32], r12  ; Activa el puntaje
    mov r11, 0
    mov [enemy32_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret

    .no_wall_1:

        mov r11, 0
        mov [one_active], r11
        ;Borrar el enemigo 
        mov byte [r8], char_space
        ret 

    .no_wall_2:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_3:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_4:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_5:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 


    .no_wall_6:

        mov r11, 0
        mov [one_active], r11
        ;Borrar el enemigo 
        mov byte [r8], char_space
        ret 

    .no_wall_7:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_8:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_9:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_10:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_11:

        mov r11, 0
        mov [one_active], r11
        ;Borrar el enemigo 
        mov byte [r8], char_space
        ret 

    .no_wall_12:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_13:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_14:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_15:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_16:

        mov r11, 0
        mov [one_active], r11
        ;Borrar el enemigo 
        mov byte [r8], char_space
        ret 

    .no_wall_17:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_18:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_19:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret 

    .no_wall_20:

        mov r11, 0
        mov [one_active], r11
        mov byte [r8], char_space
        ret  
.no_shoot_0:
    mov r11, 0
    mov [enemy0_active], r11
    mov r11, 0
    mov [one_active], r11
    ;Borrar el enemigo 
    mov byte [r8], char_space
    ret   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
draw_shoot:

    mov r13, 1
    cmp [one_active], r13
    je .already_shooting

    mov r8, [pallet_position]
    sub r8, 21  
    mov [ball_y_pos], r8 

    mov r11, 1
    mov [one_active], r11

.already_shooting:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                     ;Funciones del puntaje
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

score_sum:
    mov r11, 1
    cmp [score_active], r11
    jne .no_score
    mov r10, 1
    cmp [active_points], r10
    jne .no_points
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points], r13
    ret
.no_score:
    ret
.no_points:
    ret

score_sum_2:
    mov r11, 1
    cmp [score_active_2], r11
    jne .no_score_2
    mov r10, 1
    cmp [active_points_2], r10
    jne .no_points_2
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_2], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_2], r13
    ret
.no_score_2:
    ret
.no_points_2:
    ret

score_sum_3:
    mov r11, 1
    cmp [score_active_3], r11
    jne .no_score_3
    mov r10, 1
    cmp [active_points_3], r10
    jne .no_points_3
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_3], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_3], r13
    ret
.no_score_3:
    ret
.no_points_3:
    ret

score_sum_4:
    mov r11, 1
    cmp [score_active_4], r11
    jne .no_score_4
    mov r10, 1
    cmp [active_points_4], r10
    jne .no_points_4
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_4], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_4], r13
    ret
.no_score_4:
    ret
.no_points_4:
    ret

score_sum_5:
    mov r11, 1
    cmp [score_active_5], r11
    jne .no_score_5
    mov r10, 1
    cmp [active_points_5], r10
    jne .no_points_5
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_5], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_5], r13
    ret
.no_score_5:
    ret
.no_points_5:
    ret

score_sum_6:
    mov r11, 1
    cmp [score_active_6], r11
    jne .no_score_6
    mov r10, 1
    cmp [active_points_6], r10
    jne .no_points_6
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_6], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_6], r13
    ret
.no_score_6:
    ret
.no_points_6:
    ret

score_sum_7:
    mov r11, 1
    cmp [score_active_7], r11
    jne .no_score_7
    mov r10, 1
    cmp [active_points_7], r10
    jne .no_points_7
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_7], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_7], r13
    ret
.no_score_7:
    ret
.no_points_7:
    ret

score_sum_8:
    mov r11, 1
    cmp [score_active_8], r11
    jne .no_score_8
    mov r10, 1
    cmp [active_points_8], r10
    jne .no_points_8
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_8], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_8], r13
    ret
.no_score_8:
    ret
.no_points_8:
    ret

score_sum_9:
    mov r11, 1
    cmp [score_active_9], r11
    jne .no_score_9
    mov r10, 1
    cmp [active_points_9], r10
    jne .no_points_9
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_9], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_9], r13
    ret
.no_score_9:
    ret
.no_points_9:
    ret

score_sum_10:
    mov r11, 1
    cmp [score_active_10], r11
    jne .no_score_10
    mov r10, 1
    cmp [active_points_10], r10
    jne .no_points_10
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_10], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_10], r13
    ret
.no_score_10:
    ret
.no_points_10:
    ret

score_sum_11:
    mov r11, 1
    cmp [score_active_11], r11
    jne .no_score_11
    mov r10, 1
    cmp [active_points_11], r10
    jne .no_points_11
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_11], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_11], r13
    ret
.no_score_11:
    ret
.no_points_11:
    ret

score_sum_12:
    mov r11, 1
    cmp [score_active_12], r11
    jne .no_score_12
    mov r10, 1
    cmp [active_points_12], r10
    jne .no_points_12
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_12], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_12], r13
    ret
.no_score_12:
    ret
.no_points_12:
    ret

score_sum_13:
    mov r11, 1
    cmp [score_active_13], r11
    jne .no_score_13
    mov r10, 1
    cmp [active_points_13], r10
    jne .no_points_13
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_13], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_13], r13
    ret
.no_score_13:
    ret
.no_points_13:
    ret

score_sum_14:
    mov r11, 1
    cmp [score_active_14], r11
    jne .no_score_14
    mov r10, 1
    cmp [active_points_14], r10
    jne .no_points_14
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_14], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_14], r13
    ret
.no_score_14:
    ret
.no_points_14:
    ret

score_sum_15:
    mov r11, 1
    cmp [score_active_15], r11
    jne .no_score_15
    mov r10, 1
    cmp [active_points_15], r10
    jne .no_points_15
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_15], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_15], r13
    ret
.no_score_15:
    ret
.no_points_15:
    ret

score_sum_16:
    mov r11, 1
    cmp [score_active_16], r11
    jne .no_score_16
    mov r10, 1
    cmp [active_points_16], r10
    jne .no_points_16
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_16], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_16], r13
    ret
.no_score_16:
    ret
.no_points_16:
    ret

score_sum_17:
    mov r11, 1
    cmp [score_active_17], r11
    jne .no_score_17
    mov r10, 1
    cmp [active_points_17], r10
    jne .no_points_17
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_17], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_17], r13
    ret
.no_score_17:
    ret
.no_points_17:
    ret

score_sum_18:
    mov r11, 1
    cmp [score_active_18], r11
    jne .no_score_18
    mov r10, 1
    cmp [active_points_18], r10
    jne .no_points_18
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_18], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_18], r13
    ret
.no_score_18:
    ret
.no_points_18:
    ret

score_sum_19:
    mov r11, 1
    cmp [score_active_19], r11
    jne .no_score_19
    mov r10, 1
    cmp [active_points_19], r10
    jne .no_points_19
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_19], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_19], r13
    ret
.no_score_19:
    ret
.no_points_19:
    ret

score_sum_20:
    mov r11, 1
    cmp [score_active_20], r11
    jne .no_score_20
    mov r10, 1
    cmp [active_points_20], r10
    jne .no_points_20
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_20], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_20], r13
    ret
.no_score_20:
    ret
.no_points_20:
    ret

score_sum_21:
    mov r11, 1
    cmp [score_active_21], r11
    jne .no_score_21
    mov r10, 1
    cmp [active_points_21], r10
    jne .no_points_21
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_21], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_21], r13
    ret
.no_score_21:
    ret
.no_points_21:
    ret

score_sum_22:
    mov r11, 1
    cmp [score_active_22], r11
    jne .no_score_22
    mov r10, 1
    cmp [active_points_22], r10
    jne .no_points_22
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_22], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_22], r13
    ret
.no_score_22:
    ret
.no_points_22:
    ret

score_sum_23:
    mov r11, 1
    cmp [score_active_23], r11
    jne .no_score_23
    mov r10, 1
    cmp [active_points_23], r10
    jne .no_points_23
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_23], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_23], r13
    ret
.no_score_23:
    ret
.no_points_23:
    ret

score_sum_24:
    mov r11, 1
    cmp [score_active_24], r11
    jne .no_score_24
    mov r10, 1
    cmp [active_points_24], r10
    jne .no_points_24
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_24], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_24], r13
    ret
.no_score_24:
    ret
.no_points_24:
    ret

score_sum_25:
    mov r11, 1
    cmp [score_active_25], r11
    jne .no_score_25
    mov r10, 1
    cmp [active_points_25], r10
    jne .no_points_25
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_25], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_25], r13
    ret
.no_score_25:
    ret
.no_points_25:
    ret

score_sum_26:
    mov r11, 1
    cmp [score_active_26], r11
    jne .no_score_26
    mov r10, 1
    cmp [active_points_26], r10
    jne .no_points_26
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_26], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_26], r13
    ret
.no_score_26:
    ret
.no_points_26:
    ret

score_sum_27:
    mov r11, 1
    cmp [score_active_27], r11
    jne .no_score_27
    mov r10, 1
    cmp [active_points_27], r10
    jne .no_points_27
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_27], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_27], r13
    ret
.no_score_27:
    ret
.no_points_27:
    ret

score_sum_28:
    mov r11, 1
    cmp [score_active_28], r11
    jne .no_score_28
    mov r10, 1
    cmp [active_points_28], r10
    jne .no_points_28
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_28], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_28], r13
    ret
.no_score_28:
    ret
.no_points_28:
    ret

score_sum_29:
    mov r11, 1
    cmp [score_active_29], r11
    jne .no_score_29
    mov r10, 1
    cmp [active_points_29], r10
    jne .no_points_29
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_29], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_29], r13
    ret
.no_score_29:
    ret
.no_points_29:
    ret

score_sum_30:
    mov r11, 1
    cmp [score_active_30], r11
    jne .no_score_30
    mov r10, 1
    cmp [active_points_30], r10
    jne .no_points_30
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_30], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_30], r13
    ret
.no_score_30:
    ret
.no_points_30:
    ret

score_sum_31:
    mov r11, 1
    cmp [score_active_31], r11
    jne .no_score_31
    mov r10, 1
    cmp [active_points_31], r10
    jne .no_points_31
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_31], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_31], r13
    ret
.no_score_31:
    ret
.no_points_31:
    ret

score_sum_32:
    mov r11, 1
    cmp [score_active_32], r11
    jne .no_score_32
    mov r10, 1
    cmp [active_points_32], r10
    jne .no_points_32
    mov rax, [score]
    add rax,10
    mov [score], rax
    mov r12, 0
    mov [score_active_32], r12  ; Resetea score_active después de incrementar el puntaje
    mov r13, 0
    mov [active_points_32], r13
    ret
.no_score_32:
    ret
.no_points_32:
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

display_score:
    ; Convierte el puntaje a una cadena de texto
    mov rax, [score]
    mov rdi, score_str
    call int_to_str

    ; Calcula la posición para imprimir el puntaje
    mov r8, [score_x_pos]
    mov r9, [score_y_pos]

    ; Muestra "Puntaje: "
    print score_msg, score_msg_length

    ; Muestra el valor del puntaje
    print score_str, 20
    ret

int_to_str:
    ; RDI = dirección donde almacenar la cadena
    ; RAX = entero que convertir
    xor rcx, rcx          ; contador de dígitos
    mov rbx, 10           ; divisor para obtener los dígitos

.convert:
    xor rdx, rdx          ; limpia el valor en RDX
    div rbx               ; divide RAX entre 10, RAX = cociente, RDX = residuo
    add dl, '0'           ; convierte el residuo en un carácter
    push rdx              ; guarda el carácter en la pila
    inc rcx               ; incrementa el contador de dígitos
    test rax, rax         ; verifica si RAX es 0
    jnz .convert          ; si no es 0, repite

.output:
    pop rdx               ; recupera el carácter de la pila
    mov [rdi], dl         ; almacena el carácter en la cadena
    inc rdi               ; mueve el puntero al siguiente carácter
    loop .output          ; repite para todos los dígitos

    mov byte [rdi], 0     ; termina la cadena con un carácter nulo
    ret

; Function: check_collision
; This function checks if the enemy has collided with the pallet
; Arguments: none
;
; Return:
;    void
check_collision:
    ;Collision con enemigo 1
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    mov r14, [enemy1_x_pos]
    mov r9, [enemy1_y_pos]
    add r14, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r14, rax

    sub r10, column_cells + 2

    cmp r14, r10
    jb .no_collision
    add r10, rcx
    cmp r14, r10
    jb .collision ; Si hay colisión

.no_collision:
    ret

.collision:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_2:
    ;Collision with enemy 2
    mov r11, [pallet_position]
    mov rcx, [pallet_size]
    mov r15, [enemy2_x_pos]
    mov r13, [enemy2_y_pos]
    add r15, board
    mov rcx, r13
    mov rax, column_cells + 2
    imul rcx
    add r15, rax 
    sub r11, column_cells + 2 ; En la fila de la pallet
    cmp r15, r11
    jb .no_collision_2
    add r11, rcx
    cmp r15, r11
    jb .collision_2 ; Si hay colisión
.no_collision_2:
    ret

.collision_2:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_3:
    ;Collision with enemy 3
    mov r8, [enemy3_x_pos]
    mov r9, [enemy3_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    cmp r8, r10
    jb .no_collision_3
    add r10, rcx
    cmp r8, r10
    jb .collision_3 ; Si hay colisión

.no_collision_3:
    ret

.collision_3:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_4:
    ;Collision with enemy 4
    mov r8, [enemy4_x_pos]
    mov r9, [enemy4_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet    
    cmp r8, r10
    jb .no_collision_4
    add r10, rcx
    cmp r8, r10
    jb .collision_4 ; Si hay colisión
.no_collision_4:
    ret

.collision_4:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_5:
    ;Collision with enemy 5
    mov r8, [enemy5_x_pos]
    mov r9, [enemy5_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    cmp r8, r10
    jb .no_collision_5
    add r10, rcx
    cmp r8, r10
    jb .collision_5 ; Si hay colisión
.no_collision_5:
    ret

.collision_5:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_6:
    ;Collision with enemy 6
    mov r8, [enemy6_x_pos]
    mov r9, [enemy6_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    cmp r8, r10
    jb .no_collision_6
    add r10, rcx
    cmp r8, r10
    jb .collision_6; Si hay colisión
.no_collision_6:
    ret

.collision_6:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_7:
    ;Collision with enemy 7
    mov r8, [enemy7_x_pos]
    mov r9, [enemy7_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    cmp r8, r10
    jb .no_collision_7
    add r10, rcx
    cmp r8, r10
    jb .collision_7 ; Si hay colisión
.no_collision_7:
    ret

.collision_7:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_8:
    ;Collision with enemy 8
    mov r8, [enemy8_x_pos]
    mov r9, [enemy8_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    cmp r8, r10
    jb .no_collision_8
    add r10, rcx
    cmp r8, r10
    jb .collision_8 ; Si hay colisión
.no_collision_8:
    ret

.collision_8:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_9:
    ;Collision with enemy 9
    mov r8, [enemy9_x_pos]
    mov r9, [enemy9_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    cmp r8, r10
    jb .no_collision_9
    add r10, rcx
    cmp r8, r10
    jb .collision_9 ; Si hay colisión
.no_collision_9:
    ret

.collision_9:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_10:
    ;Collision with enemy 10
    mov r8, [enemy10_x_pos]
    mov r9, [enemy10_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    cmp r8, r10
    jb .no_collision_10
    add r10, rcx
    cmp r8, r10
    jb .collision_10 ; Si hay colisión
.no_collision_10:
    ret

.collision_10:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_11:
    ;Collision with enemy 11
    mov r8, [enemy11_x_pos]
    mov r9, [enemy11_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    cmp r8, r10
    jb .no_collision_11
    add r10, rcx
    cmp r8, r10
    jb .collision_11 ; Si hay colisión
.no_collision_11:
    ret

.collision_11:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_12:
    ;Collision with enemy 12
    mov r8, [enemy12_x_pos]
    mov r9, [enemy12_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    
    cmp r8, r10
    jb .no_collision_12
    add r10, rcx
    cmp r8, r10
    jb .collision_12 ; Si hay colisión
.no_collision_12:
    ret

.collision_12:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_13:
    ;Collision with enemy 13
    mov r8, [enemy13_x_pos]
    mov r9, [enemy13_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
   
    cmp r8, r10
    jb .no_collision_13
    add r10, rcx
    cmp r8, r10
    jb .collision_13 ; Si hay colisión
.no_collision_13:
    ret

.collision_13:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_14:
    ;Collision with enemy 14
    mov r8, [enemy14_x_pos]
    mov r9, [enemy14_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
   
    cmp r8, r10
    jb .no_collision_14
    add r10, rcx
    cmp r8, r10
    jb .collision_14 ; Si hay colisión 
.no_collision_14:
    ret

.collision_14:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_15:
    ;Collision with enemy 15
    mov r8, [enemy15_x_pos]
    mov r9, [enemy15_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
   
    cmp r8, r10
    jb .no_collision_15
    add r10, rcx
    cmp r8, r10
    jb .collision_15 ; Si hay colisión
.no_collision_15:
    ret

.collision_15:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_16:
    ;Collision with enemy 16
    mov r8, [enemy16_x_pos]
    mov r9, [enemy16_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    
    cmp r8, r10
    jb .no_collision_16
    add r10, rcx
    cmp r8, r10
    jb .collision_16 ; Si hay colisión
.no_collision_16:
    ret

.collision_16:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_17:
    ;Collision with enemy 17
    mov r8, [enemy17_x_pos]
    mov r9, [enemy17_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet
    cmp r8, r10
    jb .no_collision_17
    add r10, rcx
    cmp r8, r10
    jb .collision_17 ; Si hay colisión
.no_collision_17:
    ret

.collision_17:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_18:
    ;Collision with enemy 18
    mov r8, [enemy18_x_pos]
    mov r9, [enemy18_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet  
    cmp r8, r10
    jb .no_collision_18
    add r10, rcx
    cmp r8, r10
    jb .collision_18 ; Si hay colisión
.no_collision_18:
    ret

.collision_18:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_19:
    ;Collision with enemy 19
    mov r8, [enemy19_x_pos]
    mov r9, [enemy19_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet   
    cmp r8, r10
    jb .no_collision_19
    add r10, rcx
    cmp r8, r10
    jb .collision_19 ; Si hay colisión
.no_collision_19:
    ret

.collision_19:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_20:
    ;Collision with enemy 20
    mov r8, [enemy20_x_pos]
    mov r9, [enemy20_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet   
    cmp r8, r10
    jb .no_collision_20
    add r10, rcx
    cmp r8, r10
    jb .collision_20; Si hay colisión
.no_collision_20:
    ret

.collision_20:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_21:
    ;Collision with enemy 21
    mov r8, [enemy21_x_pos]
    mov r9, [enemy21_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet   
    cmp r8, r10
    jb .no_collision_21
    add r10, rcx
    cmp r8, r10
    jb .collision_21; Si hay colisión
.no_collision_21:
    ret

.collision_21:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_22:
    ;Collision with enemy 22
    mov r8, [enemy22_x_pos]
    mov r9, [enemy22_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet   
    cmp r8, r10
    jb .no_collision_22
    add r10, rcx
    cmp r8, r10
    jb .collision_22 ; Si hay colisión
.no_collision_22:
    ret

.collision_22:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_23:
    ;Collision with enemy 23
    mov r8, [enemy23_x_pos]
    mov r9, [enemy23_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet  
    cmp r8, r10
    jb .no_collision_23
    add r10, rcx
    cmp r8, r10
    jb .collision_23 ; Si hay colisión
.no_collision_23:
    ret

.collision_23:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_24:
    ;Collision with enemy 24
    mov r8, [enemy24_x_pos]
    mov r9, [enemy24_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet    
    cmp r8, r10
    jb .no_collision_24
    add r10, rcx
    cmp r8, r10
    jb .collision_24 ; Si hay colisión
.no_collision_24:
    ret

.collision_24:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_25:
    ;Collision with enemy 25
    mov r8, [enemy25_x_pos]
    mov r9, [enemy25_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet   
    cmp r8, r10
    jb .no_collision_25
    add r10, rcx
    cmp r8, r10
    jb .collision_25 ; Si hay colisión
.no_collision_25:
    ret

.collision_25:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_26:
     ;Collision with enemy 26
    mov r8, [enemy26_x_pos]
    mov r9, [enemy26_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet    
    cmp r8, r10
    jb .no_collision_26
    add r10, rcx
    cmp r8, r10
    jb .collision_26 ; Si hay colisión 
.no_collision_26:
    ret

.collision_26:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_27:
    ;Collision with enemy 27
    mov r8, [enemy27_x_pos]
    mov r9, [enemy27_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet    
    cmp r8, r10
    jb .no_collision_27
    add r10, rcx
    cmp r8, r10
    jb .collision_27 ; Si hay colisión  
.no_collision_27:
    ret

.collision_27:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_28:
    ;Collision with enemy 28
    mov r8, [enemy28_x_pos]
    mov r9, [enemy28_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet   
    cmp r8, r10
    jb .no_collision_28
    add r10, rcx
    cmp r8, r10
    jb .collision_28 ; Si hay colisión
.no_collision_28:
    ret

.collision_28:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_29:
    ;Collision with enemy 29
    mov r8, [enemy29_x_pos]
    mov r9, [enemy29_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet   
    cmp r8, r10
    jb .no_collision_29
    add r10, rcx
    cmp r8, r10
    jb .collision_29 ; Si hay colisión
.no_collision_29:
    ret

.collision_29:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_30:
    ;Collision with enemy30
    mov r8, [enemy30_x_pos]
    mov r9, [enemy30_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet   
    cmp r8, r10
    jb .no_collision_30
    add r10, rcx
    cmp r8, r10
    jb .collision_30 ; Si hay colisión
.no_collision_30:
    ret

.collision_30:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_31:
    ;Collision with enemy31
    mov r8, [enemy31_x_pos]
    mov r9, [enemy31_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    sub r10, column_cells + 2 ; En la fila de la pallet   
    cmp r8, r10
    jb .no_collision_31
    add r10, rcx
    cmp r8, r10
    jb .collision_31 ; Si hay colisión

.no_collision_31:
    ret

.collision_31:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret
check_collision_32:
    ;Collision with enemy32
    mov r8, [enemy32_x_pos]
    mov r9, [enemy32_y_pos]
    mov r10, [pallet_position]
    mov rcx, [pallet_size]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
   sub r10, column_cells + 2 ; En la fila de la pallet 
    cmp r8, r10
    jb .no_collision_32
    add r10, rcx
    cmp r8, r10
    jb .collision_32 ; Si hay colisión

.no_collision_32:
    ret

.collision_32:
    ; Mostrar mensaje de "Game Over"
    call reset_game
    jmp GameOver
    ret

bomb_enemy:

    mov r8, [timer_enemy]
    dec r8
    mov [timer_enemy], r8
    cmp r8, 0
    jne .no_bomb

    ; Restablecer temporizador de aparición de la bomba
    mov r8, 130
    mov [timer_enemy], r8

    mov r8, [bomb_active]
    cmp r8, 0
    jne .no_bomb


    mov r8, [enemy1_x_pos]
    mov [bomb_x_pos], r8
    mov r8, [enemy1_y_pos]
    add r8, 1
    mov [bomb_y_pos], r8
    mov r8, 1
    mov [bomb_active], r8

.no_bomb:

    ; Verificar si la bomba está activa y moverla hacia abajo
    mov r10, 1
    cmp [enemy1_active], r10
    jne .no_bom

    ; Temporizador de ciclo para controlar la velocidad de descenso de la bomba
    mov r8, [bomb_cycle_timer]
    dec r8
    mov [bomb_cycle_timer], r8
    cmp r8, 0
    jne .no_bomb_move

    ; Restablecer el temporizador de ciclo de la bomba
    mov r8, 10
    mov [bomb_cycle_timer], r8

    ; Verificar si la bomba está activa y moverla hacia abajo
    mov r8, [bomb_active]
    cmp r8, 1
    jne .no_bomb_move

    mov r8, [bomb_x_pos]
    mov r9, [bomb_y_pos]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax

    mov r13, 1
    mov [active_lifes], r13

    ; Borrar la posición anterior de la bomba
    sub r8, column_cells + 2
    mov byte [r8], char_space

    ; Mover la bomba una posición hacia abajo
    add r9, 1
    mov [bomb_y_pos], r9
    cmp r9, 32
    je .deactivate_bomb

    mov byte [r8 + column_cells + 2], '*'
    jmp .no_bomb_move

.no_bom:
    ret
.deactivate_bomb:
    mov r8, 0
    mov [bomb_active], r8
.no_bomb_move:
    ret

bomb_enemy_6:

    mov r8, [timer_enemy_6]
    dec r8
    mov [timer_enemy_6], r8
    cmp r8, 0
    jne .no_bomb_6

    ; Restablecer temporizador de aparición de la bomba
    mov r8, 150
    mov [timer_enemy_6], r8

    mov r8, [bomb_active_6]
    cmp r8, 0
    jne .no_bomb_6

    mov r8, [enemy6_x_pos]
    mov [bomb_x_pos_6], r8
    mov r8, [enemy6_y_pos]
    add r8, 1
    mov [bomb_y_pos_6], r8
    mov r8, 1
    mov [bomb_active_6], r8

.no_bomb_6:

    ; Verificar si la bomba está activa y moverla hacia abajo
    mov r10, 1
    cmp [enemy6_active], r10
    jne .no_bom_6

    ; Temporizador de ciclo para controlar la velocidad de descenso de la bomba
    mov r8, [bomb_cycle_timer_6]
    dec r8
    mov [bomb_cycle_timer_6], r8
    cmp r8, 0
    jne .no_bomb_move_6

    ; Restablecer el temporizador de ciclo de la bomba
    mov r8, 10
    mov [bomb_cycle_timer_6], r8

    ; Verificar si la bomba está activa y moverla hacia abajo
    mov r8, [bomb_active_6]
    cmp r8, 1
    jne .no_bomb_move_6

    mov r8, [bomb_x_pos_6]
    mov r9, [bomb_y_pos_6]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax

    mov r13, 1
    mov [active_lifes_2], r13

    ; Borrar la posición anterior de la bomba
    sub r8, column_cells + 2
    mov byte [r8], char_space

    ; Mover la bomba una posición hacia abajo
    add r9, 1
    mov [bomb_y_pos_6], r9
    cmp r9, 32
    je .deactivate_bomb_6

    mov byte [r8 + column_cells + 2], '*'
    jmp .no_bomb_move_6
.no_bom_6:
    ret
.deactivate_bomb_6:
    mov r8, 0
    mov [bomb_active_6], r8
.no_bomb_move_6:
    ret

bomb_enemy_11:
    mov r8, [timer_enemy_11]
    dec r8
    mov [timer_enemy_11], r8
    cmp r8, 0
    jne .no_bomb_11

    ; Restablecer temporizador de aparición de la bomba
    mov r8, 110
    mov [timer_enemy_11], r8

    mov r8, [bomb_active_11]
    cmp r8, 0
    jne .no_bomb_11

    mov r8, [enemy11_x_pos]
    mov [bomb_x_pos_11], r8
    mov r8, [enemy11_y_pos]
    add r8, 1
    mov [bomb_y_pos_11], r8
    mov r8, 1
    mov [bomb_active_11], r8

.no_bomb_11:

    ; Verificar si la bomba está activa y moverla hacia abajo
    mov r10, 1
    cmp [enemy11_active], r10
    jne .no_bom_11

    ; Temporizador de ciclo para controlar la velocidad de descenso de la bomba
    mov r8, [bomb_cycle_timer_11]
    dec r8
    mov [bomb_cycle_timer_11], r8
    cmp r8, 0
    jne .no_bomb_move_11
    mov r13, 1
    mov [active_lifes_3], r13
    ; Restablecer el temporizador de ciclo de la bomba
    mov r8, 10
    mov [bomb_cycle_timer_11], r8

    ; Verificar si la bomba está activa y moverla hacia abajo
    mov r8, [bomb_active_11]
    cmp r8, 1
    jne .no_bomb_move_11

    mov r8, [bomb_x_pos_11]
    mov r9, [bomb_y_pos_11]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax

    ; Borrar la posición anterior de la bomba
    sub r8, column_cells + 2
    mov byte [r8], char_space

    ; Mover la bomba una posición hacia abajo
    add r9, 1
    mov [bomb_y_pos_11], r9
    cmp r9, 32
    je .deactivate_bomb_11

    mov byte [r8 + column_cells + 2], '*'
    jmp .no_bomb_move_11
.no_bom_11:
    ret
.deactivate_bomb_11:
    mov r8, 0
    mov [bomb_active_11], r8
.no_bomb_move_11:
    ret

bomb_enemy_22:
    mov r8, [timer_enemy_22]
    dec r8
    mov [timer_enemy_22], r8
    cmp r8, 0
    jne .no_bomb_22

    ; Restablecer temporizador de aparición de la bomba
    mov r8, 80
    mov [timer_enemy_22], r8

    mov r8, [bomb_active_22]
    cmp r8, 0
    jne .no_bomb_22

    mov r8, [enemy2_x_pos]
    mov [bomb_x_pos_22], r8
    mov r8, [enemy22_y_pos]
    add r8, 1
    mov [bomb_y_pos_22], r8
    mov r8, 1
    mov [bomb_active_22], r8

.no_bomb_22:

    ; Verificar si la bomba está activa y moverla hacia abajo
    mov r10, 1
    cmp [enemy22_active], r10
    jne .no_bom_22

    ; Temporizador de ciclo para controlar la velocidad de descenso de la bomba
    mov r8, [bomb_cycle_timer_22]
    dec r8
    mov [bomb_cycle_timer_22], r8
    cmp r8, 0
    jne .no_bomb_move_22

    ; Restablecer el temporizador de ciclo de la bomba
    mov r8, 10
    mov [bomb_cycle_timer_22], r8

    ; Verificar si la bomba está activa y moverla hacia abajo
    mov r8, [bomb_active_22]
    cmp r8, 1
    jne .no_bomb_move_22

    mov r8, [bomb_x_pos_22]
    mov r9, [bomb_y_pos_22]
    add r8, board
    mov rcx, r9
    mov rax, column_cells + 2
    imul rcx
    add r8, rax
    mov r13, 1
    mov [active_lifes_4], r13
    ; Borrar la posición anterior de la bomba
    sub r8, column_cells + 2
    mov byte [r8], char_space

    ; Mover la bomba una posición hacia abajo
    add r9, 1
    mov [bomb_y_pos_22], r9
    cmp r9, 32
    je .deactivate_bomb_22

    mov byte [r8 + column_cells + 2], '*'
    jmp .no_bomb_move_22
    
.no_bom_22:
    ret
.deactivate_bomb_22:
    mov r8, 0
    mov [bomb_active_22], r8
.no_bomb_move_22:
    ret

check_level_up:
    
    mov r13, 0
    cmp [ban_level], r13
    je .next_level

    mov rax, [score]      
    cmp rax, 320        
    jb .no_level_up        
    call reset_game_2
    jmp Level_2

.no_level_up:
    ret
.next_level:


    mov r13, 0
    cmp [ban_level_2], r13
    je .next_level_2

    mov rax, [score]       ; Carga el puntaje actual en RAX
    cmp rax, 640        ; Compara el puntaje con 320
    jb .no_level_up_2        ; Si es menor, no hace nada
    ; Llama a la función que dibuja el nivel 2
    call reset_game_3
    jmp Level_3

    ret 
.no_level_up_2:
    ret

.next_level_2:

    mov r13, 0
    cmp [ban_level_3], r13
    je .next_level_4

    mov rax, [score]       ; Carga el puntaje actual en RAX
    cmp rax, 960        ; Compara el puntaje con 320
    jb .no_level_up_4        ; Si es menor, no hace nada
    ; Llama a la función que dibuja el nivel 2
    call reset_game_4
    jmp Level_4
    ret 

.no_level_up_4:
    ret

.next_level_4:
    mov r13, 0
    cmp [ban_level_4], r13
    je .next_level_5

    mov rax, [score]       ; Carga el puntaje actual en RAX
    cmp rax, 1280        ; Compara el puntaje con 320
    jb .no_level_up_5        ; Si es menor, no hace nada
    ; Llama a la función que dibuja el nivel 2
    call reset_game_5
    jmp Level_5
    ret 

.no_level_up_5:
    ret

.next_level_5:

    mov r13, 0
    cmp [ban_level_f], r13
    je .next_level_f

    mov rax, [score]       ; Carga el puntaje actual en RAX
    cmp rax, 1600        ; Compara el puntaje con 320
    jb .no_level_up_f        ; Si es menor, no hace nada
    ; Llama a la función que dibuja el nivel 2
    call reset_game
    jmp Level_f
    ret 

.no_level_up_f:
    ret

.next_level_f:
    ret

reset_game:
    ; Limpiar pantalla
    print clear, clear_length
    mov r13, 3
    mov [lifes_count], r13
    ; Resetear posiciones y estados
    mov r11, board + 40 + 29 * (column_cells + 2)
    mov [pallet_position], r11

    mov r11, 18
    mov [enemy0_x_pos], r11
    mov r11, 5
    mov [enemy0_y_pos], r11

    mov r11, 9
    mov [enemy1_x_pos], r11
    mov r11, 10
    mov [enemy1_y_pos], r11

    mov r11, 12
    mov [enemy2_x_pos], r11
    mov r11, 10
    mov [enemy2_y_pos], r11

    mov r11, 15
    mov [enemy3_x_pos], r11
    mov r11, 10
    mov [enemy3_y_pos], r11

    mov r11, 18
    mov [enemy4_x_pos], r11
    mov r11, 10
    mov [enemy4_y_pos], r11

    mov r11, 21
    mov [enemy5_x_pos], r11
    mov r11, 10
    mov [enemy5_y_pos], r11

    mov r11, 24
    mov [enemy6_x_pos], r11
    mov r11, 10
    mov [enemy6_y_pos], r11

    mov r11, 27
    mov [enemy7_x_pos], r11
    mov r11, 10
    mov [enemy7_y_pos], r11

    mov r11, 30
    mov [enemy8_x_pos], r11
    mov r11, 10
    mov [enemy8_y_pos], r11

    mov r11, 9
    mov [enemy9_x_pos], r11
    mov r11, 12
    mov [enemy9_y_pos], r11

    mov r11, 12
    mov [enemy10_x_pos], r11
    mov r11, 12
    mov [enemy10_y_pos], r11

    mov r11, 15
    mov [enemy11_x_pos], r11
    mov r11, 12
    mov [enemy11_y_pos], r11

    mov r11, 18
    mov [enemy12_x_pos], r11
    mov r11, 12
    mov [enemy12_y_pos], r11

    mov r11, 21
    mov [enemy13_x_pos], r11
    mov r11, 12
    mov [enemy13_y_pos], r11

    mov r11, 24
    mov [enemy14_x_pos], r11
    mov r11, 12
    mov [enemy14_y_pos], r11

    mov r11, 27
    mov [enemy15_x_pos], r11
    mov r11, 12
    mov [enemy15_y_pos], r11

    mov r11, 30
    mov [enemy16_x_pos], r11
    mov r11, 12
    mov [enemy16_y_pos], r11

    mov r11, 9
    mov [enemy17_x_pos], r11
    mov r11, 14
    mov [enemy17_y_pos], r11

    mov r11, 12
    mov [enemy18_x_pos], r11
    mov r11, 14
    mov [enemy18_y_pos], r11

    mov r11, 15
    mov [enemy19_x_pos], r11
    mov r11, 14
    mov [enemy19_y_pos], r11

    mov r11, 18
    mov [enemy20_x_pos], r11
    mov r11, 14
    mov [enemy20_y_pos], r11

    mov r11, 21
    mov [enemy21_x_pos], r11
    mov r11, 14
    mov [enemy21_y_pos], r11

    mov r11, 24
    mov [enemy22_x_pos], r11
    mov r11, 14
    mov [enemy22_y_pos], r11

    mov r11, 27
    mov [enemy23_x_pos], r11
    mov r11, 14
    mov [enemy23_y_pos], r11

    mov r11, 30
    mov [enemy24_x_pos], r11
    mov r11, 14
    mov [enemy24_y_pos], r11

    mov r11, 9
    mov [enemy25_x_pos], r11
    mov r11, 16
    mov [enemy25_y_pos], r11

    mov r11, 12
    mov [enemy26_x_pos], r11
    mov r11, 16
    mov [enemy26_y_pos], r11

    mov r11, 15
    mov [enemy27_x_pos], r11
    mov r11, 16
    mov [enemy27_y_pos], r11

    mov r11, 18
    mov [enemy28_x_pos], r11
    mov r11, 16
    mov [enemy28_y_pos], r11

    mov r11, 21
    mov [enemy29_x_pos], r11
    mov r11, 16
    mov [enemy29_y_pos], r11

    mov r11, 24
    mov [enemy30_x_pos], r11
    mov r11, 16
    mov [enemy30_y_pos], r11

    mov r11, 27
    mov [enemy31_x_pos], r11
    mov r11, 16
    mov [enemy31_y_pos], r11

    mov r11, 30
    mov [enemy32_x_pos], r11
    mov r11, 16
    mov [enemy32_y_pos], r11


    mov r11, 1
    mov [ball_active], r11
    mov [one_active], r11

    mov [enemy1_active], r11
    mov [enemy2_active], r11
    mov [enemy3_active], r11
    mov [enemy4_active], r11
    mov [enemy5_active], r11
    mov [enemy6_active], r11
    mov [enemy7_active], r11
    mov [enemy8_active], r11
    mov [enemy9_active], r11
    mov [enemy10_active], r11
    mov [enemy11_active], r11
    mov [enemy12_active], r11
    mov [enemy13_active], r11
    mov [enemy14_active], r11
    mov [enemy15_active], r11
    mov [enemy16_active], r11 
    mov [enemy17_active], r11
    mov [enemy18_active], r11
    mov [enemy19_active], r11
    mov [enemy20_active], r11
    mov [enemy21_active], r11
    mov [enemy22_active], r11
    mov [enemy23_active], r11
    mov [enemy24_active], r11
    mov [enemy25_active], r11
    mov [enemy26_active], r11
    mov [enemy27_active], r11
    mov [enemy28_active], r11
    mov [enemy29_active], r11
    mov [enemy30_active], r11
    mov [enemy31_active], r11
    mov [enemy32_active], r11
    

    mov r11, 1
    mov [enemy_direction], r11
    mov r11, 120
    mov [enemy_move_time], r11
    mov r11, 1
    mov [enemy_direction_2], r11
    mov r11, 120
    mov [enemy_move_time_2], r11
    mov r11, 1
    mov [enemy_direction_3], r11
    mov r11, 120
    mov [enemy_move_time_3], r11
    mov r11, 1
    mov [enemy_direction_4], r11
    mov r11, 120
    mov [enemy_move_time_4], r11
    mov r11, 1
    mov [enemy_direction_5], r11
    mov r11, 120
    mov [enemy_move_time_5], r11
    mov r11, 1
    mov [enemy_direction_6], r11
    mov r11, 120
    mov [enemy_move_time_6], r11
    mov r11, 1
    mov [enemy_direction_7], r11
    mov r11, 120
    mov [enemy_move_time_7], r11
    mov r11, 1
    mov [enemy_direction_8], r11
    mov r11, 120
    mov [enemy_move_time_8], r11
    mov r11, 1
    mov [enemy_direction_9], r11
    mov r11, 120
    mov [enemy_move_time_9], r11
    mov r11, 1
    mov [enemy_direction_10], r11
    mov r11, 120
    mov [enemy_move_time_10], r11
    mov r11, 1
    mov [enemy_direction_11], r11
    mov r11, 120
    mov [enemy_move_time_11], r11
    mov r11, 1
    mov [enemy_direction_12], r11
    mov r11, 120
    mov [enemy_move_time_12], r11
    mov r11, 1
    mov [enemy_direction_13], r11
    mov r11, 120
    mov [enemy_move_time_13], r11
    mov r11, 1
    mov [enemy_direction_14], r11
    mov r11, 120
    mov [enemy_move_time_14], r11
    mov r11, 1
    mov [enemy_direction_15], r11
    mov r11, 120
    mov [enemy_move_time_15], r11
    mov r11, 1
    mov [enemy_direction_16], r11
    mov r11, 120
    mov [enemy_move_time_16], r11
    mov r11, 1
    mov [enemy_direction_17], r11
    mov r11, 120
    mov [enemy_move_time_17], r11
    mov r11, 1
    mov [enemy_direction_18], r11
    mov r11, 120
    mov [enemy_move_time_18], r11
    mov r11, 1
    mov [enemy_direction_19], r11
    mov r11, 120
    mov [enemy_move_time_19], r11
    mov r11, 1
    mov [enemy_direction_20], r11
    mov r11, 120
    mov [enemy_move_time_20], r11
    mov r11, 1
    mov [enemy_direction_21], r11
    mov r11, 120
    mov [enemy_move_time_21], r11
    mov r11, 1
    mov [enemy_direction_22], r11
    mov r11, 120
    mov [enemy_move_time_22], r11
    mov r11, 1
    mov [enemy_direction_23], r11
    mov r11, 120
    mov [enemy_move_time_23], r11
    mov r11, 1
    mov [enemy_direction_24], r11
    mov r11, 120
    mov [enemy_move_time_24], r11
    mov r11, 1
    mov [enemy_direction_25], r11
    mov r11, 120
    mov [enemy_move_time_25], r11
    mov r11, 1
    mov [enemy_direction_26], r11
    mov r11, 120
    mov [enemy_move_time_26], r11
    mov r11, 1
    mov [enemy_direction_27], r11
    mov r11, 120
    mov [enemy_move_time_27], r11
    mov r11, 1
    mov [enemy_direction_28], r11
    mov r11, 120
    mov [enemy_move_time_28], r11
    mov r11, 1
    mov [enemy_direction_29], r11
    mov r11, 120
    mov [enemy_move_time_29], r11
    mov r11, 1
    mov [enemy_direction_30], r11
    mov r11, 120
    mov [enemy_move_time_30], r11
    mov r11, 1
    mov [enemy_direction_31], r11
    mov r11, 120
    mov [enemy_move_time_31], r11
    mov r11, 1
    mov [enemy_direction_32], r11
    mov r11, 120
    mov [enemy_move_time_32], r11   
    ret

reset_game_2:
    ; Limpiar pantalla
    print clear, clear_length
    mov r13, 3
    mov [lifes_count], r13
    mov r14, 1
    mov r15, 0
    mov [prueba], r14
    mov [bomb_act], r14
    mov [score_active],r15
    mov [active_points], r14
    mov [score_active_2],r15
    mov [active_points_2], r14
    mov [score_active_3],r15
    mov [active_points_3], r14
    mov [score_active_4],r15
    mov [active_points_4], r14    
    mov [score_active_5],r15
    mov [active_points_5], r14
    mov [score_active_6],r15
    mov [active_points_6], r14
    mov [score_active_7],r15
    mov [active_points_7], r14
    mov [score_active_8],r15
    mov [active_points_8], r14
    mov [score_active_9],r15
    mov [active_points_9], r14
    mov [score_active_10],r15
    mov [active_points_10], r14    
    mov [score_active_11],r15
    mov [active_points_11], r14
    mov [score_active_12],r15
    mov [active_points_12], r14
    mov [score_active_13],r15
    mov [active_points_13], r14
    mov [score_active_14],r15
    mov [active_points_14], r14
    mov [score_active_15],r15
    mov [active_points_15], r14
    mov [score_active_16],r15
    mov [active_points_16], r14
    mov [score_active_17],r15
    mov [active_points_17], r14
    mov [score_active_18],r15
    mov [active_points_18], r14    
    mov [score_active_19],r15
    mov [active_points_19], r14
    mov [score_active_20],r15
    mov [active_points_20], r14
    mov [score_active_21],r15
    mov [active_points_21], r14
    mov [score_active_22],r15
    mov [active_points_22], r14
    mov [score_active_23],r15
    mov [active_points_23], r14
    mov [score_active_24],r15
    mov [active_points_24], r14    
    mov [score_active_25],r15
    mov [active_points_25], r14
    mov [score_active_26],r15
    mov [active_points_26], r14
    mov [score_active_27],r15
    mov [active_points_27], r14
    mov [score_active_28],r15
    mov [active_points_28], r14
    mov [score_active_29],r15
    mov [active_points_29], r14
    mov [score_active_30],r15
    mov [active_points_30], r14
    mov [score_active_31],r15
    mov [active_points_31], r14
    mov [score_active_32],r15
    mov [active_points_32], r14

    ; Resetear posiciones y estados
    ;mov r11, board + 40 + 29 * (column_cells + 2)
    ;mov [pallet_position], r11


    mov r11, 9
    mov [enemy1_x_pos], r11
    mov r11, 11
    mov [enemy1_y_pos], r11

    mov r11, 12
    mov [enemy2_x_pos], r11
    mov r11, 11
    mov [enemy2_y_pos], r11

    mov r11, 15
    mov [enemy3_x_pos], r11
    mov r11, 11
    mov [enemy3_y_pos], r11

    mov r11, 18
    mov [enemy4_x_pos], r11
    mov r11, 11
    mov [enemy4_y_pos], r11

    mov r11, 21
    mov [enemy5_x_pos], r11
    mov r11, 11
    mov [enemy5_y_pos], r11

    mov r11, 24
    mov [enemy6_x_pos], r11
    mov r11, 11
    mov [enemy6_y_pos], r11

    mov r11, 27
    mov [enemy7_x_pos], r11
    mov r11, 11
    mov [enemy7_y_pos], r11

    mov r11, 30
    mov [enemy8_x_pos], r11
    mov r11, 11
    mov [enemy8_y_pos], r11

    mov r11, 9
    mov [enemy9_x_pos], r11
    mov r11, 13
    mov [enemy9_y_pos], r11

    mov r11, 12
    mov [enemy10_x_pos], r11
    mov r11, 13
    mov [enemy10_y_pos], r11

    mov r11, 15
    mov [enemy11_x_pos], r11
    mov r11, 13
    mov [enemy11_y_pos], r11

    mov r11, 18
    mov [enemy12_x_pos], r11
    mov r11, 13
    mov [enemy12_y_pos], r11

    mov r11, 21
    mov [enemy13_x_pos], r11
    mov r11, 13
    mov [enemy13_y_pos], r11

    mov r11, 24
    mov [enemy14_x_pos], r11
    mov r11, 13
    mov [enemy14_y_pos], r11

    mov r11, 27
    mov [enemy15_x_pos], r11
    mov r11, 13
    mov [enemy15_y_pos], r11

    mov r11, 30
    mov [enemy16_x_pos], r11
    mov r11, 13
    mov [enemy16_y_pos], r11

    mov r11, 9
    mov [enemy17_x_pos], r11
    mov r11, 15
    mov [enemy17_y_pos], r11

    mov r11, 12
    mov [enemy18_x_pos], r11
    mov r11, 15
    mov [enemy18_y_pos], r11

    mov r11, 15
    mov [enemy19_x_pos], r11
    mov r11, 15
    mov [enemy19_y_pos], r11

    mov r11, 18
    mov [enemy20_x_pos], r11
    mov r11, 15
    mov [enemy20_y_pos], r11

    mov r11, 21
    mov [enemy21_x_pos], r11
    mov r11, 15
    mov [enemy21_y_pos], r11

    mov r11, 24
    mov [enemy22_x_pos], r11
    mov r11, 15
    mov [enemy22_y_pos], r11

    mov r11, 27
    mov [enemy23_x_pos], r11
    mov r11, 15
    mov [enemy23_y_pos], r11

    mov r11, 30
    mov [enemy24_x_pos], r11
    mov r11, 15
    mov [enemy24_y_pos], r11

    mov r11, 9
    mov [enemy25_x_pos], r11
    mov r11, 17
    mov [enemy25_y_pos], r11

    mov r11, 12
    mov [enemy26_x_pos], r11
    mov r11, 17
    mov [enemy26_y_pos], r11

    mov r11, 15
    mov [enemy27_x_pos], r11
    mov r11, 17
    mov [enemy27_y_pos], r11

    mov r11, 18
    mov [enemy28_x_pos], r11
    mov r11, 17
    mov [enemy28_y_pos], r11

    mov r11, 21
    mov [enemy29_x_pos], r11
    mov r11, 17
    mov [enemy29_y_pos], r11

    mov r11, 24
    mov [enemy30_x_pos], r11
    mov r11, 17
    mov [enemy30_y_pos], r11

    mov r11, 27
    mov [enemy31_x_pos], r11
    mov r11, 17
    mov [enemy31_y_pos], r11

    mov r11, 30
    mov [enemy32_x_pos], r11
    mov r11, 17
    mov [enemy32_y_pos], r11


    mov r11, 1
    mov [ball_active], r11
    mov [one_active], r11

    mov [enemy1_active], r11
    mov [enemy2_active], r11
    mov [enemy3_active], r11
    mov [enemy4_active], r11
    mov [enemy5_active], r11
    mov [enemy6_active], r11
    mov [enemy7_active], r11
    mov [enemy8_active], r11
    mov [enemy9_active], r11
    mov [enemy10_active], r11
    mov [enemy11_active], r11
    mov [enemy12_active], r11
    mov [enemy13_active], r11
    mov [enemy14_active], r11
    mov [enemy15_active], r11
    mov [enemy16_active], r11 
    mov [enemy17_active], r11
    mov [enemy18_active], r11
    mov [enemy19_active], r11
    mov [enemy20_active], r11
    mov [enemy21_active], r11
    mov [enemy22_active], r11
    mov [enemy23_active], r11
    mov [enemy24_active], r11
    mov [enemy25_active], r11
    mov [enemy26_active], r11
    mov [enemy27_active], r11
    mov [enemy28_active], r11
    mov [enemy29_active], r11
    mov [enemy30_active], r11
    mov [enemy31_active], r11
    mov [enemy32_active], r11
    

    mov r11, 1
    mov [enemy_direction], r11
    mov r11, 120
    mov [enemy_move_time], r11
    mov r11, 1
    mov [enemy_direction_2], r11
    mov r11, 120
    mov [enemy_move_time_2], r11
    mov r11, 1
    mov [enemy_direction_3], r11
    mov r11, 120
    mov [enemy_move_time_3], r11
    mov r11, 1
    mov [enemy_direction_4], r11
    mov r11, 120
    mov [enemy_move_time_4], r11
    mov r11, 1
    mov [enemy_direction_5], r11
    mov r11, 120
    mov [enemy_move_time_5], r11
    mov r11, 1
    mov [enemy_direction_6], r11
    mov r11, 120
    mov [enemy_move_time_6], r11
    mov r11, 1
    mov [enemy_direction_7], r11
    mov r11, 120
    mov [enemy_move_time_7], r11
    mov r11, 1
    mov [enemy_direction_8], r11
    mov r11, 120
    mov [enemy_move_time_8], r11
    mov r11, 1
    mov [enemy_direction_9], r11
    mov r11, 120
    mov [enemy_move_time_9], r11
    mov r11, 1
    mov [enemy_direction_10], r11
    mov r11, 120
    mov [enemy_move_time_10], r11
    mov r11, 1
    mov [enemy_direction_11], r11
    mov r11, 120
    mov [enemy_move_time_11], r11
    mov r11, 1
    mov [enemy_direction_12], r11
    mov r11, 120
    mov [enemy_move_time_12], r11
    mov r11, 1
    mov [enemy_direction_13], r11
    mov r11, 120
    mov [enemy_move_time_13], r11
    mov r11, 1
    mov [enemy_direction_14], r11
    mov r11, 120
    mov [enemy_move_time_14], r11
    mov r11, 1
    mov [enemy_direction_15], r11
    mov r11, 120
    mov [enemy_move_time_15], r11
    mov r11, 1
    mov [enemy_direction_16], r11
    mov r11, 120
    mov [enemy_move_time_16], r11
    mov r11, 1
    mov [enemy_direction_17], r11
    mov r11, 120
    mov [enemy_move_time_17], r11
    mov r11, 1
    mov [enemy_direction_18], r11
    mov r11, 120
    mov [enemy_move_time_18], r11
    mov r11, 1
    mov [enemy_direction_19], r11
    mov r11, 120
    mov [enemy_move_time_19], r11
    mov r11, 1
    mov [enemy_direction_20], r11
    mov r11, 120
    mov [enemy_move_time_20], r11
    mov r11, 1
    mov [enemy_direction_21], r11
    mov r11, 120
    mov [enemy_move_time_21], r11
    mov r11, 1
    mov [enemy_direction_22], r11
    mov r11, 120
    mov [enemy_move_time_22], r11
    mov r11, 1
    mov [enemy_direction_23], r11
    mov r11, 120
    mov [enemy_move_time_23], r11
    mov r11, 1
    mov [enemy_direction_24], r11
    mov r11, 120
    mov [enemy_move_time_24], r11
    mov r11, 1
    mov [enemy_direction_25], r11
    mov r11, 120
    mov [enemy_move_time_25], r11
    mov r11, 1
    mov [enemy_direction_26], r11
    mov r11, 120
    mov [enemy_move_time_26], r11
    mov r11, 1
    mov [enemy_direction_27], r11
    mov r11, 120
    mov [enemy_move_time_27], r11
    mov r11, 1
    mov [enemy_direction_28], r11
    mov r11, 120
    mov [enemy_move_time_28], r11
    mov r11, 1
    mov [enemy_direction_29], r11
    mov r11, 120
    mov [enemy_move_time_29], r11
    mov r11, 1
    mov [enemy_direction_30], r11
    mov r11, 120
    mov [enemy_move_time_30], r11
    mov r11, 1
    mov [enemy_direction_31], r11
    mov r11, 120
    mov [enemy_move_time_31], r11
    mov r11, 1
    mov [enemy_direction_32], r11
    mov r11, 120
    mov [enemy_move_time_32], r11 
      
    ret

reset_game_3:

    ; Limpiar pantalla
    print clear, clear_length
    mov r13, 3
    mov [lifes_count], r13
    mov r14, 1
    mov r15, 0
    mov [prueba], r14
    mov [bomb_act], r14
    mov [score_active],r15
    mov [active_points], r14
    mov [score_active_2],r15
    mov [active_points_2], r14
    mov [score_active_3],r15
    mov [active_points_3], r14
    mov [score_active_4],r15
    mov [active_points_4], r14    
    mov [score_active_5],r15
    mov [active_points_5], r14
    mov [score_active_6],r15
    mov [active_points_6], r14
    mov [score_active_7],r15
    mov [active_points_7], r14
    mov [score_active_8],r15
    mov [active_points_8], r14
    mov [score_active_9],r15
    mov [active_points_9], r14
    mov [score_active_10],r15
    mov [active_points_10], r14    
    mov [score_active_11],r15
    mov [active_points_11], r14
    mov [score_active_12],r15
    mov [active_points_12], r14
    mov [score_active_13],r15
    mov [active_points_13], r14
    mov [score_active_14],r15
    mov [active_points_14], r14
    mov [score_active_15],r15
    mov [active_points_15], r14
    mov [score_active_16],r15
    mov [active_points_16], r14
    mov [score_active_17],r15
    mov [active_points_17], r14
    mov [score_active_18],r15
    mov [active_points_18], r14    
    mov [score_active_19],r15
    mov [active_points_19], r14
    mov [score_active_20],r15
    mov [active_points_20], r14
    mov [score_active_21],r15
    mov [active_points_21], r14
    mov [score_active_22],r15
    mov [active_points_22], r14
    mov [score_active_23],r15
    mov [active_points_23], r14
    mov [score_active_24],r15
    mov [active_points_24], r14    
    mov [score_active_25],r15
    mov [active_points_25], r14
    mov [score_active_26],r15
    mov [active_points_26], r14
    mov [score_active_27],r15
    mov [active_points_27], r14
    mov [score_active_28],r15
    mov [active_points_28], r14
    mov [score_active_29],r15
    mov [active_points_29], r14
    mov [score_active_30],r15
    mov [active_points_30], r14
    mov [score_active_31],r15
    mov [active_points_31], r14
    mov [score_active_32],r15
    mov [active_points_32], r14

    ; Resetear posiciones y estados
    ;mov r11, board + 40 + 29 * (column_cells + 2)
    ;mov [pallet_position], r11

    mov r11, 9
    mov [enemy1_x_pos], r11
    mov r11, 12
    mov [enemy1_y_pos], r11

    mov r11, 12
    mov [enemy2_x_pos], r11
    mov r11, 12
    mov [enemy2_y_pos], r11

    mov r11, 15
    mov [enemy3_x_pos], r11
    mov r11, 12
    mov [enemy3_y_pos], r11

    mov r11, 18
    mov [enemy4_x_pos], r11
    mov r11, 12
    mov [enemy4_y_pos], r11

    mov r11, 21
    mov [enemy5_x_pos], r11
    mov r11, 12
    mov [enemy5_y_pos], r11

    mov r11, 24
    mov [enemy6_x_pos], r11
    mov r11, 12
    mov [enemy6_y_pos], r11

    mov r11, 27
    mov [enemy7_x_pos], r11
    mov r11, 12
    mov [enemy7_y_pos], r11

    mov r11, 30
    mov [enemy8_x_pos], r11
    mov r11, 12
    mov [enemy8_y_pos], r11

    mov r11, 9
    mov [enemy9_x_pos], r11
    mov r11, 14
    mov [enemy9_y_pos], r11

    mov r11, 12
    mov [enemy10_x_pos], r11
    mov r11, 14
    mov [enemy10_y_pos], r11

    mov r11, 15
    mov [enemy11_x_pos], r11
    mov r11, 14
    mov [enemy11_y_pos], r11

    mov r11, 18
    mov [enemy12_x_pos], r11
    mov r11, 14
    mov [enemy12_y_pos], r11

    mov r11, 21
    mov [enemy13_x_pos], r11
    mov r11, 14
    mov [enemy13_y_pos], r11

    mov r11, 24
    mov [enemy14_x_pos], r11
    mov r11, 14
    mov [enemy14_y_pos], r11

    mov r11, 27
    mov [enemy15_x_pos], r11
    mov r11, 14
    mov [enemy15_y_pos], r11

    mov r11, 30
    mov [enemy16_x_pos], r11
    mov r11, 14
    mov [enemy16_y_pos], r11

    mov r11, 9
    mov [enemy17_x_pos], r11
    mov r11, 16
    mov [enemy17_y_pos], r11

    mov r11, 12
    mov [enemy18_x_pos], r11
    mov r11, 16
    mov [enemy18_y_pos], r11

    mov r11, 15
    mov [enemy19_x_pos], r11
    mov r11, 16
    mov [enemy19_y_pos], r11

    mov r11, 18
    mov [enemy20_x_pos], r11
    mov r11, 16
    mov [enemy20_y_pos], r11

    mov r11, 21
    mov [enemy21_x_pos], r11
    mov r11, 16
    mov [enemy21_y_pos], r11

    mov r11, 24
    mov [enemy22_x_pos], r11
    mov r11, 16
    mov [enemy22_y_pos], r11

    mov r11, 27
    mov [enemy23_x_pos], r11
    mov r11, 16
    mov [enemy23_y_pos], r11

    mov r11, 30
    mov [enemy24_x_pos], r11
    mov r11, 16
    mov [enemy24_y_pos], r11

    mov r11, 9
    mov [enemy25_x_pos], r11
    mov r11, 18
    mov [enemy25_y_pos], r11

    mov r11, 12
    mov [enemy26_x_pos], r11
    mov r11, 18
    mov [enemy26_y_pos], r11

    mov r11, 15
    mov [enemy27_x_pos], r11
    mov r11, 18
    mov [enemy27_y_pos], r11

    mov r11, 18
    mov [enemy28_x_pos], r11
    mov r11, 18
    mov [enemy28_y_pos], r11

    mov r11, 21
    mov [enemy29_x_pos], r11
    mov r11, 18
    mov [enemy29_y_pos], r11

    mov r11, 24
    mov [enemy30_x_pos], r11
    mov r11, 18
    mov [enemy30_y_pos], r11

    mov r11, 27
    mov [enemy31_x_pos], r11
    mov r11, 18
    mov [enemy31_y_pos], r11

    mov r11, 30
    mov [enemy32_x_pos], r11
    mov r11, 18
    mov [enemy32_y_pos], r11


    mov r11, 1
    mov [ball_active], r11
    mov [one_active], r11

    mov [enemy1_active], r11
    mov [enemy2_active], r11
    mov [enemy3_active], r11
    mov [enemy4_active], r11
    mov [enemy5_active], r11
    mov [enemy6_active], r11
    mov [enemy7_active], r11
    mov [enemy8_active], r11
    mov [enemy9_active], r11
    mov [enemy10_active], r11
    mov [enemy11_active], r11
    mov [enemy12_active], r11
    mov [enemy13_active], r11
    mov [enemy14_active], r11
    mov [enemy15_active], r11
    mov [enemy16_active], r11 
    mov [enemy17_active], r11
    mov [enemy18_active], r11
    mov [enemy19_active], r11
    mov [enemy20_active], r11
    mov [enemy21_active], r11
    mov [enemy22_active], r11
    mov [enemy23_active], r11
    mov [enemy24_active], r11
    mov [enemy25_active], r11
    mov [enemy26_active], r11
    mov [enemy27_active], r11
    mov [enemy28_active], r11
    mov [enemy29_active], r11
    mov [enemy30_active], r11
    mov [enemy31_active], r11
    mov [enemy32_active], r11
    

    mov r11, 1
    mov [enemy_direction], r11
    mov r11, 120
    mov [enemy_move_time], r11
    mov r11, 1
    mov [enemy_direction_2], r11
    mov r11, 120
    mov [enemy_move_time_2], r11
    mov r11, 1
    mov [enemy_direction_3], r11
    mov r11, 120
    mov [enemy_move_time_3], r11
    mov r11, 1
    mov [enemy_direction_4], r11
    mov r11, 120
    mov [enemy_move_time_4], r11
    mov r11, 1
    mov [enemy_direction_5], r11
    mov r11, 120
    mov [enemy_move_time_5], r11
    mov r11, 1
    mov [enemy_direction_6], r11
    mov r11, 120
    mov [enemy_move_time_6], r11
    mov r11, 1
    mov [enemy_direction_7], r11
    mov r11, 120
    mov [enemy_move_time_7], r11
    mov r11, 1
    mov [enemy_direction_8], r11
    mov r11, 120
    mov [enemy_move_time_8], r11
    mov r11, 1
    mov [enemy_direction_9], r11
    mov r11, 120
    mov [enemy_move_time_9], r11
    mov r11, 1
    mov [enemy_direction_10], r11
    mov r11, 120
    mov [enemy_move_time_10], r11
    mov r11, 1
    mov [enemy_direction_11], r11
    mov r11, 120
    mov [enemy_move_time_11], r11
    mov r11, 1
    mov [enemy_direction_12], r11
    mov r11, 120
    mov [enemy_move_time_12], r11
    mov r11, 1
    mov [enemy_direction_13], r11
    mov r11, 120
    mov [enemy_move_time_13], r11
    mov r11, 1
    mov [enemy_direction_14], r11
    mov r11, 120
    mov [enemy_move_time_14], r11
    mov r11, 1
    mov [enemy_direction_15], r11
    mov r11, 120
    mov [enemy_move_time_15], r11
    mov r11, 1
    mov [enemy_direction_16], r11
    mov r11, 120
    mov [enemy_move_time_16], r11
    mov r11, 1
    mov [enemy_direction_17], r11
    mov r11, 120
    mov [enemy_move_time_17], r11
    mov r11, 1
    mov [enemy_direction_18], r11
    mov r11, 120
    mov [enemy_move_time_18], r11
    mov r11, 1
    mov [enemy_direction_19], r11
    mov r11, 120
    mov [enemy_move_time_19], r11
    mov r11, 1
    mov [enemy_direction_20], r11
    mov r11, 120
    mov [enemy_move_time_20], r11
    mov r11, 1
    mov [enemy_direction_21], r11
    mov r11, 120
    mov [enemy_move_time_21], r11
    mov r11, 1
    mov [enemy_direction_22], r11
    mov r11, 120
    mov [enemy_move_time_22], r11
    mov r11, 1
    mov [enemy_direction_23], r11
    mov r11, 120
    mov [enemy_move_time_23], r11
    mov r11, 1
    mov [enemy_direction_24], r11
    mov r11, 120
    mov [enemy_move_time_24], r11
    mov r11, 1
    mov [enemy_direction_25], r11
    mov r11, 120
    mov [enemy_move_time_25], r11
    mov r11, 1
    mov [enemy_direction_26], r11
    mov r11, 120
    mov [enemy_move_time_26], r11
    mov r11, 1
    mov [enemy_direction_27], r11
    mov r11, 120
    mov [enemy_move_time_27], r11
    mov r11, 1
    mov [enemy_direction_28], r11
    mov r11, 120
    mov [enemy_move_time_28], r11
    mov r11, 1
    mov [enemy_direction_29], r11
    mov r11, 120
    mov [enemy_move_time_29], r11
    mov r11, 1
    mov [enemy_direction_30], r11
    mov r11, 120
    mov [enemy_move_time_30], r11
    mov r11, 1
    mov [enemy_direction_31], r11
    mov r11, 120
    mov [enemy_move_time_31], r11
    mov r11, 1
    mov [enemy_direction_32], r11
    mov r11, 120
    mov [enemy_move_time_32], r11     
    ret

reset_game_4:
    ; Limpiar pantalla
    print clear, clear_length
    mov r13, 3
    mov [lifes_count], r13
    mov r14, 1
    mov r15, 0
    mov [prueba], r14
    mov [bomb_act], r14
    mov [score_active],r15
    mov [active_points], r14
    mov [score_active_2],r15
    mov [active_points_2], r14
    mov [score_active_3],r15
    mov [active_points_3], r14
    mov [score_active_4],r15
    mov [active_points_4], r14    
    mov [score_active_5],r15
    mov [active_points_5], r14
    mov [score_active_6],r15
    mov [active_points_6], r14
    mov [score_active_7],r15
    mov [active_points_7], r14
    mov [score_active_8],r15
    mov [active_points_8], r14
    mov [score_active_9],r15
    mov [active_points_9], r14
    mov [score_active_10],r15
    mov [active_points_10], r14    
    mov [score_active_11],r15
    mov [active_points_11], r14
    mov [score_active_12],r15
    mov [active_points_12], r14
    mov [score_active_13],r15
    mov [active_points_13], r14
    mov [score_active_14],r15
    mov [active_points_14], r14
    mov [score_active_15],r15
    mov [active_points_15], r14
    mov [score_active_16],r15
    mov [active_points_16], r14
    mov [score_active_17],r15
    mov [active_points_17], r14
    mov [score_active_18],r15
    mov [active_points_18], r14    
    mov [score_active_19],r15
    mov [active_points_19], r14
    mov [score_active_20],r15
    mov [active_points_20], r14
    mov [score_active_21],r15
    mov [active_points_21], r14
    mov [score_active_22],r15
    mov [active_points_22], r14
    mov [score_active_23],r15
    mov [active_points_23], r14
    mov [score_active_24],r15
    mov [active_points_24], r14    
    mov [score_active_25],r15
    mov [active_points_25], r14
    mov [score_active_26],r15
    mov [active_points_26], r14
    mov [score_active_27],r15
    mov [active_points_27], r14
    mov [score_active_28],r15
    mov [active_points_28], r14
    mov [score_active_29],r15
    mov [active_points_29], r14
    mov [score_active_30],r15
    mov [active_points_30], r14
    mov [score_active_31],r15
    mov [active_points_31], r14
    mov [score_active_32],r15
    mov [active_points_32], r14

    ; Resetear posiciones y estados
    ;mov r11, board + 40 + 29 * (column_cells + 2)
    ;mov [pallet_position], r11


    mov r11, 9
    mov [enemy1_x_pos], r11
    mov r11, 13
    mov [enemy1_y_pos], r11

    mov r11, 12
    mov [enemy2_x_pos], r11
    mov r11, 13
    mov [enemy2_y_pos], r11

    mov r11, 15
    mov [enemy3_x_pos], r11
    mov r11, 13
    mov [enemy3_y_pos], r11

    mov r11, 18
    mov [enemy4_x_pos], r11
    mov r11, 13
    mov [enemy4_y_pos], r11

    mov r11, 21
    mov [enemy5_x_pos], r11
    mov r11, 13
    mov [enemy5_y_pos], r11

    mov r11, 24
    mov [enemy6_x_pos], r11
    mov r11, 13
    mov [enemy6_y_pos], r11

    mov r11, 27
    mov [enemy7_x_pos], r11
    mov r11, 13
    mov [enemy7_y_pos], r11

    mov r11, 30
    mov [enemy8_x_pos], r11
    mov r11, 13
    mov [enemy8_y_pos], r11

    mov r11, 9
    mov [enemy9_x_pos], r11
    mov r11, 15
    mov [enemy9_y_pos], r11

    mov r11, 12
    mov [enemy10_x_pos], r11
    mov r11, 15
    mov [enemy10_y_pos], r11

    mov r11, 15
    mov [enemy11_x_pos], r11
    mov r11, 15
    mov [enemy11_y_pos], r11

    mov r11, 18
    mov [enemy12_x_pos], r11
    mov r11, 15
    mov [enemy12_y_pos], r11

    mov r11, 21
    mov [enemy13_x_pos], r11
    mov r11, 15
    mov [enemy13_y_pos], r11

    mov r11, 24
    mov [enemy14_x_pos], r11
    mov r11, 15
    mov [enemy14_y_pos], r11

    mov r11, 27
    mov [enemy15_x_pos], r11
    mov r11, 15
    mov [enemy15_y_pos], r11

    mov r11, 30
    mov [enemy16_x_pos], r11
    mov r11, 15
    mov [enemy16_y_pos], r11

    mov r11, 9
    mov [enemy17_x_pos], r11
    mov r11, 17
    mov [enemy17_y_pos], r11

    mov r11, 12
    mov [enemy18_x_pos], r11
    mov r11, 17
    mov [enemy18_y_pos], r11

    mov r11, 15
    mov [enemy19_x_pos], r11
    mov r11, 17
    mov [enemy19_y_pos], r11

    mov r11, 18
    mov [enemy20_x_pos], r11
    mov r11, 17
    mov [enemy20_y_pos], r11

    mov r11, 21
    mov [enemy21_x_pos], r11
    mov r11, 17
    mov [enemy21_y_pos], r11

    mov r11, 24
    mov [enemy22_x_pos], r11
    mov r11, 17
    mov [enemy22_y_pos], r11

    mov r11, 27
    mov [enemy23_x_pos], r11
    mov r11, 17
    mov [enemy23_y_pos], r11

    mov r11, 30
    mov [enemy24_x_pos], r11
    mov r11, 17
    mov [enemy24_y_pos], r11

    mov r11, 9
    mov [enemy25_x_pos], r11
    mov r11, 19
    mov [enemy25_y_pos], r11

    mov r11, 12
    mov [enemy26_x_pos], r11
    mov r11, 19
    mov [enemy26_y_pos], r11

    mov r11, 15
    mov [enemy27_x_pos], r11
    mov r11, 19
    mov [enemy27_y_pos], r11

    mov r11, 18
    mov [enemy28_x_pos], r11
    mov r11, 19
    mov [enemy28_y_pos], r11

    mov r11, 21
    mov [enemy29_x_pos], r11
    mov r11, 19
    mov [enemy29_y_pos], r11

    mov r11, 24
    mov [enemy30_x_pos], r11
    mov r11, 19
    mov [enemy30_y_pos], r11

    mov r11, 27
    mov [enemy31_x_pos], r11
    mov r11, 19
    mov [enemy31_y_pos], r11

    mov r11, 30
    mov [enemy32_x_pos], r11
    mov r11, 19
    mov [enemy32_y_pos], r11


    mov r11, 1
    mov [ball_active], r11
    mov [one_active], r11

    mov [enemy1_active], r11
    mov [enemy2_active], r11
    mov [enemy3_active], r11
    mov [enemy4_active], r11
    mov [enemy5_active], r11
    mov [enemy6_active], r11
    mov [enemy7_active], r11
    mov [enemy8_active], r11
    mov [enemy9_active], r11
    mov [enemy10_active], r11
    mov [enemy11_active], r11
    mov [enemy12_active], r11
    mov [enemy13_active], r11
    mov [enemy14_active], r11
    mov [enemy15_active], r11
    mov [enemy16_active], r11 
    mov [enemy17_active], r11
    mov [enemy18_active], r11
    mov [enemy19_active], r11
    mov [enemy20_active], r11
    mov [enemy21_active], r11
    mov [enemy22_active], r11
    mov [enemy23_active], r11
    mov [enemy24_active], r11
    mov [enemy25_active], r11
    mov [enemy26_active], r11
    mov [enemy27_active], r11
    mov [enemy28_active], r11
    mov [enemy29_active], r11
    mov [enemy30_active], r11
    mov [enemy31_active], r11
    mov [enemy32_active], r11
    

    mov r11, 1
    mov [enemy_direction], r11
    mov r11, 120
    mov [enemy_move_time], r11
    mov r11, 1
    mov [enemy_direction_2], r11
    mov r11, 120
    mov [enemy_move_time_2], r11
    mov r11, 1
    mov [enemy_direction_3], r11
    mov r11, 120
    mov [enemy_move_time_3], r11
    mov r11, 1
    mov [enemy_direction_4], r11
    mov r11, 120
    mov [enemy_move_time_4], r11
    mov r11, 1
    mov [enemy_direction_5], r11
    mov r11, 120
    mov [enemy_move_time_5], r11
    mov r11, 1
    mov [enemy_direction_6], r11
    mov r11, 120
    mov [enemy_move_time_6], r11
    mov r11, 1
    mov [enemy_direction_7], r11
    mov r11, 120
    mov [enemy_move_time_7], r11
    mov r11, 1
    mov [enemy_direction_8], r11
    mov r11, 120
    mov [enemy_move_time_8], r11
    mov r11, 1
    mov [enemy_direction_9], r11
    mov r11, 120
    mov [enemy_move_time_9], r11
    mov r11, 1
    mov [enemy_direction_10], r11
    mov r11, 120
    mov [enemy_move_time_10], r11
    mov r11, 1
    mov [enemy_direction_11], r11
    mov r11, 120
    mov [enemy_move_time_11], r11
    mov r11, 1
    mov [enemy_direction_12], r11
    mov r11, 120
    mov [enemy_move_time_12], r11
    mov r11, 1
    mov [enemy_direction_13], r11
    mov r11, 120
    mov [enemy_move_time_13], r11
    mov r11, 1
    mov [enemy_direction_14], r11
    mov r11, 120
    mov [enemy_move_time_14], r11
    mov r11, 1
    mov [enemy_direction_15], r11
    mov r11, 120
    mov [enemy_move_time_15], r11
    mov r11, 1
    mov [enemy_direction_16], r11
    mov r11, 120
    mov [enemy_move_time_16], r11
    mov r11, 1
    mov [enemy_direction_17], r11
    mov r11, 120
    mov [enemy_move_time_17], r11
    mov r11, 1
    mov [enemy_direction_18], r11
    mov r11, 120
    mov [enemy_move_time_18], r11
    mov r11, 1
    mov [enemy_direction_19], r11
    mov r11, 120
    mov [enemy_move_time_19], r11
    mov r11, 1
    mov [enemy_direction_20], r11
    mov r11, 120
    mov [enemy_move_time_20], r11
    mov r11, 1
    mov [enemy_direction_21], r11
    mov r11, 120
    mov [enemy_move_time_21], r11
    mov r11, 1
    mov [enemy_direction_22], r11
    mov r11, 120
    mov [enemy_move_time_22], r11
    mov r11, 1
    mov [enemy_direction_23], r11
    mov r11, 120
    mov [enemy_move_time_23], r11
    mov r11, 1
    mov [enemy_direction_24], r11
    mov r11, 120
    mov [enemy_move_time_24], r11
    mov r11, 1
    mov [enemy_direction_25], r11
    mov r11, 120
    mov [enemy_move_time_25], r11
    mov r11, 1
    mov [enemy_direction_26], r11
    mov r11, 120
    mov [enemy_move_time_26], r11
    mov r11, 1
    mov [enemy_direction_27], r11
    mov r11, 120
    mov [enemy_move_time_27], r11
    mov r11, 1
    mov [enemy_direction_28], r11
    mov r11, 120
    mov [enemy_move_time_28], r11
    mov r11, 1
    mov [enemy_direction_29], r11
    mov r11, 120
    mov [enemy_move_time_29], r11
    mov r11, 1
    mov [enemy_direction_30], r11
    mov r11, 120
    mov [enemy_move_time_30], r11
    mov r11, 1
    mov [enemy_direction_31], r11
    mov r11, 120
    mov [enemy_move_time_31], r11
    mov r11, 1
    mov [enemy_direction_32], r11
    mov r11, 120
    mov [enemy_move_time_32], r11 
      
    ret
reset_game_5:
    ; Limpiar pantalla
    print clear, clear_length
    mov r13, 3
    mov [lifes_count], r13
    mov r14, 1
    mov r15, 0
    mov [prueba], r14
    mov [bomb_act], r14
    mov [score_active],r15
    mov [active_points], r14
    mov [score_active_2],r15
    mov [active_points_2], r14
    mov [score_active_3],r15
    mov [active_points_3], r14
    mov [score_active_4],r15
    mov [active_points_4], r14    
    mov [score_active_5],r15
    mov [active_points_5], r14
    mov [score_active_6],r15
    mov [active_points_6], r14
    mov [score_active_7],r15
    mov [active_points_7], r14
    mov [score_active_8],r15
    mov [active_points_8], r14
    mov [score_active_9],r15
    mov [active_points_9], r14
    mov [score_active_10],r15
    mov [active_points_10], r14    
    mov [score_active_11],r15
    mov [active_points_11], r14
    mov [score_active_12],r15
    mov [active_points_12], r14
    mov [score_active_13],r15
    mov [active_points_13], r14
    mov [score_active_14],r15
    mov [active_points_14], r14
    mov [score_active_15],r15
    mov [active_points_15], r14
    mov [score_active_16],r15
    mov [active_points_16], r14
    mov [score_active_17],r15
    mov [active_points_17], r14
    mov [score_active_18],r15
    mov [active_points_18], r14    
    mov [score_active_19],r15
    mov [active_points_19], r14
    mov [score_active_20],r15
    mov [active_points_20], r14
    mov [score_active_21],r15
    mov [active_points_21], r14
    mov [score_active_22],r15
    mov [active_points_22], r14
    mov [score_active_23],r15
    mov [active_points_23], r14
    mov [score_active_24],r15
    mov [active_points_24], r14    
    mov [score_active_25],r15
    mov [active_points_25], r14
    mov [score_active_26],r15
    mov [active_points_26], r14
    mov [score_active_27],r15
    mov [active_points_27], r14
    mov [score_active_28],r15
    mov [active_points_28], r14
    mov [score_active_29],r15
    mov [active_points_29], r14
    mov [score_active_30],r15
    mov [active_points_30], r14
    mov [score_active_31],r15
    mov [active_points_31], r14
    mov [score_active_32],r15
    mov [active_points_32], r14

    ; Resetear posiciones y estados
    ;mov r11, board + 40 + 29 * (column_cells + 2)
    ;mov [pallet_position], r11


    mov r11, 9
    mov [enemy1_x_pos], r11
    mov r11, 14
    mov [enemy1_y_pos], r11

    mov r11, 12
    mov [enemy2_x_pos], r11
    mov r11, 14
    mov [enemy2_y_pos], r11

    mov r11, 15
    mov [enemy3_x_pos], r11
    mov r11, 14
    mov [enemy3_y_pos], r11

    mov r11, 18
    mov [enemy4_x_pos], r11
    mov r11, 14
    mov [enemy4_y_pos], r11

    mov r11, 21
    mov [enemy5_x_pos], r11
    mov r11, 14
    mov [enemy5_y_pos], r11

    mov r11, 24
    mov [enemy6_x_pos], r11
    mov r11, 14
    mov [enemy6_y_pos], r11

    mov r11, 27
    mov [enemy7_x_pos], r11
    mov r11, 14
    mov [enemy7_y_pos], r11

    mov r11, 30
    mov [enemy8_x_pos], r11
    mov r11, 14
    mov [enemy8_y_pos], r11

    mov r11, 9
    mov [enemy9_x_pos], r11
    mov r11, 16
    mov [enemy9_y_pos], r11

    mov r11, 12
    mov [enemy10_x_pos], r11
    mov r11, 16
    mov [enemy10_y_pos], r11

    mov r11, 15
    mov [enemy11_x_pos], r11
    mov r11, 16
    mov [enemy11_y_pos], r11

    mov r11, 18
    mov [enemy12_x_pos], r11
    mov r11, 16
    mov [enemy12_y_pos], r11

    mov r11, 21
    mov [enemy13_x_pos], r11
    mov r11, 16
    mov [enemy13_y_pos], r11

    mov r11, 24
    mov [enemy14_x_pos], r11
    mov r11, 16
    mov [enemy14_y_pos], r11

    mov r11, 27
    mov [enemy15_x_pos], r11
    mov r11, 16
    mov [enemy15_y_pos], r11

    mov r11, 30
    mov [enemy16_x_pos], r11
    mov r11, 16
    mov [enemy16_y_pos], r11

    mov r11, 9
    mov [enemy17_x_pos], r11
    mov r11, 18
    mov [enemy17_y_pos], r11

    mov r11, 12
    mov [enemy18_x_pos], r11
    mov r11, 18
    mov [enemy18_y_pos], r11

    mov r11, 15
    mov [enemy19_x_pos], r11
    mov r11, 18
    mov [enemy19_y_pos], r11

    mov r11, 18
    mov [enemy20_x_pos], r11
    mov r11, 18
    mov [enemy20_y_pos], r11

    mov r11, 21
    mov [enemy21_x_pos], r11
    mov r11, 18
    mov [enemy21_y_pos], r11

    mov r11, 24
    mov [enemy22_x_pos], r11
    mov r11, 18
    mov [enemy22_y_pos], r11

    mov r11, 27
    mov [enemy23_x_pos], r11
    mov r11, 18
    mov [enemy23_y_pos], r11

    mov r11, 30
    mov [enemy24_x_pos], r11
    mov r11, 18
    mov [enemy24_y_pos], r11

    mov r11, 9
    mov [enemy25_x_pos], r11
    mov r11, 20
    mov [enemy25_y_pos], r11

    mov r11, 12
    mov [enemy26_x_pos], r11
    mov r11, 20
    mov [enemy26_y_pos], r11

    mov r11, 15
    mov [enemy27_x_pos], r11
    mov r11, 20
    mov [enemy27_y_pos], r11

    mov r11, 18
    mov [enemy28_x_pos], r11
    mov r11, 20
    mov [enemy28_y_pos], r11

    mov r11, 21
    mov [enemy29_x_pos], r11
    mov r11, 20
    mov [enemy29_y_pos], r11

    mov r11, 24
    mov [enemy30_x_pos], r11
    mov r11, 20
    mov [enemy30_y_pos], r11

    mov r11, 27
    mov [enemy31_x_pos], r11
    mov r11, 20
    mov [enemy31_y_pos], r11

    mov r11, 30
    mov [enemy32_x_pos], r11
    mov r11, 20
    mov [enemy32_y_pos], r11


    mov r11, 1
    mov [ball_active], r11
    mov [one_active], r11

    mov [enemy1_active], r11
    mov [enemy2_active], r11
    mov [enemy3_active], r11
    mov [enemy4_active], r11
    mov [enemy5_active], r11
    mov [enemy6_active], r11
    mov [enemy7_active], r11
    mov [enemy8_active], r11
    mov [enemy9_active], r11
    mov [enemy10_active], r11
    mov [enemy11_active], r11
    mov [enemy12_active], r11
    mov [enemy13_active], r11
    mov [enemy14_active], r11
    mov [enemy15_active], r11
    mov [enemy16_active], r11 
    mov [enemy17_active], r11
    mov [enemy18_active], r11
    mov [enemy19_active], r11
    mov [enemy20_active], r11
    mov [enemy21_active], r11
    mov [enemy22_active], r11
    mov [enemy23_active], r11
    mov [enemy24_active], r11
    mov [enemy25_active], r11
    mov [enemy26_active], r11
    mov [enemy27_active], r11
    mov [enemy28_active], r11
    mov [enemy29_active], r11
    mov [enemy30_active], r11
    mov [enemy31_active], r11
    mov [enemy32_active], r11
    

    mov r11, 1
    mov [enemy_direction], r11
    mov r11, 120
    mov [enemy_move_time], r11
    mov r11, 1
    mov [enemy_direction_2], r11
    mov r11, 120
    mov [enemy_move_time_2], r11
    mov r11, 1
    mov [enemy_direction_3], r11
    mov r11, 120
    mov [enemy_move_time_3], r11
    mov r11, 1
    mov [enemy_direction_4], r11
    mov r11, 120
    mov [enemy_move_time_4], r11
    mov r11, 1
    mov [enemy_direction_5], r11
    mov r11, 120
    mov [enemy_move_time_5], r11
    mov r11, 1
    mov [enemy_direction_6], r11
    mov r11, 120
    mov [enemy_move_time_6], r11
    mov r11, 1
    mov [enemy_direction_7], r11
    mov r11, 120
    mov [enemy_move_time_7], r11
    mov r11, 1
    mov [enemy_direction_8], r11
    mov r11, 120
    mov [enemy_move_time_8], r11
    mov r11, 1
    mov [enemy_direction_9], r11
    mov r11, 120
    mov [enemy_move_time_9], r11
    mov r11, 1
    mov [enemy_direction_10], r11
    mov r11, 120
    mov [enemy_move_time_10], r11
    mov r11, 1
    mov [enemy_direction_11], r11
    mov r11, 120
    mov [enemy_move_time_11], r11
    mov r11, 1
    mov [enemy_direction_12], r11
    mov r11, 120
    mov [enemy_move_time_12], r11
    mov r11, 1
    mov [enemy_direction_13], r11
    mov r11, 120
    mov [enemy_move_time_13], r11
    mov r11, 1
    mov [enemy_direction_14], r11
    mov r11, 120
    mov [enemy_move_time_14], r11
    mov r11, 1
    mov [enemy_direction_15], r11
    mov r11, 120
    mov [enemy_move_time_15], r11
    mov r11, 1
    mov [enemy_direction_16], r11
    mov r11, 120
    mov [enemy_move_time_16], r11
    mov r11, 1
    mov [enemy_direction_17], r11
    mov r11, 120
    mov [enemy_move_time_17], r11
    mov r11, 1
    mov [enemy_direction_18], r11
    mov r11, 120
    mov [enemy_move_time_18], r11
    mov r11, 1
    mov [enemy_direction_19], r11
    mov r11, 120
    mov [enemy_move_time_19], r11
    mov r11, 1
    mov [enemy_direction_20], r11
    mov r11, 120
    mov [enemy_move_time_20], r11
    mov r11, 1
    mov [enemy_direction_21], r11
    mov r11, 120
    mov [enemy_move_time_21], r11
    mov r11, 1
    mov [enemy_direction_22], r11
    mov r11, 120
    mov [enemy_move_time_22], r11
    mov r11, 1
    mov [enemy_direction_23], r11
    mov r11, 120
    mov [enemy_move_time_23], r11
    mov r11, 1
    mov [enemy_direction_24], r11
    mov r11, 120
    mov [enemy_move_time_24], r11
    mov r11, 1
    mov [enemy_direction_25], r11
    mov r11, 120
    mov [enemy_move_time_25], r11
    mov r11, 1
    mov [enemy_direction_26], r11
    mov r11, 120
    mov [enemy_move_time_26], r11
    mov r11, 1
    mov [enemy_direction_27], r11
    mov r11, 120
    mov [enemy_move_time_27], r11
    mov r11, 1
    mov [enemy_direction_28], r11
    mov r11, 120
    mov [enemy_move_time_28], r11
    mov r11, 1
    mov [enemy_direction_29], r11
    mov r11, 120
    mov [enemy_move_time_29], r11
    mov r11, 1
    mov [enemy_direction_30], r11
    mov r11, 120
    mov [enemy_move_time_30], r11
    mov r11, 1
    mov [enemy_direction_31], r11
    mov r11, 120
    mov [enemy_move_time_31], r11
    mov r11, 1
    mov [enemy_direction_32], r11
    mov r11, 120
    mov [enemy_move_time_32], r11 
      
    ret

display_lifes:
    ; Convierte el puntaje a una cadena de texto
    mov rax, [lifes_count]
    mov rdi, lifes_str
    call int_to_str_2

    ; Muestra "vidas: "
    print lifes_msg, lifes_msg_length

    ; Muestra el valor del puntaje
    print lifes_str, 20
    ret

int_to_str_2:
    ; RDI = dirección donde almacenar la cadena
    ; RAX = entero que convertir
    xor rcx, rcx          ; contador de dígitos
    mov rbx, 10           ; divisor para obtener los dígitos

.convert_2:
    xor rdx, rdx          ; limpia el valor en RDX
    div rbx               ; divide RAX entre 10, RAX = cociente, RDX = residuo
    add dl, '0'           ; convierte el residuo en un carácter
    push rdx              ; guarda el carácter en la pila
    inc rcx               ; incrementa el contador de dígitos
    test rax, rax         ; verifica si RAX es 0
    jnz .convert_2          ; si no es 0, repite

.output_2:
    pop rdx               ; recupera el carácter de la pila
    mov [rdi], dl         ; almacena el carácter en la cadena
    inc rdi               ; mueve el puntero al siguiente carácter
    loop .output_2          ; repite para todos los dígitos

    mov byte [rdi], 0     ; termina la cadena con un carácter nulo
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    Function: move_pallet
; This function is in charge of moving the pallet in a given direction
; Arguments:
;    rdi: left direction or right direction
;
; Return:
;    void
move_pallet:
    cmp rdi, left_direction
    jne .move_right

.move_left:

    mov r8, [pallet_position]
    mov r9, [pallet_size]
 
    add r9, 1
    mov byte [r8  + r9 - 24], char_space
    mov byte [r8 - 43  + r9 - 24], char_space
    mov byte [r8 + 42 + r9 -24], char_space
    ;Limite izquierdo
    cmp r8, board + 1241
    jle .end ; No moverse si está en el borde izquierdo

    dec r8
    mov [pallet_position], r8
    jmp .end

.move_right:
    mov r8, [pallet_position]
    mov r9, [pallet_size]

    ;limite derecho
    add r8, r9
    sub r8, 3
    cmp r8, board + 1276
    jge .end ; No moverse si está en el borde derecho

    mov byte [r8 + 20], char_space ;segunda fila
    mov byte [r8 - 22], char_space ; primer fila
    mov byte [r8 - 63], char_space ; letra A

    inc r8
    mov [pallet_position], r8
.end:
    ret

bomb_colission:
    mov r8, [bomb_x_pos]       
    mov r9, [bomb_y_pos]        
    add r8, board               
    mov rax, column_cells + 2
    imul r9, rax                
    add r8, r9


    cmp byte [r8], '#'  ;letra M
    je .colli
    ret

.colli:
    mov r10, 1
    cmp [active_lifes], r10
    jne .no_life

    mov rax, [lifes_count]
    sub rax, 1
    mov [lifes_count], rax

    mov r13, 0
    mov [active_lifes], r13
    ret

.no_life:
    ret

bomb_colission_2:
    mov r8, [bomb_x_pos_6]       
    mov r9, [bomb_y_pos_6]        
    add r8, board               
    mov rax, column_cells + 2
    imul r9, rax                
    add r8, r9


    cmp byte [r8], '#'  
    je .colli_2
    ret

.colli_2:
    mov r10, 1
    cmp [active_lifes_2], r10
    jne .no_life_2

    mov rax, [lifes_count]
    sub rax, 1
    mov [lifes_count], rax

    mov r13, 0
    mov [active_lifes_2], r13
    ret

.no_life_2:
    ret

bomb_colission_3:
    mov r8, [bomb_x_pos_11]       
    mov r9, [bomb_y_pos_11]        
    add r8, board               
    mov rax, column_cells + 2
    imul r9, rax                
    add r8, r9

    cmp byte [r8], '#'  
    je .colli_3
    ret

.colli_3:
    mov r10, 1
    cmp [active_lifes_3], r10
    jne .no_life_3

    mov rax, [lifes_count]
    sub rax, 1
    mov [lifes_count], rax

    mov r13, 0
    mov [active_lifes_3], r13
    ret

.no_life_3:
    ret

bomb_colission_4:
    mov r8, [bomb_x_pos_22]       
    mov r9, [bomb_y_pos_22]        
    add r8, board               
    mov rax, column_cells + 2
    imul r9, rax                
    add r8, r9

    cmp byte [r8], '#'  
    je .colli_3
    ret

.colli_3:
    mov r10, 1
    cmp [active_lifes_4], r10
    jne .no_life_3

    mov rax, [lifes_count]
    sub rax, 1
    mov [lifes_count], rax

    mov r13, 0
    mov [active_lifes_4], r13
    ret

.no_life_3:
    ret

mandar_game_over:

    mov rax, [lifes_count]      
    cmp rax, 0        
    jne .no_game       
    jmp GameOver

.no_game:
    ret


wall_coli:

    mov r8, [bomb_x_pos]       
    mov r9, [bomb_y_pos]        
    add r8, board               
    mov rax, column_cells + 2
    imul r9, rax                
    add r8, r9

    cmp byte [r8], 'M'  ;letra M
    je .clear
    ret

.clear:
    mov byte [r8], char_space    ; Reemplaza la letra w con un espacio
    ; Desactivar la bomba
    sub r8, column_cells + 2     ; Mueve a la fila anterior
    mov byte [r8], char_space    ; Reemplaza la bala con un espacio
    mov r12, 0
    mov [bomb_active], r12
    ret 

wall_coli_2:

    mov r8, [bomb_x_pos_6]       
    mov r9, [bomb_y_pos_6]        
    add r8, board               
    mov rax, column_cells + 2
    imul r9, rax                
    add r8, r9

    cmp byte [r8], 'M'  ;letra M
    je .clear_2
    ret

.clear_2:
    mov byte [r8], char_space    ; Reemplaza la letra w con un espacio
    ; Desactivar la bomba
    sub r8, column_cells + 2     ; Mueve a la fila anterior
    mov byte [r8], char_space    ; Reemplaza la bala con un espacio
    mov r12, 0
    mov [bomb_active_6], r12
    ret 

wall_coli_3:

    mov r8, [bomb_x_pos_11]       
    mov r9, [bomb_y_pos_11]        
    add r8, board               
    mov rax, column_cells + 2
    imul r9, rax                
    add r8, r9

    cmp byte [r8], 'M'  ;letra M
    je .clear_3
    ret

.clear_3:
    mov byte [r8], char_space    ; Reemplaza la letra w con un espacio
    ; Desactivar la bomba
    sub r8, column_cells + 2     ; Mueve a la fila anterior
    mov byte [r8], char_space    ; Reemplaza la bala con un espacio
    mov r12, 0
    mov [bomb_active_11], r12
    ret 

wall_coli_4:

    mov r8, [bomb_x_pos_22]       
    mov r9, [bomb_y_pos_22]        
    add r8, board               
    mov rax, column_cells + 2
    imul r9, rax                
    add r8, r9

    cmp byte [r8], 'M'  ;letra M
    je .clear_4
    ret

.clear_4:
    mov byte [r8], char_space    ; Reemplaza la letra w con un espacio
    ; Desactivar la bomba
    sub r8, column_cells + 2     ; Mueve a la fila anterior
    mov byte [r8], char_space    ; Reemplaza la bala con un espacio
    mov r12, 0
    mov [bomb_active_22], r12
    ret 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
wait_time:

    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    sleeptime
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

_start:
    call canonical_off
    print clear, clear_length
    call start_screen

    call print_wall_1
    call print_wall_2
    call print_wall_3
    call print_wall_4
    call print_wall_5
    call print_wall_6
    call print_wall_7
    call print_wall_8
    call print_wall_9
    call print_wall_10
    call print_wall_11
    call print_wall_12
    call print_wall_13
    call print_wall_14
    call print_wall_15
    call print_wall_16
    call print_wall_17
    call print_wall_18
    call print_wall_19
    call print_wall_20

.main_loop:
    call wall_coli
    call wall_coli_2
    call wall_coli_3
    call wall_coli_4
    call print_enemy_0
    call toggle_enemy_visibility
    call bomb_enemy
    call bomb_enemy_6
    call bomb_enemy_11
    call bomb_enemy_22
    call mandar_game_over
    ;Fila 1 de enemigos
    call print_enemy_1
    call print_enemy_2
    call print_enemy_3
    call print_enemy_4
    call print_enemy_5
    call print_enemy_6
    call print_enemy_7
    call print_enemy_8

    ;Fila 2 de enemigos
    call print_enemy_9
    call print_enemy_10
    call print_enemy_11
    call print_enemy_12
    call print_enemy_13
    call print_enemy_14
    call print_enemy_15
    call print_enemy_16

    ;Fila 3 de enemigos
    call print_enemy_17
    call print_enemy_18
    call print_enemy_19
    call print_enemy_20
    call print_enemy_21
    call print_enemy_22
    call print_enemy_23
    call print_enemy_24

    ;Fila 4 de enemigos
    call print_enemy_25
    call print_enemy_26
    call print_enemy_27
    call print_enemy_28
    call print_enemy_29
    call print_enemy_30
    call print_enemy_31
    call print_enemy_32

    call update_shoot         
    call print_pallet 
    call check_collision
    call check_collision_2
    call check_collision_3
    call check_collision_4
    call check_collision_5
    call check_collision_6
    call check_collision_7
    call check_collision_8
    call check_collision_9
    call check_collision_10
    call check_collision_11
    call check_collision_12
    call check_collision_13
    call check_collision_14
    call check_collision_15
    call check_collision_16
    call check_collision_17
    call check_collision_18
    call check_collision_19
    call check_collision_20
    call check_collision_21
    call check_collision_22
    call check_collision_23
    call check_collision_24
    call check_collision_25
    call check_collision_26
    call check_collision_27
    call check_collision_28
    call check_collision_29
    call check_collision_30
    call check_collision_31
    call check_collision_32
    call bomb_colission
    call bomb_colission_2
    call bomb_colission_3
    call check_level_up
    print board, board_size
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
               ;Puntaje
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    call display_lifes
    call display_score
    call score_sum
    call score_sum_2
    call score_sum_3   
    call score_sum_4
    call score_sum_5
    call score_sum_6
    call score_sum_7   
    call score_sum_8
    call score_sum_9
    call score_sum_10
    call score_sum_11   
    call score_sum_12
    call score_sum_13
    call score_sum_14
    call score_sum_15   
    call score_sum_16
    call score_sum_17
    call score_sum_18
    call score_sum_19   
    call score_sum_20
    call score_sum_21
    call score_sum_22
    call score_sum_23  
    call score_sum_24
    call score_sum_25
    call score_sum_26
    call score_sum_27   
    call score_sum_28
    call score_sum_29
    call score_sum_30
    call score_sum_31   
    call score_sum_32

    ;setnonblocking

.read_more:
    getchar

    cmp rax, 1
    jne .done

    mov al, [input_char]

    cmp al, 'a'
    jne .not_left
    mov rdi, left_direction
    call move_pallet
    jmp .done

.not_left:
    cmp al, 'd'
    jne .not_right
    mov rdi, right_direction
    call move_pallet
    jmp .done

.not_right:
    cmp al, 'q'
    jne .shoot
    je exit

.shoot:   
    cmp al, 'b'
    jne .read_more
    call draw_shoot
    jmp .done

.done:
    ;unsetnonblocking
    sleeptime
    print clear, clear_length
    jmp .main_loop

    print clear, clear_length
    jmp exit

start_screen:
    print msg1, msg1_length
    mov rax, 0
    mov byte [input_char], 0

        .wait_loop:
        getchar
        mov al, [input_char]
        cmp al, 0
        je .wait_loop
    ;print msg2, msg2_length   
    ;getchar
    print clear, clear_length
    ret

GameOver:
    print clear, clear_length
    print gameoverboard, gmboard_size
    call wait_time
    ; Llamada a execve para reiniciar el juego
    mov rax, 59                          ; Número de syscall para execve
    lea rdi, [space_invaders_cmd]        ; Ruta del comando a ejecutar
    lea rsi, [space_invaders_argv]       ; Argumentos (en este caso no hay)
    lea rdx, [space_invaders_envp]       ; Variables de entorno (no utilizadas)
    syscall                              ; Ejecutar el comando

    ; Si execve falla, el juego terminará
    call canonical_on
    mov rax, 60                          ; syscall: exit
    mov rdi, 0                           ; estado de salida
    syscall

Level_2: 
    print clear, clear_length
    print level1board, gmboard_size
    call wait_time
    mov r12, 0
    mov [ban_level], r12
    print clear, clear_length
    call print_wall_1
    call print_wall_2
    call print_wall_3
    call print_wall_4
    call print_wall_5
    call print_wall_6
    call print_wall_7
    call print_wall_8
    call print_wall_9
    call print_wall_10
    call print_wall_11
    call print_wall_12
    call print_wall_13
    call print_wall_14
    call print_wall_15
    call print_wall_16
    call print_wall_17
    call print_wall_18
    call print_wall_19
    call print_wall_20
    ret

Level_3: 
    print clear, clear_length
    print level3board, gmboard_size
    call wait_time
    mov r12, 0
    mov [ban_level_2], r12
    print clear, clear_length
    call print_wall_1
    call print_wall_2
    call print_wall_3
    call print_wall_4
    call print_wall_5
    call print_wall_6
    call print_wall_7
    call print_wall_8
    call print_wall_9
    call print_wall_10
    call print_wall_11
    call print_wall_12
    call print_wall_13
    call print_wall_14
    call print_wall_15
    call print_wall_16
    call print_wall_17
    call print_wall_18
    call print_wall_19
    call print_wall_20
    ret

Level_4: 
    print clear, clear_length
    print level4board, gmboard_size
    call wait_time
    mov r12, 0
    mov [ban_level_3], r12
    print clear, clear_length
    call print_wall_1
    call print_wall_2
    call print_wall_3
    call print_wall_4
    call print_wall_5
    call print_wall_6
    call print_wall_7
    call print_wall_8
    call print_wall_9
    call print_wall_10
    call print_wall_11
    call print_wall_12
    call print_wall_13
    call print_wall_14
    call print_wall_15
    call print_wall_16
    call print_wall_17
    call print_wall_18
    call print_wall_19
    call print_wall_20

    ret

Level_5: 

    print clear, clear_length
    print level5board, gmboard_size
    call wait_time
    mov r12, 0
    mov [ban_level_4], r12
    print clear, clear_length
    call print_wall_1
    call print_wall_2
    call print_wall_3
    call print_wall_4
    call print_wall_5
    call print_wall_6
    call print_wall_7
    call print_wall_8
    call print_wall_9
    call print_wall_10
    call print_wall_11
    call print_wall_12
    call print_wall_13
    call print_wall_14
    call print_wall_15
    call print_wall_16
    call print_wall_17
    call print_wall_18
    call print_wall_19
    call print_wall_20
    ret

Level_f: 

    print clear, clear_length
    print levelfboard, lvfboard_size
    call wait_time
    ; Llamada a execve para reiniciar el juego
    mov rax, 59                          ; Número de syscall para execve
    lea rdi, [space_invaders_cmd]        ; Ruta del comando a ejecutar
    lea rsi, [space_invaders_argv]       ; Argumentos (en este caso no hay)
    lea rdx, [space_invaders_envp]       ; Variables de entorno (no utilizadas)
    syscall                              ; Ejecutar el comando

    ; Si execve falla, el juego terminará
    call canonical_on
    mov rax, 60                          ; syscall: exit
    mov rdi, 0                           ; estado de salida
    syscall

exit:
    call canonical_on
    mov rax, 60
    mov rdi, 0
    syscall
