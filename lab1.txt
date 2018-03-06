$mod842							;nie przepisujcie tego szajsu na pałę, klaus jest uczulony na plagiaty
org 0h							;w tym asmie można zrealizować pętlę czy warunek na jakieś 5 sposobów, przerobienie nie powinno być trudne

		mov A, #00				;int A = 0; int B;
								;
L:								;do {
		inc A					;	A++;
		anl A, #00111111B		;	A = A & 0x3f;	//zapobiega wyświetlaniu się kropki na wyświetlaczu (zeruje najstarsze 2 bity)
		mov B, A				;	B = A;
		anl A, #00001111B		;	A = A & 0x0f;	//bierzemy wyłącznie część rejstru z liczbą do porównania (4 pierwsze bity, następne 2 to numer wyświetlacza)
								;
		cjne A, #10, J			;	if(A == 10) {
		mov A, B				;		A = B;		//jeśli na wyświetlaczu ma być 10 to trzeba dodać 6 aby pominąć liczby od 10 do 15 przeskakując do zera
		add A, #06				;		A += 6;		//przy okazji zostanie dodane 1 do numeru obecnego wyświetlacza
		mov B, A				;		B = A;		//00001010B + 00000110B = 00010000B
J:								;	}
		mov P2, B				;	P2 = B;			//wysłanie danych na wyświetlacz
		mov A, #10				;	A = 10;			//funkcja delay bierze wartość z akumulatora jako argument
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
		djnz R2, DLY1			;		--R2; } while(R2 > 0);		//djnz w jednej operacji zmniejsza rejestr o 1 i skacze do etykiety jeśli > 0
		djnz R1, DLY0			;	--R1; } while(R1 > 0);
		ret						;	return;
								;}
