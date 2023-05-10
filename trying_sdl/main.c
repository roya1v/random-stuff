#include <SDL.h>

int draw_rect(SDL_Renderer *ren, int x, int y, int w, int h) {
    SDL_Rect rect;
    rect.x = x;
    rect.y = y;
    rect.w = w;
    rect.h = h;

    SDL_SetRenderDrawColor(ren, 255, 255, 255, 255);
    SDL_RenderDrawRect(ren, &rect);

    SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);

    SDL_RenderPresent(ren);

    return 0;
}

int clear_rect(SDL_Renderer *ren, int x, int y, int w, int h) {
    SDL_Rect rect;
    rect.x = x;
    rect.y = y;
    rect.w = w;
    rect.h = h;

    SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);
    SDL_RenderDrawRect(ren, &rect);

    SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);

    SDL_RenderPresent(ren);

    return 0;
}

int main()
{
    SDL_Window *win = NULL;
    SDL_Renderer *ren = NULL;

    SDL_Init(SDL_INIT_EVERYTHING);
    SDL_CreateWindowAndRenderer(640, 480, 0, &win, &ren);

    SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);
    SDL_RenderClear(ren);
    SDL_RenderPresent(ren);
    int quit = 0;

    printf("Hellow world!");

    // Event handler
    SDL_Event e;

    SDL_RenderClear(ren);

    int x = 250;
    int y = 150;
    int w = 200;
    int h = 200;

    draw_rect(ren, x, y, w, h);

    // While application is running
    while (!quit)
    {
        // Handle events on queue
        
        while (SDL_PollEvent(&e) != 0) // poll for event
        {
            
            if(e.type == SDL_KEYDOWN) {
                SDL_RenderClear(ren);

                switch (e.key.keysym.sym) {
                case SDLK_UP:
                    y-=10;
                    break;
                case SDLK_DOWN:
                    y+=10;
                    break;
                case SDLK_RIGHT:
                    x+=10;
                    break;
                case SDLK_LEFT:
                    x-=10;
                    break;
                default:
                    printf("%i", e.key.keysym.sym);
                    break;
                }
                draw_rect(ren, x, y, w, h);
                //SDL_RenderClear(ren);
            
            }
            // User requests quit
            if (e.type == SDL_QUIT) // unless player manually quits
            {
                quit = 1;
            }
        }
    }

    SDL_DestroyRenderer(ren);
    SDL_DestroyWindow(win);
    SDL_Quit();

    return (0);
}