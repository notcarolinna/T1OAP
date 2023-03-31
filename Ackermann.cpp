#include <iostream>

int ackermann(int m, int n)
{
    if (m == 0) {
        return n + 1;
    } else if (n == 0) {
        return ackermann(m - 1, 1);
    } else {
        return ackermann(m - 1, ackermann(m, n - 1));
    }
}

int main()
{
    std::cout << "Programa Ackermann" << std::endl;

    while (true) {
        std::cout << "Digite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução" << std::endl;

        int m, n;
        std::cin >> m;

        if (m < 0) {
            break;
        }

        std::cin >> n;

        std::cout << "A(" << m << ", " << n << ") = " << ackermann(m, n) << std::endl;
    }

    return 0;
}
