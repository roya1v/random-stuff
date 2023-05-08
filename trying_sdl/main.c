#include <SDL.h>

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

    SDL_Rect rect;
    rect.x = 250;
    rect.y = 150;
    rect.w = 200;
    rect.h = 200;

    SDL_SetRenderDrawColor(ren, 255, 255, 255, 255);
    SDL_RenderDrawRect(ren, &rect);

    SDL_SetRenderDrawColor(ren, 0, 0, 0, 255);

    SDL_RenderPresent(ren);
    // While application is running
    while (!quit)
    {
        // Handle events on queue
        
        while (SDL_PollEvent(&e) != 0) // poll for event
        {
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