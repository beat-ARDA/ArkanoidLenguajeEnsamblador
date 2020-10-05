.386

.model flat,stdcall

    option casemap:none

    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------
    ;                                               INCLUDES                                         |
    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------

    include \masm32\include\windows.inc
    include \masm32\include\user32.inc
    include \masm32\include\gdi32.inc
    include \masm32\include\kernel32.inc
    include \masm32\include\msimg32.inc
    include \masm32\include\winmm.inc
    include \masm32\include\msvcrt.inc
    includelib \masm32\lib\msvcrt.lib
    includelib \masm32\lib\user32.lib           
    includelib \masm32\lib\kernel32.lib
    includelib \masm32\lib\gdi32.lib
    includelib \masm32\lib\msimg32.lib
    includelib \masm32\lib\winmm.lib

    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------
    ;                                               PROTOS                                           |
    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------


    WinMain proto :DWORD,:DWORD,:DWORD,:DWORD

    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------
    ;                                           VARIABLES CONSTANTES                                 |
    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------

    VELOCIDAD_PLAYER equ 12

    ESPACIO_IZQUIERDA_CAJABLOQUES equ 196 ;ESPACIADO ENTRE CAJA
    ESPACIO_DERECHA_CAJABLOQUES equ 196   ;ESPACIADO ENTRE CAJA
    ESPACIO_TOP_CAJABLOQUES equ  98       ;ESPACIADO ENTRE CAJA

    ANCHO_CAJA_BLOQUES equ 392  ;TAMAÑO CAJA BLOQUES
    ALTURA_CAJA_BLOQUES equ 140 ;TAMAÑO CAJA BLOQUES

    BLOQUE_VISIBLE equ 0    ;VISIBILIDAD BLOQUE
    BLOQUE_NO_VISIBLE equ 1 ;VISIBILIDAD BLOQUE

    SIZE_BYTES_BLOQUE equ 15 ;TAMAÑO EN BYES DE LA ESTRUCTURA BLOQUE

    COLOR_ROJO equ 0 ;COLOR DE LOS BLOQUES
    COLOR_GRIS  equ 1 ;CPLOR DE LOS BLOQUES

    IDB_FONDOBOTONCONTINUAR equ 114    ;BITMAP
    IDB_BLOQUEGRISAGRIETADO equ 113    ;BITMAP
    IDB_BLOQUEROJO equ 111             ;BITMAP
    IDB_BLOQUEGRIS equ 112             ;BITMAP
    IDB_FONDO equ 101                  ;BITMAP
    IDB_FONDOBOTONJUGAR equ 102        ;BITMAP
    IDB_FONDOBOTONPUNTUACIONES equ 103 ;BITMAP
    IDB_FONDOBOTONSALIR equ 104        ;BITMAP
    IDB_FONDOJUGAR equ 105             ;BITMAP
    IDB_FONDOGANASTE equ 106           ;BITMAP
    IDB_FONDOPERDISTE equ 107          ;BITMAP
    IDB_FONDOPUNTUACIONES equ 108      ;BITMAP
    IDB_PLAYER equ 109                 ;BITMAP
    IDB_PELOTA equ 110                 ;BITMAP

    BTN_JUGAR equ 102        ;BOTON
    BTN_PUNTUACIONES equ 103 ;BOTON
    BTN_SALIR equ 104        ;BOTON
    BTN_CONTINUAR equ 105    ;BOTON

    STC_PUNTUACION equ 106   ;STATIC

    LTB_PUNTUACIONES equ 107 ;LISTBOX

    ANCHO_BOTON equ 300          ;MEDIDA BOTON
    ALTO_BOTON  equ 40           ;MEDIDA BOTON
    MITAD_ANCHO_BOTON equ 150    ;MEDIDA BOTON
    MITAD_ALTO_BOTON equ 20      ;MEDIDA BOTON
    ESPACIO_ENTRE_BOTONES equ 10 ;MEDIDA BOTON

    ANCHO_PELOTA equ 20          ;MEDIDA PELOTA
    ALTURA_PELOTA equ 20         ;MEDIDA PELOTA

    POSICION_INICIALX_PELOTA equ 384 ;POSICION INICIAL PELOTA
    POSICION_INICIALY_PELOTA equ 500 ;POSICION INICIAL PELOTA

    INICIO equ 0       ;ESTATUS JUEGO
    JUEGO equ 1        ;ESTATUS JUEGO
    GANASTE equ 2      ;ESTATUS JUEGO
    PERDISTE equ 3     ;ESTATUS JUEGO
    PUNTUACIONES equ 4 ;ESTATUS JUEGO

    POSICION_INICIALX_PLAYER equ 344 ;POSICION INICIAL PLAYER
    POSICION_INICIALY_PLAYER equ 520 ;POSICION INICIAL PLAYER

    ANCHO_PLAYER equ 100 ;MEDIDA PLAYER
    ALTURA_PLAYER equ 20 ;MEDIDA PLAYER

    myTimer equ 100 ;TIMER

    ESTADO_PARADO equ 0   ;ESTADO JUEGO
    ESTADO_INICIADO equ 1 ;ESTADO JUEGO

    TECLA_D equ 68       ;TECLA
    TECLA_A equ 65       ;TECLA
    TECLA_ESPACIO equ 32 ;TECLA

    TECLA_PRESIONADA equ TRUE     ;ESTADO TECLA
    TECLA_NO_PRESIONADA equ FALSE ;ESTADO TECLA

    LIMITE_PARED_DERECHA_PLAYER equ 654  ;LIMITE PARED PLAYER
    LIMITE_PARED_IZQUIERDA_PLAYER equ 34 ;LIMITE PARED PLAYER
    LIMITE_PARED_TOP_PLAYER equ 20       ;LIMITE PARED PLAYER

    LIMITE_PARED_DERECHA_PELOTA equ 730  ;LIMITE PARED PELOTA
    LIMITE_PARED_IZQUIERDA_PELOTA equ 34 ;LIMITE PARED PELOTA
    LIMITE_PARED_TOP_PELOTA equ 20       ;LIMITE PARED PELOTA

    ANCHO_PANTALLA equ 784  ;MEDIDA PANTALLA
    ALTURA_PANTALLA equ 561 ;MEDIDA PANTALLA

    QUIETA_PELOTA equ 0    ;DIRECCION PELOTA
    DERECHA_PELOTA equ 1   ;DIRECCION PELOTA
    IZQUIERDA_PELOTA equ 2 ;DIRECCION PELOTA
    ARRIBA_PELOTA equ 3    ;DIRECCION PELOTA
    ABAJO_PELOTA equ 4     ;DIRECCION PELOTA

    QUIETO_PLAYER equ 0    ;DIRECCION PLAYER
    DERECHA_PLAYER equ 1   ;DIRECCION PLAYER
    IZQUIERDA_PLAYER equ 2 ;DIRECCION PLAYER

    TECLA_D_Y_ESPACIO equ 0 ;TECLAS SIMULTANEAS
    TECLA_A_Y_ESPACIO equ 1 ;TECLAS SIMULTANEAS

    VELOCIDADY_PELOTA equ 10 ;VELOCIDAD PELOTA
    VELOCIDADX_PELOTA equ 10 ;VELOCIDAD PELOTA

    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------
    ;                                           VARIABLES INCIADAS                                   |
    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------

.DATA
    
    Bloque struct
       hBitmap dword NULL
       xBloque dword NULL
       yBloque dword NULL
       colorBloque byte NULL
       golpes byte NULL
       visible byte NULL
   Bloque ends
    
    contadorPuntos dword 0
    
    buffer byte 542 dup (0)
    inicio byte "04.wav"
    ganaste byte "03.wav", 0
    golpeBloque byte "01.wav", 0
    perdiste byte "02.wav", 0
    contadorBloquesDestruidos dword 0
    velocidadPelotax dword VELOCIDADX_PELOTA
    velocidadPelotay dword VELOCIDADY_PELOTA
    contadorColumnasBloques dword 0
    contadorBloques dword 0
    columnasBloques dword 0
    alturaBloque dword 0
    anchoBloque dword 0
    sizeBloques dword 0
    arregloBloque Bloque 12 dup ({})
    teclaPresionada db TECLA_NO_PRESIONADA
    EstadoJuego db ESTADO_PARADO
    direccionPlayerx db QUIETO_PLAYER
    direccionPelotax db QUIETA_PELOTA
    direccionPelotay db QUIETA_PELOTA
    xPelota dword 0
    yPelota dword 0
    xPlayer dword 0
    yPlayer dword 0
    EstatusJuego db INICIO
    ClassNameButton db "button", 0
    ClassNameStatic db "static", 0
    ClassNameListBox db "listbox", 0
    ClassName db "SimpleWinClass",0  
    AppName db "Arkanoid",0   

    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------
    ;                                       VARIABLES NO INICIADAS SISTEMA                           |
    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------

.DATA?     
    
    hInstance HINSTANCE ?        
    CommandLine LPSTR ?
    ps PAINTSTRUCT <?>
    rect RECT <?>
    hdc HDC ?
    hMemDC HDC ?

    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------
    ;                                       VARIABLES NO INICIADAS HANDLE                            |
    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------

    BitmapFondo dword ?                  ;BITMAP
    BitmapFondoBotonJugar dword ?        ;BITMAP
    BitmapFondoBotonPuntuaciones dword ? ;BITMAP
    BitmapFondoBotonSalir dword ?        ;BITMAP
    BitmapFondoJugar dword ?             ;BITMAP
    BitmapFondoGanaste dword ?           ;BITMAP
    BitmapFondoPerdiste dword ?          ;BITMAP
    BitmapFondoBotonContinuar dword ?    ;BITMAP
    BitmapFondoPuntuaciones dword ?      ;BITMAP
    BitmapPlayer dword ?                 ;BITMAP
    BitmapPelota dword ?                 ;BITMAP

    ButtonJugar dword ?        ;BOTON
    ButtonPuntuaciones dword ? ;BOTON
    ButtonSalir dword ?        ;BOTON
    ButtonContinuar dword ?    ;BOTON
    ListBoxPuntuaciones dword ? ;LISTBOX

    StaticPuntuacion dword ?   ;STATIC

    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------
    ;                                           INICIO DE CODIGO                                     |
    ;-------------------------------------------------------------------------------------------------
    ;-------------------------------------------------------------------------------------------------

