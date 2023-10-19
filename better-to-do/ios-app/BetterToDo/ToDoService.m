//
//  ToDoService.m
//  BetterToDo
//
//  Created by Mike S. on 18/10/2023.
//

#import "ToDoService.h"
#import "ToDoItem.h"

@implementation ToDoService

- (void)fetchAll:(void (^__strong)(NSArray<ToDoItem *> * _Nullable __strong, NSError * _Nullable __strong))completionHandler {
    NSURLComponents *urlComponens = [[NSURLComponents alloc] initWithString:@"http://localhost:3000"];
    urlComponens.path = @"/todos";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlComponens.URL];
    request.HTTPMethod = @"GET";
    
    [[NSURLSession.sharedSession dataTaskWithRequest:request
                                  completionHandler:^(NSData * _Nullable data,
                                                      NSURLResponse * _Nullable response,
                                                      NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
            return;
        }
        NSError *error2 = nil;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error2];
        NSMutableArray<ToDoItem *> *result = [[NSMutableArray alloc] init];
        for (NSDictionary *objectDictionary in array) {
            ToDoItem *item = [[ToDoItem alloc] init];
            item.content = objectDictionary[@"content"];
            item.isDone = objectDictionary[@"is_done"];
            item.id = [objectDictionary[@"id"] longValue];
            [result addObject:item];
        }
        if (error2 != NULL) {
            completionHandler(NULL, error2);
            return;
        }
        completionHandler(result, NULL);
    }] resume];

}

@end
