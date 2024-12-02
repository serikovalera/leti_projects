#include <cstdio>
#include <iostream>
#include <cstdlib>
#include <string>
#include <conio.h>
#include <stdlib.h>
#include <Windows.h>
#include <vector>

using namespace std;

HANDLE handle = GetStdHandle(STD_OUTPUT_HANDLE);

void SetCursorPosition(short x, short y) {
    HANDLE output = GetStdHandle(STD_OUTPUT_HANDLE);
    COORD pos = { x , y };
    SetConsoleCursorPosition(output, pos);
};

void ClearTabl() {
    for (int i = 3; i < 34; i++) {
        for (int j = 3; j < 200; j++) {
            SetCursorPosition(j, i); cout << " ";
        }
    }
    SetCursorPosition(0, 0);
}

void arrVer(double* arr, double* arrV, unsigned long Length) {

    for (int i = 0; i < 256; i++) {
        arrV[i] = round((arr[i] / Length) * 1000000000) / 1000000000;
    }

}

void arr_wo_Ver(double* arr, unsigned long* Length,char* argc) {
    FILE* file;
    errno_t error = 0;
    error = fopen_s(&file, argc, "rb");
    if (error != 0)
    {
        SetCursorPosition(10, 10);
        cout << "Не удалось открыть файл ";
    }
    fseek(file, 0, SEEK_END);
    *Length = ftell(file);
    fseek(file, 0, SEEK_SET);
    for (int i = 0; i < 256; i++) {
        arr[i] = 0;
    }
    fseek(file, 0, SEEK_SET);
    unsigned char data = 0;
    for (unsigned long i = 0; i < *Length; i++) {
        fread_s(&data, sizeof(data), sizeof(data), 1, file);
        arr[(int)data]++;
    }
    fclose(file);
}

void Palitra_settings() {
    SetCursorPosition(4, 36);
    cout << "Q - Выход";
    SetCursorPosition(20, 36);
    cout << "1 - таблица вероятности";
    SetCursorPosition(20, 38);
    cout << "2 - таблица количества";
}

void Ramka() {
    cout << "   ";
    for (int i = 0; i < 16; i++) {
        SetCursorPosition(3 + i * 12, 1);
        cout << i;
    }
    SetCursorPosition(2, 2);
    cout << '+';
    for (int i = 2; i < 200; i++) {
        SetCursorPosition(1 + i, 2);
        cout << '-';
        SetCursorPosition(1 + i, 34);
        cout << '-';
    }
    SetCursorPosition(0, 3);
    for (int i = 0; i < 16; i++) {
        cout << i << endl << endl;
    }
    for (int i = 1; i < 31; i++) {
        SetCursorPosition(2, 2 + i);
        cout << '|' << endl << endl;
    }
    SetCursorPosition(2, 33);
    cout << '|';
    SetCursorPosition(200, 33);
    cout << '|';
    SetCursorPosition(2, 34);
    cout << '+';
    SetCursorPosition(200, 2);
    cout << '+';
    SetCursorPosition(200, 34);
    cout << '+';
    for (int i = 3; i < 33; i++) {
        SetCursorPosition(200, i);
        cout << '|' << endl << endl;
    }
    SetCursorPosition(0, 0);
}

void tabl_with_Ver(double UV, double* arrV) {
    ClearTabl();
    for (short i = 0; i < 256; i++) {
        if (i % 16 == 0) {
            int cnt = i / 16;
            SetCursorPosition(3, 2 * cnt + 3);
            if (arrV[i] >= UV) {
                SetConsoleTextAttribute(handle, 7); cout << arrV[i]; SetConsoleTextAttribute(handle, 15);
            }
            else if (arrV[i] < UV) { cout << arrV[i]; }
        }
        else if (i % 16 != 0) {
            int i1 = i;
            int cnt2 = 0;
            while (i1 > 16) {
                i1 -= 16;
                cnt2++;
            }
            SetCursorPosition(3 + 12 * i1, 2 * cnt2 + 3);
            if (arrV[i] >= UV) {
                SetConsoleTextAttribute(handle, 7); cout << arrV[i]; SetConsoleTextAttribute(handle, 15);
            }
            else if (arrV[i] < UV) { cout << arrV[i]; }
        }
    }
    SetCursorPosition(0, 0);
}

void tabl_withOut_Ver(double UV,  double* arr, double* arrV) {
    ClearTabl();

    for (short i = 0; i < 256; i++) {
        if (i % 16 == 0) {
            int cnt = i / 16;
            SetCursorPosition(3, 2 * cnt + 3);
            if (arrV[i] >= UV) {
                SetConsoleTextAttribute(handle, 7); cout << (int)arr[i]; SetConsoleTextAttribute(handle, 15);
            }
            else if (arrV[i] < UV) { cout << (int)arr[i]; }
        }
        else if (i % 16 != 0) {
            int i1 = i;
            int cnt2 = 0;
            while (i1 > 16) {
                i1 -= 16;
                cnt2++;
            }
            SetCursorPosition(3 + 12 * i1, 2 * cnt2 + 3);
            if (arrV[i] >= UV) {
                SetConsoleTextAttribute(handle, 7); cout << (int)arr[i]; SetConsoleTextAttribute(handle, 15);
            }
            else if (arrV[i] < UV) { cout << (int)arr[i]; }
        }
    }
    SetCursorPosition(0, 0);
}

int main(int argv, char* argc[])
{
    system("cls");
    setlocale(0, "");
    double UV;
    cout << "Введите вероятность: ";
    cin >> UV;
    double* arrV = new double[256];
    double* arr_wo_V = new double[256];
    unsigned long Length;
    arr_wo_Ver(arr_wo_V, &Length,argc[1]);
    arrVer(arr_wo_V, arrV, Length);
    char com = ' ', tabl = ' ';
    short color = 3;
    unsigned long del = 10000;
    cout << " Для вывода таблиц Количества/Вероятности нажмите 1/2";
    while (com == ' ') {
        com = _getch();
        if ((com == '1') || (com == '2')) { tabl = com; break; }
        else { com = ' '; }
    }
    system("cls");
    Palitra_settings();
    SetCursorPosition(0, 0);
    cout << "Количество байт в файле: " << Length;
    SetCursorPosition(40, 0);   
    cout << "Вероятность: " << UV << endl;
    Ramka();
    while (com != 'q') {       
        if (com == '1') { tabl_with_Ver(UV, arrV); tabl = '1'; }
        if (com == '2') { tabl_withOut_Ver(UV, arr_wo_V, arrV); tabl = '2'; }
        com = ' ';
        com = _getch();
    }
    SetCursorPosition(0, 40);
    return 0;
}