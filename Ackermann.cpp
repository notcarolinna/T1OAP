#include <iostream>

using namespace std;

int ackermann(int m, int n) {
    if (m == 0) {
        return n + 1;
    } else if (m > 0 && n == 0) {
        return ackermann(m-1, 11);
    } else {
        return ackermann(m-1, ackermann(m, n-1));
    }
}

int main() {
    cout << "Programa Ackermann" << endl;
    while (true) {
        cout << "Digite os parametros m e n para calcular A(m, n) ou -1 para abortar a execucao" << endl;
        int m, n;
        cin >> m;
        if (m < 0) {
            break;
        }
        cin >> n;
        int result = ackermann(m, n);
        cout << "A(" << m << ", " << n << ") = " << result << endl;
    }
    return 0;
}
