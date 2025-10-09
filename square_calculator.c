#include <stdio.h>

// Define a class-like structure
typedef struct {
    int number;
} Calculator;

// Function to compute square
int square(Calculator *calc) {
    return calc->number * calc->number;
}

int main() {
    Calculator calc;
    calc.number = 5;

    int result = square(&calc);
    printf("Square of %d is %d\n", calc.number, result);

    return 0;
}
