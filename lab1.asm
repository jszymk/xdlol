$mod842							;nie przepisujcie tego szajsu na pa��, klaus jest uczulony na plagiaty
org 0h							;w tym asmie mo�na zrealizowa� p�tl� czy warunek na jakie� 5 sposob�w, przerobienie nie powinno by� trudne

		mov A, #00				;int A = 0; int B;
								;
L:								;do {
		inc A					;	A++;
		anl A, #00111111B		;	A = A & 0x3f;	//zapobiega wy�wietlaniu si� kropki na wy�wietlaczu (zeruje najstarsze 2 bity)
		mov B, A				;	B = A;
		anl A, #00001111B		;	A = A & 0x0f;	//bierzemy wy��cznie cz�� rejstru z liczb� do por�wnania (4 pierwsze bity, nast�pne 2 to numer wy�wietlacza)
								;
		cjne A, #10, J			;	if(A == 10) {
		mov A, B				;		A = B;		//je�li na wy�wietlaczu ma by� 10 to trzeba doda� 6 aby pomin�� liczby od 10 do 15 przeskakuj�c do zera
		add A, #06				;		A += 6;		//przy okazji zostanie dodane 1 do numeru obecnego wy�wietlacza
		mov B, A				;		B = A;		//00001010B + 00000110B = 00010000B
J:								;	}
		mov P2, B				;	P2 = B;			//wys�anie danych na wy�wietlacz
		mov A, #10				;	A = 10;			//funkcja delay bierze warto�� z akumulatora jako argument
		call DELAY				;	delay(A);
		mov A, B				;	A = B;
		jmp L					;} while(true);
		
DELAY:							;void delay(int A) {
		mov R1, A				;	int R1 = A;
DLY0:							;	do {
		mov R2, #01Bh			;		int R2 = 0x1b;
DLY1:							;		do {
		mov R3, #0FFh			;			int R3 = 0xff;
		djnz R3, $				;			while(R3 > 0) {--R3;} 	//dolar odpowiada obecnej linii
		djnz R2, DLY1			;		--R2; } while(R2 > 0);		//djnz w jednej operacji zmniejsza rejestr o 1 i skacze do etykiety je�li > 0
		djnz R1, DLY0			;	--R1; } while(R1 > 0);
		ret						;	return;
								;}