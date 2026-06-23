#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/* Se alla funzione "check()" viene passato
   un valore di tipo "int", vi verifica
   un cast implicito da "int" a "short",
   con perdita di dati.
 */

int check(unsigned short len, char * p) {

	if(len >= 10)
		return -1;

	return 0;
}

int main(int argc, char *argv[]) {

	char buf[10];

	int n = atoi(argv[1]);
	char * string = argv[2];

	if( check(n, string) == -1 ) {
		printf("Errore: il valore di n eccede la dimensione del buffer\n");
		return -1;
	}

	strncpy(buf, string, n);
	printf("%s\n", buf);

	return 0;
}


