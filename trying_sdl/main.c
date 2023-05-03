#include <SDL.h>

#define SCREEN_WIDTH 640
#define SCREEN_HEIGHT 480

int main() {
      SDL_ShowSimpleMessageBox( SDL_MESSAGEBOX_INFORMATION, 
              "Hello World",
              "You have successfully compiled and linked an SDL2"
              " program, congratulations.", NULL );
}