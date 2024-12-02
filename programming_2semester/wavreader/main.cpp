#include <iostream>
#include <Windows.h>
#include <conio.h>
#include "wavreader.h"
using namespace std;

void GoToXY(int column, int line)
{
    COORD coord;
    coord.X = column;
    coord.Y = line;

    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);

    if (!SetConsoleCursorPosition(hConsole, coord))
    {
        cout << endl << "Unexpected error occurred." << endl;
        system("pause");
        exit(1);
    }
}

void draw_horizontal_line(int line, int column, int length, char symbol) {
    GoToXY(0, line);
    for (int i = column; i < column+length; ++i) {
        cout << symbol;
    }
}

void draw_vertical_line(int line, int column, int length, char symbol) {
    for (int i = line; i < line+length; ++i) {
        GoToXY(column, i);
        cout << symbol;
    }
}

void clear_window() {
    GoToXY(0,0);
    for (int i = 0; i < 29; ++i) {
        draw_horizontal_line(i, 0, 52, ' ');
    }
}

void draw_info(wavreader reader) {
    clear_window();
    GoToXY(0,0);
    cout << "WAVE Audio analyzer. H - Help. Esc - Exit.";
    draw_horizontal_line(1, 0, 50, '*');
    cout << endl << "FILE METADATA:" << endl;
    if (reader.is_open()) {
        reader.print_header();
    } else {
        cout << "Failed to open the file.\nPlease restart the application.\n";
    }
}

void draw_help() {
    clear_window();
    GoToXY(0,0);
    cout << "WAVE Audio analyzer. H - Help. Esc - Exit.";
    draw_horizontal_line(1, 0, 50, '*');
    cout << endl << "List of available commands:" << endl;
    cout << "'Esc' - Exit the program" << endl;
    cout << "'H' - List of commands" << endl;
    cout << "'I' - File metadata" << endl;
    cout << "'G' - Show graph" << endl;
    cout << "'->' - move 1 second forward" << endl;
    cout << "'<-' - move 1 second back" << endl;
}

void print_max_message() {
    GoToXY(0, 27);
    cout << "You have reached the end of file.";
}

bool draw_analytics(wavreader reader, int second = 0) {
    uint32_t maximum = reader.get_length();
    if (second < 0 || second > maximum-1) {
        print_max_message();
        return false;
    }
    wavreader::frequencies result = reader.read_one_second(second);

    clear_window();
    GoToXY(0,0);
    cout << "WAVE Audio analyzer. H - Help. Esc - Exit.";
    draw_horizontal_line(1, 0, 50, '*');
    GoToXY(0, 22);
    for (int i = 0; i < 21; ++i) {
        if (i % 2 == 0) {
            cout << 0.05*i;
        } else {
            cout << "   ";
        }
        if (i == 0 || i == 20) {
            cout << "  ";
        }
        for (int j = 0; j < 9; ++j) {
            cout << "    ";
            if ((result.results[j] / (double)(0.05*i))*100 >= 100-0.00001) {
                cout << "*";
            } else {
                cout << " ";
            }
        }
        GoToXY(0, 22-i);
    }
    draw_vertical_line(2, 4, 24, '*');
    draw_horizontal_line(23, 0, 50, '*');
    GoToXY(5, 24);
    cout << " 50   100  200  500  1k   2k   5k   10k  20k ";
    GoToXY(0, 25);
    cout << "Current second: " << second+1 << endl << "Length: " << reader.get_length() << " seconds";
    return true;
}

int main(int argc, char *argv[]) {
    string name = "";
    int32_t current = 0;
    int state = 'g';
    wavreader reader;

    if (argc == 2) {
        name = argv[1];
    } else {
        draw_info(reader);
        system("pause");
        exit(1);
    }

    if (reader.open_file(name)) {
        draw_analytics(reader);
        while (true) {
            int key = 0;
            if (_kbhit) {
                key = _getch();
                if (state == key) {
                    continue;
                } else if (key == 27) {
                    reader.close_file();
                    exit(0);
                } else if (key == 'g') {
                    state = 'g';
                    draw_analytics(reader, current);
                } else if (key == 'i') {
                    state = 'i';
                    draw_info(reader);
                } else if (key == 'h') {
                    state = 'h';
                    draw_help();
                } else if (key == 224) {
                    if (state == 'h' || state == 'i') {
                        continue;
                    }
                    switch (_getch()) {
                        case 75:
                            if (draw_analytics(reader, current-1)) {
                                current--;
                            }
                            break;
                        case 77:
                            if (draw_analytics(reader, current+1)) {
                                current++;
                            }
                            break;
                    }
                }
            }
        }
    } else {
        draw_info(reader);
    }

    system("pause");
    return 0;
}
