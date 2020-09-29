.386
.model flat,stdcall
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include \masm32\include\gdi32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\gdi32.lib
WinMain proto :DWORD,:DWORD,:DWORD,:DWORD
IDB_PALETA equ 101
IDB_PELOTA equ 102
IDB_PAREDIZQ equ 103
IDB_PAREDDER equ 104
IDB_PAREDTOP equ 105
IDB_BLOQUEVERDE equ 106
IDB_BLOQUEGRIS equ 107
PELOTA_NODIRECCION equ 0
PELOTA_IZQUIERDA equ 1
PELOTA_DERECHA equ 2
PELOTA_ARRIBA equ 3
PELOTA_ABAJO equ 4
PALETA_DERECHA equ 5
PALETA_IZQUIERDA equ 6
PALETA_QUIETA equ 0
myTimer equ 100

.data
Bloque struct
   hBitmap dword NULL
   xBloque dword NULL
   yBloque dword NULL
   colorBloque byte NULL
   golpes byte NULL
Bloque ends
contadorBloques dword 0
contadorColumnasBloques dword 0
arregloBloque Bloque 18 dup ({})
xCompare dword 0
PELOTA_MOV db FALSE
PELOTA_QUIETA db FALSE
direccionPaleta db 0
direccionPelotax db 0
direccionPelotay db 0
ClassName db "SimpleWin32ASMBitmapClass",0
AppName  db "Win32ASM Simple Bitmap Example",0
render db FALSE
xPaleta dword 390
yPaleta dword 500
xPelota dword 430
yPelota dword 480

.data?
numeroAl dword ?
indiceBloque dword ?
sizeBloques dword ?
columnasBloques dword ?
altoBloque dword ?
anchoBloque dword ?
anchoCajaBloques dword ?
altoCajaBloques dword ?
sizeArreglo dword ?
hInstance HINSTANCE ?
CommandLine LPSTR ?
hBitmap dd ?
hBitmapPelota dd ?
hBitmapParedIzq dd ?
hBitmapParedDer dd ?
hBitmapParedTop dd ?

.code
start:
 invoke GetModuleHandle, NULL
 mov    hInstance,eax
 invoke GetCommandLine
 mov    CommandLine,eax
 invoke WinMain, hInstance,NULL,CommandLine, SW_SHOWDEFAULT
 invoke ExitProcess,eax

WinMain proc hInst:HINSTANCE,hPrevInst:HINSTANCE,CmdLine:LPSTR,CmdShow:DWORD
 LOCAL wc:WNDCLASSEX
 LOCAL msg:MSG
 LOCAL msg1:MSG
 LOCAL hwnd:HWND
 mov   wc.cbSize,SIZEOF WNDCLASSEX
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
 INVOKE CreateWindowEx,NULL,ADDR ClassName,ADDR AppName,\
           WS_OVERLAPPEDWINDOW,CW_USEDEFAULT,\
           CW_USEDEFAULT,800,600,NULL,NULL,\
           hInst,NULL
 mov   hwnd,eax
 invoke ShowWindow, hwnd,SW_SHOWNORMAL
 invoke UpdateWindow, hwnd
 invoke SetTimer, hwnd, myTimer, 50, NULL
 mov render, TRUE
 mov eax, 0
 .while TRUE
  invoke PeekMessage, ADDR msg, NULL, 0, 0, PM_REMOVE
  .if(eax)
     invoke TranslateMessage, ADDR msg
     invoke DispatchMessage, ADDR msg
     .if msg.message==WM_QUIT
        .break
     .endif
  .elseif (!eax)
     
  ;se supone que aqui puedo renderear
  .endif
 .endw
 mov     eax,msg.wParam
 ret
WinMain endp

WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
   LOCAL ps:PAINTSTRUCT
   LOCAL hdc:HDC
   LOCAL hMemDC:HDC
   LOCAL rect:RECT
   LOCAL contadorColumnaBloque:dword
   .if uMsg==WM_CREATE
      invoke LoadBitmap,hInstance,IDB_PALETA;PALETA
      mov hBitmap,eax

      invoke LoadBitmap,hInstance,IDB_PELOTA;PELOTA
      mov hBitmapPelota,eax

      invoke LoadBitmap,hInstance,IDB_PAREDIZQ;PAREDIZQ
      mov hBitmapParedIzq,eax

      invoke LoadBitmap,hInstance,IDB_PAREDDER;PAREDDER
      mov hBitmapParedDer,eax

      invoke LoadBitmap,hInstance,IDB_PAREDTOP;PAREDTOP
      mov hBitmapParedTop,eax

      ;--------------------------------------------------------------------------------------------------------------
      ;|                                             Iniciar Bloques                                                  |
      ;--------------------------------------------------------------------------------------------------------------

      mov ebx, 0;Aleatorio inicial
      mov edx, 0
      mov ebx, 2
      div ebx
      mov numeroAl, edx

      mov eax, 0
      mov ebx, 0
      mov edx, 0
      mov eax, sizeof arregloBloque
      mov ebx, sizeof Bloque
      div ebx
      mov sizeBloques, eax

      dec sizeBloques
      xor ecx,ecx  
      IniciarBloques:
         mov eax, 0
         mov ebx, 0
         invoke GetTickCount
         mov edx, 0
         mov ebx, 2
         div ebx
        
         
         mov ebx, 0
         mov ebx ,ecx;Presta el contador

         .if edx==0
         invoke LoadBitmap,hInstance,IDB_BLOQUEVERDE
           
         .elseif edx==1
         invoke LoadBitmap,hInstance,IDB_BLOQUEGRIS
            
         .endif

         ;Obtener indice del arreglo
         mov ecx, 0
         mov ecx, ebx
         mov ebx, 0
         mov ebx, eax
         mov eax, 0
         mov eax, 14
         mul ecx

         mov arregloBloque[eax].hBitmap, ebx
         
         mov eax, sizeBloques
         
         
         inc ecx    
         cmp ecx, sizeBloques
      jle IniciarBloques  

         inc sizeBloques

   .elseif uMsg==WM_PAINT
      invoke BeginPaint,hWnd,addr ps
      mov    hdc,eax
      invoke CreateCompatibleDC,hdc
      mov    hMemDC,eax
      invoke SelectObject,hMemDC,hBitmap
      invoke GetClientRect,hWnd,addr rect
      mov edx, 0
      mov eax, rect.right
      mov ebx, 8
      div ebx
      mov rect.right, eax
      mov eax, 0
      mov ebx, 0
      mov edx, 0
      mov eax, rect.bottom
      mov ebx, 28
      div ebx
      mov rect.bottom, eax
      mov eax, 0
      mov ebx, 0
      mov edx, 0
      invoke StretchBlt, hdc, xPaleta, yPaleta, rect.right, rect.bottom, hMemDC, 0, 0, 48, 10, SRCCOPY;PALETA
      
      
      invoke GetClientRect,hWnd,addr rect

      invoke SelectObject,hMemDC,hBitmapPelota
      invoke StretchBlt, hdc, xPelota, yPelota, 20, 19, hMemDC, 0, 0, 7, 6, SRCCOPY;PELOTA

      invoke SelectObject,hMemDC,hBitmapParedIzq
      invoke StretchBlt, hdc, rect.left, 0, 20, rect.bottom, hMemDC, 0, 0, 8, 240, SRCCOPY;PAREDIZQ

      sub rect.right, 20
      invoke SelectObject,hMemDC,hBitmapParedDer
      invoke StretchBlt, hdc, rect.right, 0, 20, rect.bottom, hMemDC, 0, 0, 8, 240, SRCCOPY;PAREDDER

      invoke GetClientRect,hWnd,addr rect

      invoke SelectObject,hMemDC,hBitmapParedTop
      invoke StretchBlt, hdc, 0, 0, rect.right, 20, hMemDC, 0, 0, 224, 8, SRCCOPY;PAREDIZQ
      
      ;-----------------------------------------------------------------------------------------------
      ;|                                    Pintar Bloques                                           |
      ;-----------------------------------------------------------------------------------------------
      .if sizeBloques > 0
      ;Calcular ancho caja de bloques-----------------------------------------------------------------------
      mov eax, 0
      mov eax, rect.right
      sub eax, 300
      mov anchoCajaBloques, eax

      ;Calcular alto caja de bloques-----------------------------------------------------------------------
      mov eax, 0
      mov eax, rect.bottom
      sub eax, 350
      mov altoCajaBloques, eax

      ;Calcular alto Bloque----------------------------------------------------------------------------
      mov edx, 0
      mov eax, 0
      mov ebx, 0
      mov eax, altoCajaBloques
      mov ebx, 4
      div ebx
      mov altoBloque, eax

      ;Calcular ancho Bloque---------------------------------------------------------------------------
      mov eax, 0
      mov eax, sizeBloques
      mov ebx, 0
      mov edx, 0
      mov ebx, 3
      div ebx
      .if sizeBloques <= 5
         mov eax, sizeBloques
      .endif
      mov columnasBloques, eax
      mov edx, 0
      mov ebx, 0
      mov ebx, eax
      mov eax, 0
      mov eax, anchoCajaBloques
      div ebx
      mov anchoBloque, eax
      
      xor ecx, ecx
      mov contadorBloques, 0
      PintarBloquesFilas:
         
         mov contadorColumnasBloques, 0
         mov eax, 0
         mov eax, columnasBloques
         mov ebx, 0
         mov ebx, sizeBloques
         .while contadorColumnasBloques < eax && contadorBloques < ebx
            
            mov edx, 0
            mov eax, 0
            mov eax, 14
            mov ebx, contadorBloques
            mul ebx

            mov ebx, 0
            mov ebx, ecx
            mov indiceBloque, 0
            mov indiceBloque, eax

            invoke SelectObject,hMemDC,arregloBloque[eax].hBitmap

            mov ecx, 0
            mov ecx, ebx

            mov eax, 0
            mov ebx, 0
            mov eax, anchoBloque
            mov ebx, contadorColumnasBloques
            mul ebx
            add eax, 150
            mov ebx, 0
            mov ebx, indiceBloque
            mov arregloBloque[ebx].xBloque, eax

            mov eax, 0
            mov ebx, 0
            mov eax, altoBloque
            mov ebx, ecx
            mul ebx
            add eax, 50
            mov ebx, 0
            mov ebx, indiceBloque
            mov arregloBloque[ebx].yBloque, eax

            mov ebx, ecx
            mov eax, indiceBloque

            invoke StretchBlt, hdc, arregloBloque[eax].xBloque, arregloBloque[eax].yBloque, anchoBloque, altoBloque, hMemDC, 0, 0, 17, 9, SRCCOPY;PAREDIZQ

            mov ecx, ebx

            inc contadorBloques
            inc contadorColumnasBloques
            mov eax, columnasBloques
            mov ebx, sizeBloques
         .endw

         mov contadorColumnasBloques, 0

         mov eax, 0
         mov eax, sizeBloques
         mov ebx, 0
         mov ebx, 3
         div ebx
         .if eax > 0 && edx == 0; En caso de que no sobren bloques 
            mov eax, 0
            mov eax, 2
         .elseif eax >= 0 && edx > 0     
            mov eax, 0
            mov eax, 3
         .endif
         inc ecx
         cmp ecx, eax
      jle PintarBloquesFilas
      .endif
      invoke DeleteDC, hMemDC
      invoke EndPaint,hWnd,addr ps
 .elseif uMsg==WM_CHAR
  .if wParam==100
    mov direccionPaleta, PALETA_DERECHA
    invoke GetClientRect,hWnd,addr rect

    mov eax, 0
    mov eax, rect.right
    sub eax, 127

    mov ebx, 0
    mov ebx, eax
   .if xPaleta < eax

    add xPaleta, 14

    .if !PELOTA_MOV
       add xPelota, 14
    .endif
    
    mov rect.left,  21
    mov eax, 0
    mov eax, rect.right
    sub rect.right, 21
    mov rect.top, 480


    invoke InvalidateRect, hWnd, ADDR rect, TRUE
    .endif
   .elseif wParam==97
   mov direccionPaleta, PALETA_IZQUIERDA
   invoke GetClientRect,hWnd,addr rect

    

    .if xPaleta > 20
   sub xPaleta, 14
   
   .if !PELOTA_MOV
       sub xPelota, 14
   .endif

    mov rect.left,  21
    mov eax, 0
    mov eax, rect.right
    sub rect.right, 21
    mov rect.top, 480


    invoke InvalidateRect, hWnd, ADDR rect, TRUE
    .endif
  .elseif wParam==VK_SPACE
      mov PELOTA_MOV, TRUE
  .endif
 .elseif uMsg==WM_KEYUP
  
 .elseif uMsg==WM_TIMER
    
  invoke GetClientRect,hWnd,addr rect
  add rect.left, 21
  sub rect.right, 21
  add rect.top, 21

  .if PELOTA_MOV
     
     .if !PELOTA_QUIETA
        mov direccionPelotay, PELOTA_ARRIBA
        mov PELOTA_QUIETA, TRUE
     .elseif direccionPaleta == PALETA_IZQUIERDA &&  !PELOTA_QUIETA
        mov direccionPelotay, PELOTA_ARRIBA
        mov direccionPelotax, PELOTA_IZQUIERDA
        mov PELOTA_QUIETA, TRUE
     .elseif direccionPaleta == PALETA_DERECHA && !PELOTA_QUIETA
        mov direccionPelotax, PELOTA_DERECHA
        mov direccionPelotay, PELOTA_ARRIBA
        mov PELOTA_QUIETA, TRUE
    
     .endif


     ;COLISION PAREDES--------------------------------------------------------------
     ;COLISION PAREDES--------------------------------------------------------------
     ;COLISION PAREDES--------------------------------------------------------------
     .if yPelota == 20
        mov direccionPelotay, PELOTA_ABAJO
     .endif

     .if xPelota <= 21  && direccionPelotax == PELOTA_IZQUIERDA
        mov direccionPelotax, PELOTA_DERECHA
     .elseif xPelota >= 738 && direccionPelotax == PELOTA_DERECHA
        mov direccionPelotax, PELOTA_IZQUIERDA
     .endif
     ;COLISION PAREDES--------------------------------------------------------------
     ;COLISION PAREDES--------------------------------------------------------------
     ;COLISION PAREDES--------------------------------------------------------------

     mov eax, 0
     mov eax, xPaleta
     add eax, 88

     mov ebx, 0
     mov ebx, xPaleta
     sub ebx, 10

     .if yPelota == 480  && xPelota >= ebx && xPelota <= eax && direccionPaleta == PALETA_DERECHA
         mov direccionPelotay, PELOTA_ARRIBA
         mov direccionPelotax, PELOTA_DERECHA
     .elseif yPelota == 480  && xPelota >= ebx && xPelota <= eax && direccionPaleta == PALETA_IZQUIERDA
         mov direccionPelotay, PELOTA_ARRIBA
         mov direccionPelotax, PELOTA_IZQUIERDA
     .elseif yPelota == 480 && xPelota >= ebx && xPelota <= eax && direccionPaleta == PALETA_IZQUIERDA && direccionPelotax == PELOTA_DERECHA
        mov direccionPelotax, PELOTA_IZQUIERDA
     .elseif yPelota == 480 && xPelota >= ebx && xPelota <= eax  && direccionPaleta == PALETA_DERECHA && direccionPelotax == PELOTA_IZQUIERDA
        mov direccionPelotax, PELOTA_DERECHA
     .elseif yPelota == 480  && xPelota >= ebx && xPelota <= eax 
        mov direccionPelotay, PELOTA_ARRIBA
     .endif

     ;------------------------------------------------------------------------------------------------------------------
     ;|                                              Colision Bloques
     ;-------------------------------------------------------------------------------------------------------------------

     xor ecx, ecx
     bucle:
        
         
         ;Bucle por hacer

         inc ecx
         cmp ecx, 20
     jle bucle

     .if direccionPelotay == PELOTA_ABAJO
        add yPelota, 10
     .elseif direccionPelotay == PELOTA_ARRIBA
        sub yPelota, 10
     .endif

     .if direccionPelotax == PELOTA_IZQUIERDA
           sub xPelota, 10
     .elseif direccionPelotax == PELOTA_DERECHA
           add xPelota, 10
     .endif
        
     
     invoke InvalidateRect, hWnd, ADDR rect, TRUE
.endif
 .elseif uMsg==WM_DESTROY
  invoke KillTimer, hWnd, myTimer
  invoke DeleteObject,hBitmap
  invoke DeleteObject,hBitmapPelota
  invoke DeleteObject,hBitmapParedDer
  invoke DeleteObject,hBitmapParedIzq
  invoke DeleteObject,hBitmapParedTop
  invoke PostQuitMessage,NULL
 .ELSE
  invoke DefWindowProc,hWnd,uMsg,wParam,lParam
  ret
 .ENDIF
 xor eax,eax
 ret
WndProc endp
end start