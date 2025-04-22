#include <stdio.h>

#include <termios.h>
#include <unistd.h>

typedef struct ToDoItem {
    char *content;
    int is_selected;
    int is_done;
} item;

void print_list(item items[]);

int main() {
    item items[] = {
        {"Hello, World", 0, 0},
        {"Task 1", 0, 0},
        {"Task 2", 0, 0},
        {"Task 3", 0, 0},
    };
    
    static struct termios oldt, newt;
    tcgetattr( STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_lflag &= ~(ICANON | ECHO);         
    tcsetattr( STDIN_FILENO, TCSANOW, &newt);

    int curr = 0;

    while (1) {
        print_list(items);
        switch (getchar()) {
            case 65:
                if (curr - 1 > 0) {
                    items[curr].is_selected = 0;
                    curr = curr - 1;
                    items[curr].is_selected = 1;
                }
                break;
            case 66:
                if (curr + 1 < 4) {
                    items[curr].is_selected = 0;
                    curr = curr + 1;
                    items[curr].is_selected = 1;
                }
                break;
            default:
                break;
        }
    }
    tcsetattr( STDIN_FILENO, TCSANOW, &oldt);

    return 0;
}

void print_list(item items[]) {
    printf("\e[1;1H\e[2J");
    for (int i = 0; i < 4; i++) {
        printf("[%d] %s\n", items[i].is_selected, items[i].content);
    }
}
