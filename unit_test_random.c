#include <stdio.h>
#include <stdlib.h>
#include "random.h"


int main( int argc, char **argv ) 
{
	if ( argc > 1 )
	{
		init_random( atoi(argv[1]) );
	}
	else
	{
		init_random( 1 );
	}

	return EXIT_SUCCESS;
}



