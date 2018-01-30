#ifndef RANDOM_H
#define RANDOM_H

#include<stdint.h>

// initialize seeds
void init_random ( uint32_t seed );

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

#endif
