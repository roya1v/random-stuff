#include <stdio.h>

#include <termios.h>
#include <unistd.h>


#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_RESET   "\x1b[0m"

typedef struct ToDoItem {
    char *content;
    int is_selected;
    int is_done;
} item;

void print_list(item items[]);

int main() {
    item items[] = {
        {"Hello, World", 1, 0},
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
        int key = getchar();
        switch (key) {
            case 65:
                if (curr - 1 >= 0) {
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
            case 10:
            items[curr].is_done = !(items[curr].is_done);
            default:
                // printf("key=%d", key);
                break;
        }
    }
    tcsetattr( STDIN_FILENO, TCSANOW, &oldt);

    return 0;
}

void print_list(item items[]) {
    printf("\e[1;1H\e[2J");
    for (int i = 0; i < 4; i++) {
        char doneness;

        if (items[i].is_done) {
            doneness = '*';
        } else {
            doneness = ' ';
        }

        if (items[i].is_selected) {
            printf(ANSI_COLOR_RED "[%c] %s" ANSI_COLOR_RESET "\n", doneness, items[i].content);
        } else {
            printf("[%c] %s\n", doneness, items[i].content);
        }
    }
}
