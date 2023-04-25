#include <stdio.h>

int ackermann(int m, int n);

int main() {

    int m, n;

    printf("Digite o valor m: ");
    scanf("%d", &m);

    printf("Digite o valor n: ");
    scanf("%d", &n);

    int result = ackermann(m, n);

    printf("Resultado: %d\n", result);

    return 0;
}

int ackermann(int m, int n) {
    if (m == 0)
        return n + 1;
    else if (n == 0)
        return ackermann(m - 1, 1);
    else
        return ackermann(m - 1, ackermann(m, n - 1));
}
