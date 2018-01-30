#include <stdio.h>
#include <stdlib.h>
#include "mt19937.h"
#include "random.h"

// initialize seeds
void init_random ( uint32_t seed )
{
	srand( (unsigned int) seed );

	uint64_t combo_seed;
	uint32_t rnd1 = rand();
	uint32_t rnd2 = rand();
	uint32_t *ptr = (uint32_t *) &combo_seed;
	ptr[0] = rnd1; // x86 arch is little endian (LSB in lowest address)
	ptr[1] = rnd2;
	
	init_genrand64( combo_seed );
	fprintf( stdout, "[PRNG] init mt19937-64 with seed[%u] %lu (%u %u)\n", seed, combo_seed, rnd2, rnd1 );
}

// generates a random number on [0,1]
double gen_random_closed_01 ();

// generates a random number on [0,1)
double gen_random_half_closed_01 ();

// generates a random number on (0,1)
double gen_random_open_01 ();

// generates a random number on [a,b]
double gen_random_closed_a_to_b ();

// generates a random number on [a,b]
double gen_random_closed_a_to_b ();

// generates a random number on [a,b)
double gen_random_half_closed_a_to_b ();

// generates a random number on (a,b)
double gen_random_open_a_to_b ();

// generates a random number on [a,b]
uint64_t gen_random_integer_a_to_b ();