.CODE        

    start:

    invoke GetModuleHandle, NULL 
                                                                      
        mov hInstance,eax
        invoke GetCommandLine                        
                                                                       
        mov CommandLine,eax
        invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT        
        invoke ExitProcess, eax             
        
        ;----------------------------------------------------------------------------------------------
        ;                                          INICIO WINMAIN                                     |
        ;----------------------------------------------------------------------------------------------

        WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
            LOCAL wc:WNDCLASSEX                                            
            LOCAL msg:MSG
            LOCAL hwnd:HWND

            mov   wc.cbSize, SIZEOF WNDCLASSEX                   
            mov   wc.style, CS_HREDRAW or CS_VREDRAW
            mov   wc.lpfnWndProc, OFFSET WndProc
            mov   wc.cbClsExtra,NULL
            mov   wc.cbWndExtra,NULL
            push  hInstance
            pop   wc.hInstance
            mov   wc.hbrBackground,COLOR_WINDOW+1
            mov   wc.lpszMenuName,NULL
            mov   wc.lpszClassName,OFFSET ClassName
            invoke LoadIcon,NULL,IDI_APPLICATION
            mov   wc.hIcon,eax
            mov   wc.hIconSm,eax
            invoke LoadCursor,NULL,IDC_ARROW
            mov   wc.hCursor,eax

            invoke RegisterClassEx, addr wc 
            
            invoke CreateWindowEx,NULL,\
                ADDR ClassName,\
                ADDR AppName,\
                WS_OVERLAPPEDWINDOW,\
                CW_USEDEFAULT,\
                CW_USEDEFAULT,\
                800,\
                600,\
                NULL,\
                NULL,\
                hInst,\
                NULL

            mov   hwnd,eax
            invoke ShowWindow, hwnd,CmdShow               
            invoke UpdateWindow, hwnd          
            
            invoke SetTimer, hwnd, myTimer, 30, NULL

            .WHILE TRUE                                                         
                invoke GetMessage, ADDR msg,NULL,0,0
                .BREAK .IF (!eax)
                invoke TranslateMessage, ADDR msg
                invoke DispatchMessage, ADDR msg
           .ENDW
            mov     eax,msg.wParam                                            
            ret
        WinMain endp

        ;-------------------------------------------------------------------------------------------------
        ;                                           INICIO WIN PROC                                      |
        ;-------------------------------------------------------------------------------------------------

        WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM

        ;-------------------------------------------------------------------------------------------------
        ;                                          WM_CREATE                                             |
        ;-------------------------------------------------------------------------------------------------

            .IF uMsg==WM_CREATE

                

                xor eax, eax                                                                                  ;INICIAR BOTON PUNTUACIONES
                invoke GetClientRect, hWnd, addr rect                                                         ;INICIAR BOTON PUNTUACIONES
                xor ebx, ebx                                                                                  ;INICIAR BOTON PUNTUACIONES
                xor eax, eax                                                                                  ;INICIAR BOTON PUNTUACIONES
                xor edx, edx                                                                                  ;INICIAR BOTON PUNTUACIONES
                mov eax, rect.right                                                                           ;INICIAR BOTON PUNTUACIONES
                mov ebx, 2                                                                                    ;INICIAR BOTON PUNTUACIONES
                div ebx                                                                                       ;INICIAR BOTON PUNTUACIONES
                sub eax, MITAD_ANCHO_BOTON                                                                    ;INICIAR BOTON PUNTUACIONES
                add eax, 2                                                                                    ;INICIAR BOTON PUNTUACIONES
                mov rect.left, 0                                                                              ;INICIAR BOTON PUNTUACIONES
                mov rect.left, eax                                                                            ;INICIAR BOTON PUNTUACIONES
                xor eax, eax                                                                                  ;INICIAR BOTON PUNTUACIONES
                xor ebx, ebx                                                                                  ;INICIAR BOTON PUNTUACIONES
                xor edx, edx                                                                                  ;INICIAR BOTON PUNTUACIONES
                mov eax, rect.bottom                                                                          ;INICIAR BOTON PUNTUACIONES
                mov ebx, 2                                                                                    ;INICIAR BOTON PUNTUACIONES
                div ebx                                                                                       ;INICIAR BOTON PUNTUACIONES
                sub eax, MITAD_ALTO_BOTON                                                                     ;INICIAR BOTON PUNTUACIONES
                mov rect.top, 0                                                                               ;INICIAR BOTON PUNTUACIONES
                mov rect.top, eax                                                                             ;INICIAR BOTON PUNTUACIONES
                xor eax, eax                                                                                  ;INICIAR BOTON PUNTUACIONES
                invoke CreateWindowEx, WS_EX_CLIENTEDGE, ADDR ClassNameListBox, NULL,\                         
                        WS_CHILD or WS_VISIBLE or LBS_STANDARD or\                                                 
                        ES_AUTOHSCROLL,\                                                                      
                        rect.left, rect.top, ANCHO_BOTON, 300, hWnd, LTB_PUNTUACIONES, hInstance, NULL 
                mov  ListBoxPuntuaciones, eax                                                                               

                xor eax, eax                  ;SACAR TAMAÑO BLOQUES
                xor ebx, eax                  ;SACAR TAMAÑO BLOQUES
                xor edx, edx                  ;SACAR TAMAÑO BLOQUES
                mov eax, sizeof arregloBloque ;SACAR TAMAÑO BLOQUES
                mov ebx, sizeof Bloque        ;SACAR TAMAÑO BLOQUES
                div ebx                       ;SACAR TAMAÑO BLOQUES
                mov sizeBloques, eax          ;SACAR TAMAÑO BLOQUES
                
                xor eax, eax                            ;INICIAR FONDO
                invoke LoadBitmap, hInstance, IDB_FONDO ;INICIAR FONDO
                mov BitmapFondo, eax                    ;INICIAR FONDO

                xor eax, eax                                 ;INICIAR FONDO JUGAR
                invoke LoadBitmap, hInstance, IDB_FONDOJUGAR ;INICIAR FONDO JUGAR
                mov BitmapFondoJugar, eax                    ;INICIAR FONDO JUGAR

                xor eax, eax                                   ;INICIAR FONDO GANASTE
                invoke LoadBitmap, hInstance, IDB_FONDOGANASTE ;INICIAR FONDO GANASTE
                mov BitmapFondoGanaste, eax                    ;INICIAR FONDO GANASTE

                xor eax, eax                                    ;INICIAR FONDO PERDISTE
                invoke LoadBitmap, hInstance, IDB_FONDOPERDISTE ;INICIAR FONDO PERDISTE
                mov BitmapFondoPerdiste, eax                    ;INICIAR FONDO PERDISTE

                xor eax, eax                                        ;INICIAR FONDO PUNTUACIONES
                invoke LoadBitmap, hInstance, IDB_FONDOPUNTUACIONES ;INICIAR FONDO PUNTUACIONES
                mov BitmapFondoPuntuaciones, eax                    ;INICIAR FONDO PUNTUACIONES

                 xor eax, eax                                                                             ;INICIAR FONDO BOTON CONINUAR
                invoke LoadImage, hInstance, IDB_FONDOBOTONCONTINUAR, IMAGE_BITMAP, 0, 0, LR_DEFAULTCOLOR ;INICIAR FONDO BOTON CONINUAR
                mov BitmapFondoBotonContinuar, eax                                                            ;INICIAR FONDO BOTON CONINUAR

                xor eax, eax                              ;INICIAR PLAYER
                invoke LoadBitmap, hInstance, IDB_PLAYER  ;INICIAR PLAYER
                mov BitmapPlayer, eax                     ;INICIAR PLAYER

                xor eax, eax                             ;INICIAR PELOTA
                invoke LoadBitmap, hInstance, IDB_PELOTA ;INICIAR PELOTA
                mov BitmapPelota, eax                    ;INICIAR PELOTA

                xor eax, eax                                                                           ;INICIAR BOTON JUGAR
                invoke GetClientRect, hWnd, addr rect                                                  ;INICIAR BOTON JUGAR
                xor ebx, ebx                                                                           ;INICIAR BOTON JUGAR
                xor edx, edx                                                                           ;INICIAR BOTON JUGAR
                mov eax, rect.right                                                                    ;INICIAR BOTON JUGAR
                mov ebx, 2                                                                             ;INICIAR BOTON JUGAR
                div ebx                                                                                ;INICIAR BOTON JUGAR
                sub eax, MITAD_ANCHO_BOTON                                                             ;INICIAR BOTON JUGAR
                add eax, 2                                                                             ;INICIAR BOTON JUGAR
                mov rect.left, 0                                                                       ;INICIAR BOTON JUGAR
                mov rect.left, eax                                                                     ;INICIAR BOTON JUGAR
                xor eax, eax                                                                           ;INICIAR BOTON JUGAR
                xor ebx, ebx                                                                           ;INICIAR BOTON JUGAR
                xor edx, edx                                                                           ;INICIAR BOTON JUGAR
                mov eax, rect.bottom                                                                   ;INICIAR BOTON JUGAR
                mov ebx, 2                                                                             ;INICIAR BOTON JUGAR
                div ebx                                                                                ;INICIAR BOTON JUGAR
                sub eax, MITAD_ALTO_BOTON                                                              ;INICIAR BOTON JUGAR
                sub eax, ESPACIO_ENTRE_BOTONES                                                         ;INICIAR BOTON JUGAR
                sub eax, ALTO_BOTON                                                                    ;INICIAR BOTON JUGAR
                mov rect.top, 0                                                                        ;INICIAR BOTON JUGAR
                mov rect.top, eax                                                                      ;INICIAR BOTON JUGAR
                xor eax, eax                                                                           ;INICIAR BOTON JUGAR
                invoke CreateWindowEx, WS_EX_CLIENTEDGE, ADDR ClassNameButton, NULL,\                  ;INICIAR BOTON JUGAR
                        WS_CHILD or WS_VISIBLE or ES_LEFT or\                                          ;INICIAR BOTON JUGAR
                        ES_AUTOHSCROLL,\                                                               ;INICIAR BOTON JUGAR
                        rect.left, rect.top, ANCHO_BOTON, ALTO_BOTON, hWnd, BTN_JUGAR, hInstance, NULL ;INICIAR BOTON JUGAR
                mov  ButtonJugar, eax                                                                  ;INICIAR BOTON JUGAR                             

                xor eax, eax                                                                                  ;INICIAR BOTON PUNTUACIONES
                invoke GetClientRect, hWnd, addr rect                                                         ;INICIAR BOTON PUNTUACIONES
                xor ebx, ebx                                                                                  ;INICIAR BOTON PUNTUACIONES
                xor eax, eax                                                                                  ;INICIAR BOTON PUNTUACIONES
                xor edx, edx                                                                                  ;INICIAR BOTON PUNTUACIONES
                mov eax, rect.right                                                                           ;INICIAR BOTON PUNTUACIONES
                mov ebx, 2                                                                                    ;INICIAR BOTON PUNTUACIONES
                div ebx                                                                                       ;INICIAR BOTON PUNTUACIONES
                sub eax, MITAD_ANCHO_BOTON                                                                    ;INICIAR BOTON PUNTUACIONES
                add eax, 2                                                                                    ;INICIAR BOTON PUNTUACIONES
                mov rect.left, 0                                                                              ;INICIAR BOTON PUNTUACIONES
                mov rect.left, eax                                                                            ;INICIAR BOTON PUNTUACIONES
                xor eax, eax                                                                                  ;INICIAR BOTON PUNTUACIONES
                xor ebx, ebx                                                                                  ;INICIAR BOTON PUNTUACIONES
                xor edx, edx                                                                                  ;INICIAR BOTON PUNTUACIONES
                mov eax, rect.bottom                                                                          ;INICIAR BOTON PUNTUACIONES
                mov ebx, 2                                                                                    ;INICIAR BOTON PUNTUACIONES
                div ebx                                                                                       ;INICIAR BOTON PUNTUACIONES
                sub eax, MITAD_ALTO_BOTON                                                                     ;INICIAR BOTON PUNTUACIONES
                mov rect.top, 0                                                                               ;INICIAR BOTON PUNTUACIONES
                mov rect.top, eax                                                                             ;INICIAR BOTON PUNTUACIONES
                xor eax, eax                                                                                  ;INICIAR BOTON PUNTUACIONES
                invoke CreateWindowEx, WS_EX_CLIENTEDGE, ADDR ClassNameButton, NULL,\                         
                        WS_CHILD or WS_VISIBLE or ES_LEFT or\                                                 
                        ES_AUTOHSCROLL,\                                                                      
                        rect.left, rect.top, ANCHO_BOTON, ALTO_BOTON, hWnd, BTN_PUNTUACIONES, hInstance, NULL 
                mov  ButtonPuntuaciones, eax                                                                  
                
                xor eax, eax                                                                           ;INICIAR BOTON SALIR
                invoke GetClientRect, hWnd, addr rect                                                  ;INICIAR BOTON SALIR
                xor ebx, ebx                                                                           ;INICIAR BOTON SALIR
                xor eax, eax                                                                           ;INICIAR BOTON SALIR
                xor edx, edx                                                                           ;INICIAR BOTON SALIR
                mov eax, rect.right                                                                    ;INICIAR BOTON SALIR
                mov ebx, 2                                                                             ;INICIAR BOTON SALIR
                div ebx                                                                                ;INICIAR BOTON SALIR
                sub eax, MITAD_ANCHO_BOTON                                                             ;INICIAR BOTON SALIR
                add eax, 2                                                                             ;INICIAR BOTON SALIR
                mov rect.left, 0                                                                       ;INICIAR BOTON SALIR
                mov rect.left, eax                                                                     ;INICIAR BOTON SALIR
                xor eax, eax                                                                           ;INICIAR BOTON SALIR
                xor ebx, ebx                                                                           ;INICIAR BOTON SALIR
                xor edx, edx                                                                           ;INICIAR BOTON SALIR
                mov eax, rect.bottom                                                                   ;INICIAR BOTON SALIR
                mov ebx, 2                                                                             ;INICIAR BOTON SALIR
                div ebx                                                                                ;INICIAR BOTON SALIR
                add eax, MITAD_ALTO_BOTON                                                              ;INICIAR BOTON SALIR
                add eax, ESPACIO_ENTRE_BOTONES                                                         ;INICIAR BOTON SALIR
                mov rect.top, 0                                                                        ;INICIAR BOTON SALIR
                mov rect.top, eax                                                                      ;INICIAR BOTON SALIR
                xor eax, eax                                                                           ;INICIAR BOTON SALIR
                invoke CreateWindowEx, WS_EX_CLIENTEDGE, ADDR ClassNameButton, NULL,\                  ;INICIAR BOTON SALIR
                        WS_CHILD or WS_VISIBLE or ES_LEFT or\                                          ;INICIAR BOTON SALIR
                        ES_AUTOHSCROLL,\                                                               ;INICIAR BOTON SALIR
                        rect.left, rect.top, ANCHO_BOTON, ALTO_BOTON, hWnd, BTN_SALIR, hInstance, NULL ;INICIAR BOTON SALIR
                mov  ButtonSalir, eax                                                                  ;INICIAR BOTON SALIR

                xor eax, eax                                                                               ;INICIAR BOTON CONTINUAR
                invoke GetClientRect, hWnd, addr rect                                                      ;INICIAR BOTON CONTINUAR
                xor ebx, ebx                                                                               ;INICIAR BOTON CONTINUAR
                xor edx, edx                                                                               ;INICIAR BOTON CONTINUAR
                mov eax, rect.right                                                                        ;INICIAR BOTON CONTINUAR
                mov ebx, 2                                                                                 ;INICIAR BOTON CONTINUAR
                div ebx                                                                                    ;INICIAR BOTON CONTINUAR
                sub eax, MITAD_ANCHO_BOTON                                                                 ;INICIAR BOTON CONTINUAR                                                                             ;INICIAR BOTON CONTINUAR
                mov rect.left, 0                                                                           ;INICIAR BOTON CONTINUAR
                mov rect.left, eax                                                                         ;INICIAR BOTON CONTINUAR
                xor eax, eax                                                                               ;INICIAR BOTON CONTINUAR
                xor ebx, ebx                                                                               ;INICIAR BOTON CONTINUAR
                xor edx, edx                                                                               ;INICIAR BOTON CONTINUAR
                mov eax, rect.bottom                                                                       ;INICIAR BOTON CONTINUAR
                mov ebx, 2                                                                                 ;INICIAR BOTON CONTINUAR
                div ebx                                                                                    ;INICIAR BOTON CONTINUAR
                sub eax, MITAD_ALTO_BOTON                                                                  ;INICIAR BOTON CONTINUAR
                sub eax, ESPACIO_ENTRE_BOTONES                                                             ;INICIAR BOTON CONTINUAR
                sub eax, ALTO_BOTON                                                                        ;INICIAR BOTON CONTINUAR
                mov rect.top, 0                                                                            ;INICIAR BOTON CONTINUAR
                mov rect.top, eax                                                                          ;INICIAR BOTON CONTINUAR
                xor eax, eax                                                                               ;INICIAR BOTON CONTINUAR
                invoke CreateWindowEx, WS_EX_CLIENTEDGE, ADDR ClassNameButton, NULL,\                      
                        WS_CHILD or WS_VISIBLE or ES_LEFT or\                                              ;INICIAR BOTON CONTINUAR
                        ES_AUTOHSCROLL,\                                                                   ;INICIAR BOTON CONTINUAR
                        rect.left, rect.top, ANCHO_BOTON, ALTO_BOTON, hWnd, BTN_CONTINUAR, hInstance, NULL ;INICIAR BOTON CPNTINUAR
                mov  ButtonContinuar, eax                                                                  ;INICIAR BOTON CONTINUAR

                xor eax, eax                                                                                  ;INICIAR STATIC PUNTUACIONES
                invoke GetClientRect, hWnd, addr rect                                                         ;INICIAR STATIC PUNTUACIONES
                xor ebx, ebx                                                                                  ;INICIAR STATIC PUNTUACIONES
                xor eax, eax                                                                                  ;INICIAR STATIC PUNTUACIONES
                xor edx, edx                                                                                  ;INICIAR STATIC PUNTUACIONES
                mov eax, rect.right                                                                           ;INICIAR STATIC PUNTUACIONES
                mov ebx, 2                                                                                    ;INICIAR STATIC PUNTUACIONES
                div ebx                                                                                       ;INICIAR STATIC PUNTUACIONES
                sub eax, MITAD_ANCHO_BOTON                                                                    ;INICIAR STATIC PUNTUACIONES
                mov rect.left, 0                                                                              ;INICIAR STATIC PUNTUACIONES
                mov rect.left, eax                                                                            ;INICIAR STATIC PUNTUACIONES
                xor eax, eax                                                                                  ;INICIAR STATIC PUNTUACIONES
                xor ebx, ebx                                                                                  ;INICIAR STATIC PUNTUACIONES
                xor edx, edx                                                                                  ;INICIAR STATIC PUNTUACIONES
                mov eax, rect.bottom                                                                          ;INICIAR STATIC PUNTUACIONES
                mov ebx, 2                                                                                    ;INICIAR STATIC PUNTUACIONES
                div ebx                                                                                       ;INICIAR STATIC PUNTUACIONES
                add eax, MITAD_ALTO_BOTON                                                                     ;INICIAR STATIC PUNTUACIONES
                mov rect.top, 0                                                                               ;INICIAR STATIC PUNTUACIONES
                mov rect.top, eax                                                                             ;INICIAR STATIC PUNTUACIONES
                xor eax, eax                                                                                  ;INICIAR STATIC PUNTUACIONES
                invoke CreateWindowEx, WS_EX_CLIENTEDGE, ADDR ClassNameStatic, NULL,\                         
                        WS_CHILD or WS_VISIBLE or SS_CENTER or\                                                 
                        ES_AUTOHSCROLL,\                                                                      
                        rect.left, rect.top, ANCHO_BOTON, ALTO_BOTON, hWnd, STC_PUNTUACION, hInstance, NULL   
                mov  StaticPuntuacion, eax                                                                  ;INICIAR STATIC PUNTUACIONES 

        ;-------------------------------------------------------------------------------------------------
        ;                                           WM_PAINT                                             |
        ;-------------------------------------------------------------------------------------------------

            .ELSEIF uMsg==WM_PAINT
                
                xor eax, eax                     ;INICIAR FASE DE PINTADO
                invoke BeginPaint, hWnd, ADDR ps ;INICIAR FASE DE PINTADO
                mov hdc, eax                     ;INICIAR FASE DE PINTADO
                xor eax, eax                     ;INICIAR FASE DE PINTADO
                invoke CreateCompatibleDC, hdc   ;INICIAR FASE DE PINTADO
                mov hMemDC, eax                  ;INICIAR FASE DE PINTADO

                .IF EstatusJuego == INICIO ;ESTATUS INICIO ////////////////////////////////////////////////////////////////////////
                    
                    

                    invoke GetClientRect, hWnd, addr rect                                    ;PINTAR FONDO
                    invoke SelectObject, hMemDC, BitmapFondo                                 ;PINTAR FONDO
                    invoke BitBlt, hdc, 0, 0, rect.right, rect.bottom, hMemDC, 0, 0, SRCCOPY ;PINTAR FONDO

                    invoke ShowWindow, ButtonJugar, TRUE        ;MOSTRAR BOTONES
                    invoke ShowWindow, ButtonPuntuaciones, TRUE ;MOSTRAR BOTONES
                    invoke ShowWindow, ButtonSalir, TRUE        ;MOSTRAR BOTONES

                    invoke ShowWindow, ButtonContinuar, FALSE     ;OCULTAR BOTONES
                    invoke ShowWindow, StaticPuntuacion, FALSE    ;OCULTAR BOTONES
                    invoke ShowWindow, ListBoxPuntuaciones, FALSE ;OCULTAR BOTONES

                    xor eax, eax                                                                          ;PINTAR FONDO BOTON JUGAR
                    invoke LoadImage, hInstance, IDB_FONDOBOTONJUGAR, IMAGE_BITMAP, 0, 0, LR_DEFAULTCOLOR ;PINTAR FONDO BOTON JUGAR
                    mov BitmapFondoBotonJugar, eax                                                        ;PINTAR FONDO BOTON JUGAR
                    invoke SendMessage, ButtonJugar, BM_SETIMAGE, IMAGE_BITMAP, BitmapFondoBotonJugar     ;PINTAR FONDO BOTON JUGAR

                    xor eax, eax                                                                                    ;PINTAR FONDO BOTON PUNTUACIONES
                    invoke LoadImage, hInstance, IDB_FONDOBOTONPUNTUACIONES, IMAGE_BITMAP, 0, 0, LR_DEFAULTCOLOR    ;PINTAR FONDO BOTON PUNTUACIONES
                    mov BitmapFondoBotonPuntuaciones, eax                                                           ;PINTAR FONDO BOTON PUNTUACIONES
                    invoke SendMessage, ButtonPuntuaciones, BM_SETIMAGE, IMAGE_BITMAP, BitmapFondoBotonPuntuaciones ;PINTAR FONDO BOTON PUNTUACIONES

                    xor eax, eax                                                                          ;PINTAR FONDO BOTON SALIR
                    invoke LoadImage, hInstance, IDB_FONDOBOTONSALIR, IMAGE_BITMAP, 0, 0, LR_DEFAULTCOLOR ;PINTAR FONDO BOTON SALIR
                    mov BitmapFondoBotonSalir, eax                                                        ;PINTAR FONDO BOTON SALIR
                    invoke SendMessage, ButtonSalir, BM_SETIMAGE, IMAGE_BITMAP, BitmapFondoBotonSalir     ;PINTAR FONDO BOTON SALIR

                .ELSEIF EstatusJuego == JUEGO ;ESTATUS JUEGO //////////////////////////////////////////////////////////////////////
                    
                   

                    invoke GetClientRect, hWnd, addr rect                                    ;PINTAR FONDO JUGAR
                    invoke SelectObject, hMemDC, BitmapFondoJugar                            ;PINTAR FONDO JUGAR
                    invoke BitBlt, hdc, 0, 0, rect.right, rect.bottom, hMemDC, 0, 0, SRCCOPY ;PINTAR FONDO JUGAR

                    invoke ShowWindow, ButtonContinuar, FALSE        ;OCULTAR BOTONES

                    .IF sizeBloques > 0 ;SI LA CANTIDADDE BLOQUES ES MAYOR QUE CERO

                        xor edx, edx                 ;CALCULAR ALTURA DEL BLOQUE
                        xor eax, edx                 ;CALCULAR ALTURA DEL BLOQUE
                        xor ebx, edx                 ;CALCULAR ALTURA DEL BLOQUE
                        mov eax, ALTURA_CAJA_BLOQUES ;CALCULAR ALTURA DEL BLOQUE
                        mov ebx, 4                   ;CALCULAR ALTURA DEL BLOQUE
                        div ebx                      ;CALCULAR ALTURA DEL BLOQUE
                        mov alturaBloque, eax        ;CALCULAR ALTURA DEL BLOQUE

                        mov ebx, 0                  ;CALCULAR ANCHO DEL BLOQUE
                        mov edx, 0                  ;CALCULAR ANCHO DEL BLOQUE
                        mov eax, 0                  ;CALCULAR ANCHO DEL BLOQUE
                        mov eax, sizeBloques        ;CALCULAR ANCHO DEL BLOQUE
                        mov ebx, 3                  ;CALCULAR ANCHO DEL BLOQUE
                        div ebx                     ;CALCULAR ANCHO DEL BLOQUE
                        .IF sizeBloques <= 5        ;CALCULAR ANCHO DEL BLOQUE
                            mov eax, sizeBloques    ;CALCULAR ANCHO DEL BLOQUE
                        .ENDIF                      ;CALCULAR ANCHO DEL BLOQUE
                        mov columnasBloques, eax    ;CALCULAR ANCHO DEL BLOQUE
                        mov edx, 0                  ;CALCULAR ANCHO DEL BLOQUE
                        mov ebx, 0                  ;CALCULAR ANCHO DEL BLOQUE
                        mov ebx, eax                ;CALCULAR ANCHO DEL BLOQUE
                        xor eax, eax                ;CALCULAR ANCHO DEL BLOQUE
                        mov eax, ANCHO_CAJA_BLOQUES ;CALCULAR ANCHO DEL BLOQUE
                        div ebx                     ;CALCULAR ANCHO DEL BLOQUE
                        mov anchoBloque, eax        ;CALCULAR ANCHO DEL BLOQUE

                        xor ecx, ecx ;LIMPIAR ECX

                        mov contadorBloques, 0 ;LIMPIAR CONTADOR BLOQUES

                        PintarBloquesFilas: ;BUCLE PARA PINTAR LOS BLOQUES
         
                            mov contadorColumnasBloques, 0 ;LIMPIAR CONTADOR DE COLUMNAS

                            xor eax, eax             ;ESTABLECER CONDICIONES WHILE
                            xor ebx, ebx             ;ESTABLECER CONDICIONES WHILE
                            mov eax, columnasBloques ;ESTABLECER CONDICIONES WHILE
                            mov ebx, sizeBloques     ;ESTABLECER CONDICIONES WHILE

                            .while contadorColumnasBloques < eax && contadorBloques < ebx ;MIENTRAS NO SE ACABEN LAS COLUMNAS O BLOQUES
            
                                xor eax, eax               ;OBTENER INDICE DEL ARREGLO
                                xor ebx, ebx               ;OBTENER INDICE DEL ARREGLO
                                mov eax, SIZE_BYTES_BLOQUE ;OBTENER INDICE DEL ARREGLO
                                mov ebx, contadorBloques   ;OBTENER INDICE DEL ARREGLO
                                mul ebx                    ;OBTENER INDICE DEL ARREGLO
                                 
                                push ecx
                                xor ebx, ebx ;PASAR INDICE ARREGLO
                                mov ebx, eax ;PASAR INDICE ARREGLO 

                                invoke SelectObject,hMemDC,arregloBloque[ebx].hBitmap

                                xor eax, eax                            ;OBTENER COOREDENADA X BLOQUE
                                xor ecx, ecx                            ;OBTENER COOREDENADA X BLOQUE
                                mov eax, anchoBloque                    ;OBTENER COOREDENADA X BLOQUE
                                mov ecx, contadorColumnasBloques        ;OBTENER COOREDENADA X BLOQUE
                                mul ecx                                 ;OBTENER COOREDENADA X BLOQUE
                                add eax, ESPACIO_IZQUIERDA_CAJABLOQUES  ;OBTENER COOREDENADA X BLOQUE
                                mov arregloBloque[ebx].xBloque, eax     ;OBTENER COOREDENADA X BLOQUE

                                xor eax, eax                        ;OBTENER COOREDENADA Y BLOQUE
                                xor ecx, ecx                        ;OBTENER COOREDENADA Y BLOQUE
                                mov eax, alturaBloque               ;OBTENER COOREDENADA Y BLOQUE
                                pop ecx                             ;OBTENER COOREDENADA Y BLOQUE
                                mul ecx                             ;OBTENER COOREDENADA Y BLOQUE
                                push ecx                            ;OBTENER COOREDENADA Y BLOQUE
                                add eax, ESPACIO_TOP_CAJABLOQUES    ;OBTENER COOREDENADA Y BLOQUE
                                mov arregloBloque[ebx].yBloque, eax ;OBTENER COOREDENADA Y BLOQUE

                                .IF arregloBloque[ebx].visible == BLOQUE_VISIBLE ; SI EL BLOQUE ES VISIBLE //////////////////////////////////////////////////////////////////////
                                    
                                    invoke StretchBlt, hdc, arregloBloque[ebx].xBloque, arregloBloque[ebx].yBloque, anchoBloque, alturaBloque, hMemDC, 0, 0, 60, 20, SRCCOPY;PAREDIZQ
            
                                .ELSEIF arregloBloque[ebx].visible == BLOQUE_NO_VISIBLE ;SI EL BLOQUE NO ES VISIBLE ///////////////////////////////////////////////////////////////////
               
                                    mov arregloBloque[ebx].xBloque, 0               ;ESTABLECER DATOS DE BLOQUE NO VISIBLE
                                    mov arregloBloque[ebx].yBloque, 0               ;ESTABLECER DATOS DE BLOQUE NO VISIBLE
                                   
                                    invoke DeleteObject, arregloBloque[ebx].hBitmap ;ESTABLECER DATOS DE BLOQUE NO VISIBLE

                                .ENDIF

                                xor ecx, ecx ;RECUPERAR BANDERA ECX
                                pop ecx      ;RECUPERAR BANDERA ECX

                                inc contadorBloques         ;INCREMENTAR VARIABLES CONTADORAS
                                inc contadorColumnasBloques ;INCREMENTAR VARIABLES CONTADORAS

                                xor eax, eax             ;REESTABLECER CONDICIONES EN LOS REGISTROS
                                xor ebx, ebx             ;REESTABLECER CONDICIONES EN LOS REGISTROS
                                mov eax, columnasBloques ;REESTABLECER CONDICIONES EN LOS REGISTROS
                                mov ebx, sizeBloques     ;REESTABLECER CONDICIONES EN LOS REGISTROS

                           .ENDW

                           mov contadorColumnasBloques, 0
                           mov edx, 0
                           mov eax, 0
                           mov eax, sizeBloques
                           mov ebx, 0
                           mov ebx, 3
                           div ebx

                          .IF eax > 0 && edx == 0; En caso de que no sobren bloques ////////////////////////////////////////////////////////
                              mov eax, 0 ;ESTABLECER TRES FILAS
                              mov eax, 2 ;ESTABLECER TRES FILAS
                          .ELSEIF eax >= 0 && edx > 0  ;EN CASO DE SOBREN BLOQUES////////////////////////////////////////////////////////////   
                              mov eax, 0 ;ESTABLECER 4 FILAS
                              mov eax, 3 ;ESTABLECER 4 FILAS
                          .ENDIF

                          inc ecx      ;COMPARAR CICLO
                          cmp ecx, eax ;COMPARAR CICLO

                      jle PintarBloquesFilas

                      mov contadorBloques, 0

                  .ENDIF

                    invoke SelectObject, hMemDC, BitmapPlayer                                            ;PINTAR PLAYER
                    invoke BitBlt, hdc, xPlayer, yPlayer, rect.right, rect.bottom, hMemDC, 0, 0, SRCCOPY ;PINTAR PLAYER

                    invoke SelectObject, hMemDC, BitmapPelota                                            ;PINTAR PELOTA
                    invoke BitBlt, hdc, xPelota, yPelota, rect.right, rect.bottom, hMemDC, 0, 0, SRCCOPY ;PINTAR PELOTA

                .ELSEIF EstatusJuego == GANASTE ;ESTATUS GANASTE //////////////////////////////////////////////////////////////////
                    
                    invoke GetClientRect, hWnd, addr rect                                    ;PINTAR FONDO GANASTE
                    invoke SelectObject, hMemDC, BitmapFondoGanaste                          ;PINTAR FONDO GANASTE
                    invoke BitBlt, hdc, 0, 0, rect.right, rect.bottom, hMemDC, 0, 0, SRCCOPY ;PINTAR FONDO GANASTE

                .ELSEIF EstatusJuego == PERDISTE ;ESTATUS PERDISTE ////////////////////////////////////////////////////////////////
                    
                    invoke GetClientRect, hWnd, addr rect                                    ;PINTAR FONDO PERDISTE
                    invoke SelectObject, hMemDC, BitmapFondoPerdiste                         ;PINTAR FONDO PERDISTE
                    invoke BitBlt, hdc, 0, 0, rect.right, rect.bottom, hMemDC, 0, 0, SRCCOPY ;PINTAR FONDO PERDISTE

                .ELSEIF EstatusJuego == PUNTUACIONES ;ESTATUS PUNTUACIONES //////////////////////////////////////////////////////// 
                    
                    
                    invoke GetClientRect, hWnd, addr rect                                    ;PINTAR FONDO PUNTUACIONES
                    invoke SelectObject, hMemDC, BitmapFondoPuntuaciones                     ;PINTAR FONDO PUNTUACIONES
                    invoke BitBlt, hdc, 0, 0, rect.right, rect.bottom, hMemDC, 0, 0, SRCCOPY ;PINTAR FONDO PUNTUACIONES 

                    invoke SendMessage, ButtonContinuar, BM_SETIMAGE, IMAGE_BITMAP, BitmapFondoBotonContinuar     ;PINTAR FONDO BOTON JUGAR


                .ENDIF

                invoke DeleteDC, hMemDC      ;FINALIZAR FASE DE PINTADO
                invoke EndPaint,hWnd,addr ps ;FINALIZAR FASE DE PINTADO

        ;-------------------------------------------------------------------------------------------------
        ;                                          WM_COMMAND                                            |
        ;-------------------------------------------------------------------------------------------------

            .ELSEIF uMsg==WM_COMMAND

                xor eax, eax
                mov eax,wParam

                .IF al==BTN_JUGAR ;SI PRESIONO JUGAR////////////////////////////////////////////////////////////////////////////////
                    
                    xor eax, eax           ;FUNCION SEMILLA DE NUMERO ALEATORIO
                    sub esp, 8             ;FUNCION SEMILLA DE NUMERO ALEATORIO   
                    mov DWORD PTR [esp], 0 ;FUNCION SEMILLA DE NUMERO ALEATORIO   
                    invoke crt_time        ;FUNCION SEMILLA DE NUMERO ALEATORIO                 
                    mov [esp], eax         ;FUNCION SEMILLA DE NUMERO ALEATORIO   
                    invoke crt_srand       ;FUNCION SEMILLA DE NUMERO ALEATORIO   

                    xor ecx, ecx ;LIMPIAR ECX

                    IniciarBloques: ;BUCLE CREAR BLOQUES**************************************************************************

                        push ecx ;GUARDAR ECX EN LA PILA

                        invoke crt_rand ;GENERAR NUMERO ALEATORIO
                        xor edx, edx     ;GENERAR NUMERO ALEATORIO
                        xor ebx, ebx    ;GENERAR NUMERO ALEATORIO
                        mov ebx, 2      ;GENERAR NUMERO ALEATORIO
                        div ebx         ;GENERAR NUMERO ALEATORIO

                        .IF edx==COLOR_ROJO ;SI EL RESTO ES DE LA DIVISION ES CERO////////////////////////////////////////////////////////
                       
                            invoke LoadBitmap,hInstance,IDB_BLOQUEROJO ;CARGAR BITMAP

                            xor ebx, ebx ;GUARDAR BITMAP EN EBX
                            mov ebx, eax ;GUARDAR BITMAP EN EBX

                            xor ecx, ecx                     ;OBTENER INDICE ARREGLO
                            pop ecx                          ;OBTENER INDICE ARREGLO
                            xor eax, eax                     ;OBTENER INDICE ARREGLO
                            mov eax, SIZE_BYTES_BLOQUE       ;OBTENER INDICE ARREGLO
                            mul ecx                          ;OBTENER INDICE ARREGLO
                            push ecx                         ;OBTENER INDICE ARREGLO
                            
                            mov arregloBloque[eax].hBitmap, 0
                            mov arregloBloque[eax].hBitmap, ebx            ;GUARDAR DATOS INICIALES
                            mov arregloBloque[eax].colorBloque, COLOR_ROJO ;GUARDAR DATOS INICIALES
                            mov arregloBloque[eax].visible, BLOQUE_VISIBLE ;GUARDAR DATOS INICIALES
                            mov arregloBloque[eax].golpes,  0              ;GUARDAR DATOS INICIALES

                        .ELSEIF edx==COLOR_GRIS ;SI EL RESTO DE LA DIVISION ES 1//////////////////////////////////////////////////////////

                            invoke LoadBitmap, hInstance, IDB_BLOQUEGRIS ;CARGAR BITMPA GRIS

                            xor ebx, ebx ;GUARDAR BITMAP EN EBX
                            mov ebx, eax ;GUARDAR BITMAP 1 EN EBX

                            xor ecx, ecx                     ;OBTENER INDICE ARREGLO
                            pop ecx                          ;OBTENER INDICE ARREGLO
                            xor eax, eax                     ;OBTENER INDICE ARREGLO
                            mov eax, SIZE_BYTES_BLOQUE       ;OBTENER INDICE ARREGLO
                            mul ecx                          ;OBTENER INDICE ARREGLO
                            push ecx                         ;OBTENER INDICE ARREGLO

                            mov arregloBloque[eax].hBitmap, 0
                            
                            mov arregloBloque[eax].hBitmap, ebx                ;CARGAR DATOS INICIALES BLOQUE
                            mov arregloBloque[eax].colorBloque, COLOR_GRIS     ;CARGAR DATOS INICIALES BLOQUE
                            mov arregloBloque[eax].visible, BLOQUE_VISIBLE     ;CARGAR DATOS INICIALES BLOQUE
                             mov arregloBloque[eax].golpes,  0                 ;GUARDAR DATOS INICIALES BLOQUES

                        .ENDIF
         
                        pop ecx
                        inc ecx    
                        cmp ecx, sizeBloques

                    jl IniciarBloques  

                    xor eax, eax                      ;COORDENADAS INICIALES PELOTA
                    mov eax, POSICION_INICIALX_PELOTA ;COORDENADAS INICIALES PELOTA
                    mov xPelota, eax                  ;COORDENADAS INICIALES PELOTA
                    xor eax, eax                      ;COORDENADAS INICIALES PELOTA
                    mov eax, POSICION_INICIALY_PELOTA ;COORDENADAS INICIALES PELOTA
                    mov yPelota, eax                  ;COORDENADAS INICIALES PELOTA

                    xor eax, eax
                    mov eax, POSICION_INICIALX_PLAYER ;COORDENADAS INICIALES PLAYER
                    mov xPlayer, eax                  ;COORDENADAS INICIALES PLAYER
                    xor eax, eax                      ;COORDENADAS INICIALES PLAYER
                    mov eax, POSICION_INICIALY_PLAYER ;COORDENADAS INICIALES PLAYER
                    mov yPlayer, eax                  ;COORDENADAS INICIALES PLAYER

                    mov direccionPlayerx, QUIETO_PLAYER ;ESTABLECER DIRECCION PLAYER

                    mov direccionPelotax, QUIETA_PELOTA ;ESTABLECER DIRECCION PELOTA
                    mov direccionPelotay, QUIETA_PELOTA ;ESTABLECER DIRECCION PELOTA

                    invoke ShowWindow, ButtonJugar, FALSE         ;OCULTAR BOTON INICIO
                    invoke ShowWindow, ButtonPuntuaciones, FALSE  ;OCULTAR BOTON INICIO
                    invoke ShowWindow, ButtonSalir, FALSE         ;OCULTAR BOTON INICIO
                    invoke ShowWindow, ListBoxPuntuaciones, FALSE ;OCULTAR BOTON INICIO

                    mov EstatusJuego, JUEGO ;CAMBIAR ESTATUS DEL JUEGO

                    invoke GetClientRect, hWnd, addr rect        ;REPINTAR PANTALLA
                    invoke InvalidateRect, hWnd, addr rect, TRUE ;REPINTAR PANTALLA

                .ELSEIF al==BTN_PUNTUACIONES ;SI PRESIONO PUNTUACIONES////////////////////////////////////////////////////////////////               

                    invoke ShowWindow, ButtonJugar, FALSE        ;OCULTAR BOTON
                    invoke ShowWindow, ButtonPuntuaciones, FALSE ;OCULTAR BOTON 
                    invoke ShowWindow, ButtonSalir, FALSE        ;OCULTAR BOTON 
                    
                    mov EstatusJuego, PUNTUACIONES ;CAMBIAR ESTATUS DEL JUEGO

                    invoke GetClientRect, hWnd, addr rect        ;REPINTAR PANTALLA
                    invoke InvalidateRect, hWnd, addr rect, TRUE ;REPINTAR PANTALLA
                    
                    invoke ShowWindow, ButtonContinuar, TRUE     ;MOSTRAR
                    invoke ShowWindow, ListBoxPuntuaciones, TRUE ;MOSTRAR
                                       
                .ELSEIF al==BTN_SALIR ;SI PRESIONO SALIR//////////////////////////////////////////////////////////////////////////////

                    invoke DeleteObject, BitmapFondoBotonPuntuaciones ;TERMINAR PROGRAMA
                    invoke DeleteObject, BitmapFondoBotonSalir        ;TERMINAR PROGRAMA
                    invoke DeleteObject, BitmapFondoBotonJugar        ;TERMINAR PROGRAMA
                    invoke DeleteObject, BitmapFondo                  ;TERMINAR PROGRAMA
                    invoke PostQuitMessage,NULL                       ;TERMINAR PROGRAMA

                .ELSEIF al==BTN_CONTINUAR

                    mov EstatusJuego, INICIO
                    mov EstadoJuego, ESTADO_PARADO

                    invoke GetClientRect, hWnd, addr rect        ;REPINTAR PANTALLA
                    invoke InvalidateRect, hWnd, addr rect, TRUE ;REPINTAR PANTALLA 

                .ENDIF

        ;-------------------------------------------------------------------------------------------------
        ;                                           WM_KEYUP                                             |
        ;-------------------------------------------------------------------------------------------------
        
            .ELSEIF uMsg==WM_KEYUP

                .IF wParam == TECLA_A || wParam == TECLA_D ;SI SOLTASTE LAS TECLAS DE MOVIMIENTO
                    
                    .IF  direccionPelotax == QUIETA_PELOTA ;SI LA PELTA ESTA EN VERTICAL

                        mov direccionPlayerx, QUIETO_PLAYER ;ESTABLECER DIRECCION PLAYER A QUETO

                    .ENDIF

                .ENDIF

        ;-------------------------------------------------------------------------------------------------
        ;                                           WM_TIMER                                             |
        ;-------------------------------------------------------------------------------------------------

            .ELSEIF uMsg==WM_TIMER
                
                .IF EstatusJuego == JUEGO ;JUGANDO////////////////////////////////////////////////////////

                        ;--------------------------------------------------------------------------------------------------------
                        ;                                      CONTROLAR MOVIMIENTO PLAYER Y PELOTA                             |
                        ;--------------------------------------------------------------------------------------------------------

                        xor eax, eax                           ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        invoke GetAsyncKeyState, TECLA_ESPACIO ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        push eax                               ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        xor eax, eax                           ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        invoke GetAsyncKeyState, TECLA_D       ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        xor ebx, ebx                           ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        mov ebx, eax                           ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        xor eax, eax                           ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        invoke GetAsyncKeyState, TECLA_A       ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        xor ecx, ecx                           ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        mov ecx, eax                           ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        xor eax, eax                           ;OBTENER ESTADOS TECLA A, D Y ESPACIO
                        pop eax                                ;OBTENER ESTADOS TECLA A, D Y ESPACIO

                        .IF eax && !ebx && !ecx ;SI SOLO SE PRESIONO LA TECLA ESPACIO////////////////////////////////////////////
                            
                            .IF EstadoJuego == ESTADO_PARADO ;SI EL JUEGO ESTA PARADO/////////////////////////////////
                        
                                mov EstadoJuego, ESTADO_INICIADO ;ESTABLECER JUEGO INICIADO

                            .ENDIF

                            mov direccionPelotay, ARRIBA_PELOTA ;ESTABLECER DIRECCION PELOTA
                            mov direccionPelotax, QUIETA_PELOTA ;ESTABLECER DIRECCION PELOTA

                            mov direccionPlayerx, QUIETO_PLAYER ;ESTABLECER DIRECCION PLAYER

                        .ENDIF 


                        xor eax, eax                           ;OBTENER ESTADOS TECLA A Y ESPACIO
                        invoke GetAsyncKeyState, TECLA_D       ;OBTENER ESTADOS TECLA A Y ESPACIO
                        push eax                               ;OBTENER ESTADOS TECLA A Y ESPACIO
                        xor eax, eax                           ;OBTENER ESTADOS TECLA A Y ESPACIO
                        invoke GetAsyncKeyState, TECLA_ESPACIO ;OBTENER ESTADOS TECLA A Y ESPACIO
                        xor ebx, ebx                           ;OBTENER ESTADOS TECLA A Y ESPACIO
                        mov ebx, eax                           ;OBTENER ESTADOS TECLA A Y ESPACIO
                        pop eax                                ;OBTENER ESTADOS TECLA A Y ESPACIO

                        .IF eax && !ebx ;SI TECLA D YA ESTABA PRESIONADA///////////////////////////////////////////
                            .IF xPlayer <= LIMITE_PARED_DERECHA_PLAYER ;LIMITE PLAYER PARED DERECHA////////////////

                                 mov teclaPresionada, TECLA_PRESIONADA ;ESTABLECER QUE SE PRESIONO UNA TECLA

                                 mov direccionPlayerx, DERECHA_PLAYER ;ESTABLECER DIRECCION PLAYER

                                 add xPlayer, VELOCIDAD_PLAYER ;AUMENTAR EN X LA DIRECCION DE PLAYER

                                 .IF EstadoJuego==ESTADO_PARADO ;SI LA PELOTA ESTA QUIETA///////////////////////////////////

                                     add xPelota, VELOCIDAD_PLAYER ;MOVER PELOTA A LA DERECHA

                                 .ENDIF

                            .ENDIF

                        .ELSEIF eax && ebx ;SI SE PRESIONO LAS TECLAS AL MISMO TIEMPO//////////////////////////////////////

                            .IF xPlayer <= LIMITE_PARED_DERECHA_PLAYER ;LIMITE PLAYER PARED DERECHA///////////////////////////////
                                 
                                mov teclaPresionada, TECLA_PRESIONADA ;ESTABLECER TECLA PRESIONADA

                                .IF EstadoJuego == ESTADO_PARADO ;SI EL JUEGO ESTA PARADO/////////////////////////////////
                        
                                    mov EstadoJuego, ESTADO_INICIADO ;ESTABLECER JUEGO INICIADO

                                .ENDIF

                                 mov direccionPlayerx, DERECHA_PLAYER ;ESTABLECER DIRECCION PLAYER

                                 add xPlayer, VELOCIDAD_PLAYER ;AUMENTAR EN X LA DIRECCION DE LA PELOTA

                                 .IF EstadoJuego==ESTADO_PARADO ;SI LA PELOTA ESTA QUIETA/////////////////////////////////

                                     add xPelota, VELOCIDAD_PLAYER ;MOVER PELOTA A LA DERECHA

                                 .ENDIF

                            .ENDIF

                        .ENDIF

                        xor eax, eax                           ;OBTENER ESTADO TECLA A Y ESPACIO
                        invoke GetAsyncKeyState, TECLA_A       ;OBTENER ESTADO TECLA A Y ESPACIO
                        push eax                               ;OBTENER ESTADO TECLA A Y ESPACIO
                        xor eax, eax                           ;OBTENER ESTADO TECLA A Y ESPACIO
                        invoke GetAsyncKeyState, TECLA_ESPACIO ;OBTENER ESTADO TECLA A Y ESPACIO
                        xor ebx, ebx                           ;OBTENER ESTADO TECLA A Y ESPACIO
                        mov ebx, eax                           ;OBTENER ESTADO TECLA A Y ESPACIO
                        pop eax                                ;OBTENER ESTADO TECLA A Y ESPACIO

                        .IF eax && !ebx ;SI TECLA A YA ESTABA PRESIONADA///////////////////////////////////////////
                            .IF xPlayer >= LIMITE_PARED_IZQUIERDA_PLAYER ;LIMITE PLAYER PARED IZQUIERDA////////////////
                                 
                                 mov teclaPresionada, TECLA_PRESIONADA ; ESTABLECER QUESE PRESIONO LA TECLA

                                 mov direccionPlayerx, IZQUIERDA_PLAYER ;ESTABLECER DIRECCION PLAYER

                                 sub xPlayer, VELOCIDAD_PLAYER ;MOVER A LA IZQUIERDA

                                 .IF EstadoJuego==ESTADO_PARADO ;SI EL JUEGO ESTA PARADO///////////////////////////

                                     sub xPelota, VELOCIDAD_PLAYER ;MOVER PELOTA A LA IZQUIERDA

                                 .ENDIF
                            .ENDIF

                        .ELSEIF eax && ebx ; SI SE PRESIONAN LAS TECLAS AL MISMO TIEMPO////////////////////////////

                            .IF xPlayer > LIMITE_PARED_IZQUIERDA_PLAYER ;LIMITE PLAYER PARED IZQUIERDA////////////////
                                 
                                 mov teclaPresionada, TECLA_PRESIONADA ;ESTABLECER QUE SE PRESIONO LA TECLA

                                .IF EstadoJuego == ESTADO_PARADO ;SI EL JUEGO ESTA PARADO////////////////////////
                        
                                    mov EstadoJuego, ESTADO_INICIADO ; ESTABLECER EL JUEGO INCIADO

                                .ENDIF

                                 mov direccionPlayerx, IZQUIERDA_PLAYER ;ESTABLECER DIRECCION PLAYER

                                 sub xPlayer, VELOCIDAD_PLAYER ;MOVER A LA IZQUIERDA

                                 .IF EstadoJuego==ESTADO_PARADO ;SI EL JUEGO ESTA PARADO///////////////////////////

                                     sub xPelota, VELOCIDAD_PLAYER ;MOVER PELOTA A LA DERECHA

                                 .ENDIF
                            .ENDIF

                        .ENDIF

                        

                        .IF teclaPresionada ;SI MUEVO EL PLAYER//////////////////////////////////////////
                         
                            invoke GetClientRect, hWnd, addr rect ;OBTENER RECTANGULO VENTANA

                            xor eax, eax                           ;CALCULAR RECTANGULO PLAYER
                            mov eax, xPlayer                       ;CALCULAR RECTANGULO PLAYER
                            mov rect.left, eax                     ;CALCULAR RECTANGULO PLAYER
                            .IF direccionPlayerx==DERECHA_PLAYER   ;CALCULAR RECTANGULO PLAYER
                                sub rect.left, VELOCIDAD_PLAYER    ;CALCULAR RECTANGULO PLAYER
                            .ENDIF                                 ;CALCULAR RECTANGULO PLAYER
                            xor eax, eax                           ;CALCULAR RECTANGULO PLAYER
                            mov eax, yPlayer                       ;CALCULAR RECTANGULO PLAYER
                            .IF EstadoJuego==ESTADO_PARADO         ;CALCULAR RECTANGULO PLAYER
                                sub eax, ALTURA_PELOTA             ;CALCULAR RECTANGULO PLAYER
                            .ENDIF                                 ;CALCULAR RECTANGULO PLAYER
                            mov rect.top, eax                      ;CALCULAR RECTANGULO PLAYER
                            xor eax, eax                           ;CALCULAR RECTANGULO PLAYER
                            mov eax, xPlayer                       ;CALCULAR RECTANGULO PLAYER
                            add eax, ANCHO_PLAYER                  ;CALCULAR RECTANGULO PLAYER
                            .IF direccionPlayerx==IZQUIERDA_PLAYER ;CALCULAR RECTANGULO PLAYER
                                add eax, VELOCIDAD_PLAYER          ;CALCULAR RECTANGULO PLAYER
                            .ENDIF                                 ;CALCULAR RECTANGULO PLAYER
                            mov rect.right, eax                    ;CALCULAR RECTANGULO PLAYER
                            xor eax, eax                           ;CALCULAR RECTANGULO PLAYER
                            mov eax, yPlayer                       ;CALCULAR RECTANGULO PLAYER
                            add eax, ALTURA_PLAYER                 ;CALCULAR RECTANGULO PLAYER
                            mov rect.bottom, eax                   ;CALCULAR RECTANGULO PLAYER

                            mov teclaPresionada, TECLA_NO_PRESIONADA ;ESTABLECER A TECLA NO PRESIONADA

                            invoke RedrawWindow, hWnd, addr rect, NULL, RDW_INVALIDATE ;REPINTAR NAVE Y/O PELOTA

                        .ENDIF

                        ;--------------------------------------------------------------------------------------------------------
                        ;                                      JUEGO INICIADO                                                   |
                        ;--------------------------------------------------------------------------------------------------------

                        .IF EstadoJuego==ESTADO_INICIADO ;SI LA PELOTA ESTA EN MOVIMIENTO////////////////////////////////////////////

                            ;--------------------------------------------------------------------------------------------------------
                            ;                                      INICIAR MOVIMIENTO PELOTA                                        |
                            ;--------------------------------------------------------------------------------------------------------

                            .IF direccionPelotay == QUIETA_PELOTA && direccionPelotax == QUIETA_PELOTA && direccionPlayerx == QUIETO_PLAYER
                                
                                mov direccionPelotay, ARRIBA_PELOTA

                            .ELSEIF direccionPelotay == QUIETA_PELOTA && direccionPelotax == QUIETA_PELOTA && direccionPlayerx == DERECHA_PLAYER

                                mov direccionPelotay, ARRIBA_PELOTA
                                mov direccionPelotax, DERECHA_PELOTA

                            .ELSEIF direccionPelotay == QUIETA_PELOTA && direccionPelotax == QUIETA_PELOTA && direccionPlayerx == IZQUIERDA_PLAYER

                                mov direccionPelotay, ARRIBA_PELOTA
                                mov direccionPelotax, IZQUIERDA_PELOTA

                            .ENDIF

                            ;--------------------------------------------------------------------------------------------------------
                            ;                                      COLISION PAREDES                                                 |
                            ;--------------------------------------------------------------------------------------------------------

                            .IF yPelota <= LIMITE_PARED_TOP_PELOTA && direccionPelotax == QUIETA_PELOTA && direccionPelotay == ARRIBA_PELOTA ;SI LA PELOTA TOP ARRBA//////////////////////////////////////////

                                mov direccionPelotay, ABAJO_PELOTA  ;AJUSTA DIRECCION PELOTA
                                mov direccionPelotax, QUIETA_PELOTA ;AJUSTA DIRECCION PELOTA

                            .ELSEIF yPelota <= LIMITE_PARED_TOP_PELOTA && direccionPelotax == DERECHA_PELOTA && direccionPelotay == ARRIBA_PELOTA

                               mov direccionPelotay, ABAJO_PELOTA   ;AJUSTAR DIRECCION PELOTA
                               mov direccionPelotax, DERECHA_PELOTA ;AJUSTAR DIRECCION PELOTA

                            .ELSEIF yPelota <= LIMITE_PARED_TOP_PELOTA && direccionPelotax == IZQUIERDA_PELOTA && direccionPelotay == ARRIBA_PELOTA

                               mov direccionPelotay, ABAJO_PELOTA   ;AJUSTAR DIRECCION PELOTA
                               mov direccionPelotax, IZQUIERDA_PELOTA ;AJUSTAR DIRECCION PELOTA

                            .ELSEIF xPelota >= LIMITE_PARED_DERECHA_PELOTA && direccionPelotax == DERECHA_PELOTA && direccionPelotay == ARRIBA_PELOTA

                               mov direccionPelotay, ARRIBA_PELOTA
                               mov direccionPelotax, IZQUIERDA_PELOTA

                            .ELSEIF xPelota >= LIMITE_PARED_DERECHA_PELOTA && direccionPelotax == DERECHA_PELOTA && direccionPelotay == ABAJO_PELOTA

                               mov direccionPelotay, ABAJO_PELOTA
                               mov direccionPelotax, IZQUIERDA_PELOTA

                            .ELSEIF xPelota <= LIMITE_PARED_IZQUIERDA_PELOTA && direccionPelotax == IZQUIERDA_PELOTA && direccionPelotay == ARRIBA_PELOTA

                               mov direccionPelotay, ARRIBA_PELOTA
                               mov direccionPelotax, DERECHA_PELOTA

                            .ELSEIF xPelota <= LIMITE_PARED_IZQUIERDA_PELOTA && direccionPelotax == IZQUIERDA_PELOTA && direccionPelotay == ABAJO_PELOTA

                               mov direccionPelotay, ABAJO_PELOTA
                               mov direccionPelotax, DERECHA_PELOTA
                            .ENDIF

                            ;-------------------------------------------------------------------------------------------------------
                            ;                                     COLISION BLOQUES                                                 |
                            ;-------------------------------------------------------------------------------------------------------

                            xor ecx, ecx

                            .IF sizeBloques > 0 ;SI EXISTEN BLOQUES

                                BucleBloquesInterseccion:
                                    
                                    xor eax, eax               ;OBTENER INDICE DEL ARREGLO
                                    mov eax, SIZE_BYTES_BLOQUE ;OBTENER INDICE DEL ARREGLO
                                    mul ecx                    ;OBTENER INDICE DEL ARREGLO
                                    push ecx                   ;OBTENER INDICE DEL ARREGLO

                                    ;----------------------------------------------------------------------
                                    ;                 SI CHOCA EN LA PARTE DE ABAJO                       |
                                    ;----------------------------------------------------------------------

                                    xor ebx, ebx                        ;TOMAR COORDENADAS ABAJO BLOQUE
                                    xor ecx, ecx                        ;TOMAR COORDENADAS ABAJO BLOQUE
                                    xor edx, edx                        ;TOMAR COORDENADAS ABAJO BLOQUE
                                    mov ebx, arregloBloque[eax].xBloque ;TOMAR COORDENADAS ABAJO BLOQUE
                                    sub ebx, ANCHO_PELOTA               ;TOMAR COORDENADAS ABAJO BLOQUE
                                    mov edx, arregloBloque[eax].xBloque ;TOMAR COORDENADAS ABAJO BLOQUE
                                    add edx, anchoBloque                ;TOMAR COORDENADAS ABAJO BLOQUE

                                    .IF xPelota >= ebx && xPelota <= edx && direccionPelotay == ARRIBA_PELOTA;SI LA PELOTA TOCA LA PARTE DE ABAJO    
                                        
                                        xor ebx, ebx ;LIMPIAR REGISTROS
                                        xor ecx, ecx ;LIMPIAR REGISTROS
                                        xor edx, edx ;LIMPIAR REGISTROS

                                        mov ebx, arregloBloque[eax].yBloque ;OBTENGO LA COORDENADA DE IMPACTO
                                        add ebx, alturaBloque               ;OBTENGO LA COORDENADA DE IMPACTO
                                        add ebx, VELOCIDADY_PELOTA          ;OBTENGO LA COORDENADA DE IMPACTO
                                        xor ecx, ecx
                                        mov ecx, arregloBloque[eax].yBloque
                                        add ecx, alturaBloque

                                        .IF yPelota <= ebx && yPelota > ecx ;SI LA PELOTA VA A PASAR EL RECTANGULO POR ABAJO//////////////////////////////////////////////
                                            
                                            xor ebx, ebx
                                            xor ecx, ecx
                                            mov ecx, arregloBloque[eax].yBloque
                                            add ecx, alturaBloque
                                            mov ebx, yPelota
                                            sub ebx, ecx
                                            mov velocidadPelotay, ebx ;OBTENGO LA COORDENADA DE IMPACTO
                                            

                                        .ENDIF

                                        xor ebx, ebx
                                        mov ebx, arregloBloque[eax].yBloque ;OBTENGO LA COORDENADA DE IMPACTO
                                        add ebx, alturaBloque               ;OBTENGO LA COORDENADA DE IMPACTO

                                        .IF yPelota == ebx
                                            
                                            push eax

	                                        invoke	PlaySound, addr golpeBloque, NULL, SND_FILENAME or SND_ASYNC
                                           
                                            pop eax

                                            .IF arregloBloque[eax].colorBloque == COLOR_GRIS

                                                .IF arregloBloque[eax].golpes == 1
                                                 
                                                    mov arregloBloque[eax].visible, BLOQUE_NO_VISIBLE

                                                    add contadorBloquesDestruidos, 1
                                                    add contadorPuntos, 2

                                                .ELSEIF

                                                    push eax                                              ;CARGAR BITMAP AGRIETADO
                                                    xor eax, eax                                          ;CARGAR BITMAP AGRIETADO
                                                    invoke LoadBitmap, hInstance, IDB_BLOQUEGRISAGRIETADO ;CARGAR BITMAP AGRIETADO
                                                    xor ebx, ebx                                          ;CARGAR BITMAP AGRIETADO
                                                    mov ebx, eax                                          ;CARGAR BITMAP AGRIETADO
                                                    pop eax                                               ;CARGAR BITMAP AGRIETADO
                                                    mov arregloBloque[eax].hBitmap, ebx                   ;CARGAR BITMAP AGRIETADO

                                                    add arregloBloque[eax].golpes, 1

                                                .ENDIF

                                            .ELSEIF arregloBloque[eax].colorBloque == COLOR_ROJO

                                                mov arregloBloque[eax].visible, BLOQUE_NO_VISIBLE

                                                add contadorBloquesDestruidos, 1
                                                add contadorPuntos, 1

                                            .ENDIF

                                            push eax ;GUARDAR EL INDICE EN LA PILA

                                            invoke GetClientRect, hWnd, addr rect ;OBTENER RECTANGULO VENTANA

                                            pop eax ;OBTENER EL INDICE EN LA PILA

                                            xor ebx, ebx                        ;OBTENER RECTANGULO BLOQUE
                                            mov ebx, arregloBloque[eax].xBloque ;OBTENER RECTANGULO BLOQUE
                                            mov rect.left, ebx                  ;OBTENER RECTANGULO BLOQUE
                                            add ebx, anchoBloque                ;OBTENER RECTANGULO BLOQUE
                                            mov rect.right, ebx                 ;OBTENER RECTANGULO BLOQUE
                                            xor ebx, ebx                        ;OBTENER RECTANGULO BLOQUE
                                            mov ebx, arregloBloque[eax].yBloque ;OBTENER RECTANGULO BLOQUE
                                            mov rect.top, ebx                   ;OBTENER RECTANGULO BLOQUE
                                            add ebx, alturaBloque               ;OBTENER RECTANGULO BLOQUE
                                            mov rect.bottom, ebx                ;OBTENER RECTANGULO BLOQUE

                                            invoke InvalidateRect, hWnd, ADDR rect, TRUE ;BORRAR EL BLOQUE

                                            mov direccionPelotay, ABAJO_PELOTA ;AJUSTA DIRECCION 


                                        .ENDIF 

                                    .ENDIF

                                    ;----------------------------------------------------------------------
                                    ;                 SI CHOCA EN LA PARTE DE ARRIBA                       |
                                    ;----------------------------------------------------------------------

                                    xor ebx, ebx                        ;TOMAR COORDENADAS ABAJO BLOQUE
                                    xor ecx, ecx                        ;TOMAR COORDENADAS ABAJO BLOQUE
                                    xor edx, edx                        ;TOMAR COORDENADAS ABAJO BLOQUE
                                    mov ebx, arregloBloque[eax].xBloque ;TOMAR COORDENADAS ABAJO BLOQUE
                                    sub ebx, ANCHO_PELOTA               ;TOMAR COORDENADAS ABAJO BLOQUE
                                    mov edx, arregloBloque[eax].xBloque ;TOMAR COORDENADAS ABAJO BLOQUE
                                    add edx, anchoBloque                ;TOMAR COORDENADAS ABAJO BLOQUE

                                    .IF xPelota >= ebx && xPelota <= edx && direccionPelotay == ABAJO_PELOTA;SI LA PELOTA TOCA LA PARTE DE ARRIBA   
                                        
                                        xor ebx, ebx ;LIMPIAR REGISTROS
                                        xor ecx, ecx ;LIMPIAR REGISTROS
                                        xor edx, edx ;LIMPIAR REGISTROS

                                        mov ebx, arregloBloque[eax].yBloque ;OBTENGO LA COORDENADA DE IMPACTO
                                        sub ebx, VELOCIDADY_PELOTA          ;OBTENGO LA COORDENADA DE IMPACTO
                                        xor ecx, ecx
                                        mov ecx, yPelota
                                        add ecx, ALTURA_PELOTA

                                        .IF ecx >= ebx && ecx < arregloBloque[eax].yBloque ;SI LA PELOTA VA A PASAR EL RECTANGULO POR ABAJO//////////////////////////////////////////////
                                            
                                            xor ebx, ebx                        ;OBTENGO LA COORDENADA DE IMPACTO
                                            xor ecx, ecx                        ;OBTENGO LA COORDENADA DE IMPACTO
                                            mov ecx, arregloBloque[eax].yBloque ;OBTENGO LA COORDENADA DE IMPACTO
                                            mov ebx, yPelota                    ;OBTENGO LA COORDENADA DE IMPACTO
                                            add ebx, ALTURA_PELOTA              ;OBTENGO LA COORDENADA DE IMPACTO
                                            sub ecx, ebx                        ;OBTENGO LA COORDENADA DE IMPACTO
                                            mov velocidadPelotay, ecx           ;OBTENGO LA COORDENADA DE IMPACTO

                                        .ENDIF

                                        xor ebx, ebx           ;OBTENGO LA COORDENADA DE IMPACTO
                                        mov ebx, yPelota       ;OBTENGO LA COORDENADA DE IMPACTO
                                        add ebx, ALTURA_PELOTA ;OBTENGO LA COORDENADA DE IMPACTO

                                        .IF ebx == arregloBloque[eax].yBloque ;SI CHOCA POR LA PARTE DE ARRIBA////////////////////////////////////////////////////////////
                                            
                                            push eax

	                                        invoke	PlaySound, addr golpeBloque, NULL, SND_FILENAME or SND_ASYNC
                                           
                                            pop eax

                                            .IF arregloBloque[eax].colorBloque == COLOR_GRIS

                                                .IF arregloBloque[eax].golpes == 1
                                                 
                                                    mov arregloBloque[eax].visible, BLOQUE_NO_VISIBLE

                                                    add contadorBloquesDestruidos, 1
                                                    add contadorPuntos, 2

                                                .ELSEIF

                                                    push eax                                              ;CARGAR BITMAP AGRIETADO
                                                    xor eax, eax                                          ;CARGAR BITMAP AGRIETADO
                                                    invoke LoadBitmap, hInstance, IDB_BLOQUEGRISAGRIETADO ;CARGAR BITMAP AGRIETADO
                                                    xor ebx, ebx                                          ;CARGAR BITMAP AGRIETADO
                                                    mov ebx, eax                                          ;CARGAR BITMAP AGRIETADO
                                                    pop eax                                               ;CARGAR BITMAP AGRIETADO
                                                    mov arregloBloque[eax].hBitmap, ebx                   ;CARGAR BITMAP AGRIETADO

                                                    add arregloBloque[eax].golpes, 1

                                                .ENDIF

                                            .ELSEIF arregloBloque[eax].colorBloque == COLOR_ROJO

                                                mov arregloBloque[eax].visible, BLOQUE_NO_VISIBLE

                                                add contadorBloquesDestruidos, 1
                                                add contadorPuntos, 1

                                            .ENDIF

                                            push eax ;GUARDAR EL INDICE EN LA PILA

                                            invoke GetClientRect, hWnd, addr rect ;OBTENER RECTANGULO VENTANA

                                            pop eax ;OBTENER EL INDICE EN LA PILA

                                            xor ebx, ebx                        ;OBTENER RECTANGULO BLOQUE
                                            mov ebx, arregloBloque[eax].xBloque ;OBTENER RECTANGULO BLOQUE
                                            mov rect.left, ebx                  ;OBTENER RECTANGULO BLOQUE
                                            add ebx, anchoBloque                ;OBTENER RECTANGULO BLOQUE
                                            mov rect.right, ebx                 ;OBTENER RECTANGULO BLOQUE
                                            xor ebx, ebx                        ;OBTENER RECTANGULO BLOQUE
                                            mov ebx, arregloBloque[eax].yBloque ;OBTENER RECTANGULO BLOQUE
                                            mov rect.top, ebx                   ;OBTENER RECTANGULO BLOQUE
                                            add ebx, alturaBloque               ;OBTENER RECTANGULO BLOQUE
                                            mov rect.bottom, ebx                ;OBTENER RECTANGULO BLOQUE

                                            invoke InvalidateRect, hWnd, ADDR rect, TRUE ;BORRAR EL BLOQUE

                                            mov direccionPelotay, ARRIBA_PELOTA

                                        .ENDIF 

                                    .ENDIF

                                    ;----------------------------------------------------------------------
                                    ;     SI CHOCA EN LA PARTE DE LA IZQUIERDA eax TIENE EL INDICE        |
                                    ;----------------------------------------------------------------------

                                    xor ebx, ebx                        ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    xor ecx, ecx                        ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    xor edx, edx                        ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    mov ebx, arregloBloque[eax].yBloque ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    sub ebx, ALTURA_PELOTA              ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    mov edx, arregloBloque[eax].yBloque ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    add edx, alturaBloque               ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    
                                    .IF yPelota >= ebx && yPelota <= edx && direccionPelotax == DERECHA_PELOTA ;SI CHOCA POR LA IZQUIERDA/////////////////////////

                                        xor ebx, ebx ;LIMPIAR REGISTROS

                                        mov ebx, arregloBloque[eax].xBloque ;OBTENGO LA COORDENADA DE IMPACTO
                                        sub ebx, VELOCIDADX_PELOTA          ;OBTENGO LA COORDENADA DE IMPACTO
                                        xor ecx, ecx                        ;OBTENGO LA COORDENADA DE IMPACTO
                                        mov ecx, xPelota                    ;OBTENGO LA COORDENADA DE IMPACTO
                                        add ecx, ANCHO_PELOTA               ;OBTENGO LA COORDENADA DE IMPACTO
                                        
                                        .IF ecx >= ebx && ecx < arregloBloque[eax].xBloque ;SI CHOCA PORLA IZQUIERDA////////////////////////////

                                            xor ebx, ebx                        ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            mov ebx, arregloBloque[eax].xBloque ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            xor ecx, ecx                        ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            mov ecx, xPelota                    ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            add ecx, ANCHO_PELOTA               ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            sub ebx, ecx                        ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            mov velocidadPelotax, ebx           ;OBTENGO LO QUE FALTA PARA CHOCAR

                                        .ENDIF

                                        xor ebx, ebx          ;OBTENER COORDENADA DE COLISION
                                        mov ebx, xPelota      ;OBTENER COORDENADA DE COLISION
                                        add ebx, ANCHO_PELOTA ;OBTENER COORDENADA DE COLISION

                                        .IF ebx == arregloBloque[eax].xBloque ;SI CHOCA CON LA PARED IZQUIERDA/////////////////////////////////////////
                                            
                                            push eax

	                                        invoke	PlaySound, addr golpeBloque, NULL, SND_FILENAME or SND_ASYNC
                                           
                                            pop eax

                                            .IF arregloBloque[eax].colorBloque == COLOR_GRIS

                                                .IF arregloBloque[eax].golpes == 1
                                                 
                                                    mov arregloBloque[eax].visible, BLOQUE_NO_VISIBLE

                                                    add contadorBloquesDestruidos, 1
                                                    add contadorPuntos, 2

                                                .ELSEIF

                                                    push eax                                              ;CARGAR BITMAP AGRIETADO
                                                    xor eax, eax                                          ;CARGAR BITMAP AGRIETADO
                                                    invoke LoadBitmap, hInstance, IDB_BLOQUEGRISAGRIETADO ;CARGAR BITMAP AGRIETADO
                                                    xor ebx, ebx                                          ;CARGAR BITMAP AGRIETADO
                                                    mov ebx, eax                                          ;CARGAR BITMAP AGRIETADO
                                                    pop eax                                               ;CARGAR BITMAP AGRIETADO
                                                    mov arregloBloque[eax].hBitmap, ebx                   ;CARGAR BITMAP AGRIETADO

                                                    add arregloBloque[eax].golpes, 1

                                                .ENDIF

                                            .ELSEIF arregloBloque[eax].colorBloque == COLOR_ROJO

                                                mov arregloBloque[eax].visible, BLOQUE_NO_VISIBLE

                                                add contadorBloquesDestruidos, 1
                                                add contadorPuntos, 1

                                            .ENDIF

                                            push eax ;GUARDAR EL INDICE EN LA PILA

                                            invoke GetClientRect, hWnd, addr rect ;OBTENER RECTANGULO VENTANA

                                            pop eax ;OBTENER EL INDICE EN LA PILA

                                            xor ebx, ebx                        ;OBTENER RECTANGULO BLOQUE
                                            mov ebx, arregloBloque[eax].xBloque ;OBTENER RECTANGULO BLOQUE
                                            mov rect.left, ebx                  ;OBTENER RECTANGULO BLOQUE
                                            add ebx, anchoBloque                ;OBTENER RECTANGULO BLOQUE
                                            mov rect.right, ebx                 ;OBTENER RECTANGULO BLOQUE
                                            xor ebx, ebx                        ;OBTENER RECTANGULO BLOQUE
                                            mov ebx, arregloBloque[eax].yBloque ;OBTENER RECTANGULO BLOQUE
                                            mov rect.top, ebx                   ;OBTENER RECTANGULO BLOQUE
                                            add ebx, alturaBloque               ;OBTENER RECTANGULO BLOQUE
                                            mov rect.bottom, ebx                ;OBTENER RECTANGULO BLOQUE

                                            invoke InvalidateRect, hWnd, ADDR rect, TRUE ;BORRAR EL BLOQUE

                                            mov direccionPelotax, IZQUIERDA_PELOTA ;ESTABLECER DIRECCION DE PELOTA

                                        .ENDIF

                                    .ENDIF

                                    ;----------------------------------------------------------------------
                                    ;     SI CHOCA EN LA PARTE DE LA DERECHA eax TIENE EL INDICE          |
                                    ;----------------------------------------------------------------------

                                    xor ebx, ebx                        ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    xor ecx, ecx                        ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    xor edx, edx                        ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    mov ebx, arregloBloque[eax].yBloque ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    sub ebx, ALTURA_PELOTA              ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    mov edx, arregloBloque[eax].yBloque ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    add edx, alturaBloque               ;TOMAR COORDENADAS IZQUIERDA BLOQUE
                                    
                                    .IF yPelota >= ebx && yPelota <= edx && direccionPelotax == IZQUIERDA_PELOTA ;SI CHOCA POR LA DERECHA/////////////////////////

                                        xor ebx, ebx ;LIMPIAR REGISTROS

                                        mov ebx, arregloBloque[eax].xBloque ;OBTENGO LA COORDENADA DE IMPACTO
                                        add ebx, anchoBloque
                                        add ebx, VELOCIDADX_PELOTA
                                        xor ecx, ecx
                                        mov ecx, arregloBloque[eax].xBloque
                                        add ecx, anchoBloque
                                        
                                        .IF xPelota <= ebx && xPelota > ecx ;SI CHOCA PORLA IZQUIERDA////////////////////////////

                                            xor ebx, ebx                        ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            mov ebx, arregloBloque[eax].xBloque ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            add ebx, anchoBloque                ;OBTENER LO QUE FALTA PARA CHOCAR
                                            xor ecx, ecx                        ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            mov ecx, xPelota                    ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            sub ecx, ebx                        ;OBTENGO LO QUE FALTA PARA CHOCAR
                                            mov velocidadPelotax, ecx           ;OBTENGO LO QUE FALTA PARA CHOCAR

                                        .ENDIF

                                        xor ecx, ecx
                                        mov ecx, arregloBloque[eax].xBloque
                                        add ecx, anchoBloque

                                        .IF xPelota == ecx ;SI CHOCA CON LA PARED IZQUIERDA/////////////////////////////////////////
                                            
                                            push eax

	                                        invoke	PlaySound, addr golpeBloque, NULL, SND_FILENAME or SND_ASYNC
                                           
                                            pop eax

                                            .IF arregloBloque[eax].colorBloque == COLOR_GRIS

                                                .IF arregloBloque[eax].golpes == 1
                                                 
                                                    mov arregloBloque[eax].visible, BLOQUE_NO_VISIBLE

                                                    add contadorBloquesDestruidos, 1
                                                    add contadorPuntos, 2

                                                .ELSEIF

                                                    push eax                                              ;CARGAR BITMAP AGRIETADO
                                                    xor eax, eax                                          ;CARGAR BITMAP AGRIETADO
                                                    invoke LoadBitmap, hInstance, IDB_BLOQUEGRISAGRIETADO ;CARGAR BITMAP AGRIETADO
                                                    xor ebx, ebx                                          ;CARGAR BITMAP AGRIETADO
                                                    mov ebx, eax                                          ;CARGAR BITMAP AGRIETADO
                                                    pop eax                                               ;CARGAR BITMAP AGRIETADO
                                                    mov arregloBloque[eax].hBitmap, ebx                   ;CARGAR BITMAP AGRIETADO

                                                    add arregloBloque[eax].golpes, 1

                                                .ENDIF

                                            .ELSEIF arregloBloque[eax].colorBloque == COLOR_ROJO

                                                mov arregloBloque[eax].visible, BLOQUE_NO_VISIBLE

                                                add contadorBloquesDestruidos, 1
                                                add contadorPuntos, 1

                                            .ENDIF

                                            push eax ;GUARDAR EL INDICE EN LA PILA

                                            invoke GetClientRect, hWnd, addr rect ;OBTENER RECTANGULO VENTANA

                                            pop eax ;OBTENER EL INDICE EN LA PILA

                                            xor ebx, ebx                        ;OBTENER RECTANGULO BLOQUE
                                            mov ebx, arregloBloque[eax].xBloque ;OBTENER RECTANGULO BLOQUE
                                            mov rect.left, ebx                  ;OBTENER RECTANGULO BLOQUE
                                            add ebx, anchoBloque                ;OBTENER RECTANGULO BLOQUE
                                            mov rect.right, ebx                 ;OBTENER RECTANGULO BLOQUE
                                            xor ebx, ebx                        ;OBTENER RECTANGULO BLOQUE
                                            mov ebx, arregloBloque[eax].yBloque ;OBTENER RECTANGULO BLOQUE
                                            mov rect.top, ebx                   ;OBTENER RECTANGULO BLOQUE
                                            add ebx, alturaBloque               ;OBTENER RECTANGULO BLOQUE
                                            mov rect.bottom, ebx                ;OBTENER RECTANGULO BLOQUE

                                            invoke InvalidateRect, hWnd, ADDR rect, TRUE ;BORRAR EL BLOQUE

                                            mov direccionPelotax, DERECHA_PELOTA ;ESTABLECER DIRECCION DE PELOTA

                                        .ENDIF

                                    .ENDIF

                                    pop ecx                 ;COMPARACION DEL BUCLE
                                    inc ecx                 ;COMPARACION DEL BUCLE
                                    cmp ecx, sizeBloques    ;COMPARACION DEL BUCLE

                                jl BucleBloquesInterseccion

                            .ENDIF

                            ;--------------------------------------------------------------------------------------------------------
                            ;                                      COLISION PLAYER                                                  |
                            ;--------------------------------------------------------------------------------------------------------

                            xor edx, edx           ;OBTENER CONDICIONES DE COLISION
                            xor eax, eax           ;OBTENER CONDICIONES DE COLISION
                            mov eax, ANCHO_PELOTA  ;OBTENER CONDICIONES DE COLISION
                            xor ebx, ebx           ;OBTENER CONDICIONES DE COLISION
                            mov ebx, 2             ;OBTENER CONDICIONES DE COLISION
                            div ebx                ;OBTENER CONDICIONES DE COLISION
                            xor ebx, ebx           ;OBTENER CONDICIONES DE COLISION
                            mov ebx, eax           ;OBTENER CONDICIONES DE COLISION
                            xor eax, eax           ;OBTENER CONDICIONES DE COLISION
                            mov eax, xPlayer       ;OBTENER CONDICIONES DE COLISION
                            sub eax, ebx           ;OBTENER CONDICIONES DE COLISION
                            xor ebx, ebx           ;OBTENER CONDICIONES DE COLISION
                            mov ebx, xPlayer       ;OBTENER CONDICIONES DE COLISION
                            add ebx, ANCHO_PLAYER  ;OBTENER CONDICIONES DE COLISION
                            xor ecx, ecx           ;OBTENER CONDICIONES DE COLISION
                            mov ecx, yPelota       ;OBTENER CONDICIONES DE COLISION
                            add ecx, ALTURA_PELOTA ;OBTENER CONDICIONES DE COLISION
                                                        
                            .IF xPelota >= eax && xPelota <= ebx && ecx >= yPlayer && ecx < 541 && direccionPlayerx == QUIETO_PLAYER && direccionPelotax == QUIETA_PELOTA ;SI LA PELOTA TOCA A LA PALETA

                                mov direccionPelotay, ARRIBA_PELOTA ;ESTABLECER DEIRECCION DE LA PELOTA

                            .ELSEIF xPelota >= eax && xPelota <= ebx && ecx >= yPlayer && ecx < 541 && direccionPlayerx == DERECHA_PLAYER && direccionPelotax == QUIETA_PELOTA && direccionPelotay == ABAJO_PELOTA

                                mov direccionPelotay, ARRIBA_PELOTA
                                mov direccionPelotax, DERECHA_PELOTA

                            .ELSEIF xPelota >= eax && xPelota <= ebx && ecx >= yPlayer && ecx < 541 && direccionPlayerx == IZQUIERDA_PLAYER && direccionPelotax == QUIETA_PELOTA && direccionPelotay == ABAJO_PELOTA

                                mov direccionPelotay, ARRIBA_PELOTA
                                mov direccionPelotax, IZQUIERDA_PELOTA

                            .ELSEIF xPelota >= eax && xPelota <= ebx && ecx >= yPlayer && ecx < 541 && direccionPlayerx == DERECHA_PLAYER && direccionPelotax == DERECHA_PELOTA && direccionPelotay == ABAJO_PELOTA
                             
                                mov direccionPelotay, ARRIBA_PELOTA
                                mov direccionPelotax, DERECHA_PELOTA

                            .ELSEIF xPelota >= eax && xPelota <= ebx && ecx >= yPlayer && ecx < 541 && direccionPlayerx == IZQUIERDA_PLAYER && direccionPelotax == DERECHA_PELOTA && direccionPelotay == ABAJO_PELOTA

                                mov direccionPelotay, ARRIBA_PELOTA
                                mov direccionPelotax, IZQUIERDA_PELOTA

                            .ELSEIF xPelota >= eax && xPelota <= ebx && ecx >= yPlayer && ecx < 541 && direccionPlayerx == DERECHA_PLAYER && direccionPelotax == IZQUIERDA_PELOTA && direccionPelotay == ABAJO_PELOTA
                             
                                mov direccionPelotay, ARRIBA_PELOTA
                                mov direccionPelotax, DERECHA_PELOTA

                            .ELSEIF xPelota >= eax && xPelota <= ebx && ecx >= yPlayer && ecx < 541 && direccionPlayerx == IZQUIERDA_PLAYER && direccionPelotax == IZQUIERDA_PELOTA && direccionPelotay == ABAJO_PELOTA

                                mov direccionPelotay, ARRIBA_PELOTA
                                mov direccionPelotax, IZQUIERDA_PELOTA

                            .ENDIF

                            ;--------------------------------------------------------------------------------------------------------
                            ;                                      MOVIMIENTO DE PELOTA                                             |
                            ;--------------------------------------------------------------------------------------------------------
                            
                            invoke GetClientRect, hWnd, addr rect ;OBTENER RECTANGULO VENTANA

                            .IF direccionPelotay == ARRIBA_PELOTA ;SI LA PELOTA VA PARA ARRIBA //////////////////////////////////////

                                xor eax, eax
                                mov eax, velocidadPelotay
                                sub yPelota, eax ;SUBIR PELOTA

                            .ELSEIF direccionPelotay == ABAJO_PELOTA ;SI LA PELOTA VA PARA ABAJO//////////////////////////////////////

                                xor eax, eax
                                mov eax, velocidadPelotay
                                add yPelota, eax ; BAJAR PELOTA

                            .ENDIF

                            .IF direccionPelotax == DERECHA_PELOTA ;SI LA PELOTA VA PARA LA DERECHA/////////////////////////////////////

                                xor eax, eax
                                mov eax, velocidadPelotax
                                add xPelota, eax ;MOVER A LA DERECHA

                            .ELSEIF direccionPelotax==IZQUIERDA_PELOTA; SI LA PELOTA VA PARA LA IZQUIERDA/////////////////////////////

                                xor eax, eax
                                mov eax, velocidadPelotax
                                sub xPelota, eax; MOVER A LA IZQUIERDA

                            .ENDIF

                            xor eax, eax                            ;OBTENER RECTANGULO PELOTA
                            mov eax, xPelota                        ;OBTENER RECTANGULO PELOTA
                            mov rect.left, eax                      ;OBTENER RECTANGULO PELOTA
                            .IF direccionPelotax==DERECHA_PELOTA    ;OBTENER RECTANGULO PELOTA
                                xor ebx, ebx                        ;OBTENER RECTANGULO PELOTA
                                mov ebx, velocidadPelotax           ;OBTENER RECTANGULO PELOTA
                                sub rect.left, ebx                  ;OBTENER RECTANGULO PELOTA
                            .ENDIF                                  ;OBTENER RECTANGULO PELOTA
                            add eax, ANCHO_PELOTA                   ;OBTENER RECTANGULO PELOTA
                            mov rect.right, eax                     ;OBTENER RECTANGULO PELOTA
                            .IF direccionPelotax==IZQUIERDA_PELOTA  ;OBTENER RECTANGULO PELOTA
                                xor ebx, ebx                        ;OBTENER RECTANGULO PELOTA
                                mov ebx, velocidadPelotax           ;OBTENER RECTANGULO PELOTA
                                add rect.right, ebx                 ;OBTENER RECTANGULO PELOTA
                            .ENDIF                                  ;OBTENER RECTANGULO PELOTA
                            xor eax, eax                            ;OBTENER RECTANGULO PELOTA
                            mov eax, yPelota                        ;OBTENER RECTANGULO PELOTA
                            mov rect.top, eax                       ;OBTENER RECTANGULO PELOTA
                            .IF direccionPelotay==ABAJO_PELOTA      ;OBTENER RECTANGULO PELOTA
                                xor ebx, ebx                        ;OBTENER RECTANGULO PELOTA
                                mov ebx, velocidadPelotay           ;OBTENER RECTANGULO PELOTA
                                sub rect.top, ebx                   ;OBTENER RECTANGULO PELOTA
                            .ENDIF                                  ;OBTENER RECTANGULO PELOTA
                            add eax, ALTURA_PELOTA                  ;OBTENER RECTANGULO PELOTA
                            mov rect.bottom, eax                    ;OBTENER RECTANGULO PELOTA
                            .IF direccionPelotay==ARRIBA_PELOTA     ;OBTENER RECTANGULO PELOTA
                                xor ebx, ebx                        ;OBTENER RECTANGULO PELOTA
                                mov ebx, velocidadPelotay           ;OBTENER RECTANGULO PELOTA
                                add rect.bottom, ebx                ;OBTENER RECTANGULO PELOTA
                            .ENDIF                                  ;OBTENER RECTANGULO PELOTA

                           mov velocidadPelotay, VELOCIDADY_PELOTA
                           mov velocidadPelotax, VELOCIDADX_PELOTA

                           invoke RedrawWindow, hWnd, addr rect, NULL, RDW_INVALIDATE ;REPINTAR PELOTA
                            
                               xor eax, eax           ;OBTENER COORDENADAS DE PERDISTE
                               mov eax, yPelota       ;OBTENER COORDENADAS DE PERDISTE
                               xor ebx,  ebx          ;OBTENER COORDENADAS DE PERDISTE
                               mov ebx,  yPlayer      ;OBTENER COORDENADAS DE PERDISTE
                               add ebx, ALTURA_PLAYER ;OBTENER COORDENADAS DE PERDISTE

                           .IF eax > ebx ;SI PERDISTE EL JUEGO ///////////////////////////////////////////////////////
                               
                               invoke PlaySound, addr perdiste, NULL, SND_FILENAME or SND_ASYNC

                               mov contadorBloquesDestruidos, 0

                               mov EstatusJuego, PERDISTE ;CAMBIAR ESTADO DEL JUEGO

                               invoke GetClientRect, hWnd, addr rect ;OBTENER RECTANGULO VENTANA ;OBTENER RECTANGULO VENTANA COMPLETA

                               invoke InvalidateRect, hWnd, addr rect, TRUE ;LIMPIAR PANTALLA

                               invoke ShowWindow, ButtonContinuar, TRUE  ;MOSTRAR BOTONES
                               invoke ShowWindow, StaticPuntuacion, TRUE ;OCULTAR BOTONES

                               invoke SendMessage, ButtonContinuar, BM_SETIMAGE, IMAGE_BITMAP, BitmapFondoBotonContinuar     ;PINTAR FONDO BOTON JUGAR

                               invoke crt__itoa, contadorPuntos , addr buffer, 10

                               invoke SendMessage, ListBoxPuntuaciones, LB_ADDSTRING, 0, ADDR buffer

                               invoke SetWindowText, StaticPuntuacion, addr buffer

                                mov contadorPuntos, 0

                           .ENDIF

                           xor eax, eax
                           mov eax, sizeBloques

                           .IF contadorBloquesDestruidos == eax

                               invoke PlaySound, addr ganaste, NULL, SND_FILENAME or SND_ASYNC

                               mov EstatusJuego, GANASTE ;CAMBIAR ESTADO DEL JUEGO

                               invoke GetClientRect, hWnd, addr rect ;OBTENER RECTANGULO VENTANA ;OBTENER RECTANGULO VENTANA COMPLETA

                               invoke InvalidateRect, hWnd, addr rect, TRUE ;LIMPIAR PANTALLA

                               mov contadorBloquesDestruidos, 0
                               

                               invoke ShowWindow, ButtonContinuar, TRUE  ;MOSTRAR BOTONES
                               invoke ShowWindow, StaticPuntuacion, TRUE ;OCULTAR BOTONES

                               invoke SendMessage, ButtonContinuar, BM_SETIMAGE, IMAGE_BITMAP, BitmapFondoBotonContinuar     ;PINTAR FONDO BOTON JUGAR

                               invoke crt__itoa, contadorPuntos , addr buffer, 10

                               invoke SendMessage, ListBoxPuntuaciones, LB_ADDSTRING, 0, ADDR buffer

                               invoke SetWindowText, StaticPuntuacion, addr buffer

                                mov contadorPuntos, 0

                           .ENDIF

                        .ENDIF

                .ENDIF

        ;-------------------------------------------------------------------------------------------------
        ;                                          WM_DESTROY                                            |
        ;-------------------------------------------------------------------------------------------------

            .ELSEIF uMsg==WM_DESTROY 
                
                invoke KillTimer, hWnd, myTimer                   ;TERMINAR PROGRAMA
                invoke DeleteObject, BitmapPlayer                 ;TERMINAR PROGRAMA
                invoke DeleteObject, BitmapPelota                 ;TERMINAR PROGRAMA
                invoke DeleteObject, BitmapFondoBotonPuntuaciones ;TERMINAR PROGRAMA
                invoke DeleteObject, BitmapFondoBotonSalir        ;TERMINAR PROGRAMA
                invoke DeleteObject, BitmapFondoBotonJugar        ;TERMINAR PROGRAMA
                invoke DeleteObject, BitmapFondo                  ;TERMINAR PROGRAMA
                invoke PostQuitMessage,NULL                       ;TERMINAR PROGRAMA

        ;-------------------------------------------------------------------------------------------------
        ;                                          ELSE_WINPROC                                           |
        ;-------------------------------------------------------------------------------------------------

            .ELSE

                invoke DefWindowProc,hWnd,uMsg,wParam,lParam    
                ret

            .ENDIF
            xor eax,eax
            ret
        WndProc endp
end start