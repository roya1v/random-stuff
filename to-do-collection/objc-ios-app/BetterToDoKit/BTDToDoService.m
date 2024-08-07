//
//  BTDToDoService.m
//  BetterToDo
//
//  Created by Mike S. on 18/10/2023.
//

#import "BTDToDoService.h"
#import <BetterToDoKit/BTDToDoItem.h>

@implementation BTDToDoService

- (NSURLComponents*)getBaseUrl {
    return [[NSURLComponents alloc] initWithString:@"http://localhost:3000"];
}

- (void)fetchAll:(ToDoItemsCompletionHandler)completionHandler {
    NSURLComponents *urlComponens = [self getBaseUrl];
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
        NSMutableArray<BTDToDoItem *> *result = [[NSMutableArray alloc] init];
        for (NSDictionary *objectDictionary in array) {
            BTDToDoItem *item = [[BTDToDoItem alloc] init];
            item.content = objectDictionary[@"content"];
            item.isDone = [objectDictionary[@"is_done"] boolValue];
            item.id = [[NSNumber alloc] initWithLong:[objectDictionary[@"id"] longValue] ];
            [result addObject:item];
        }
        if (error2 != NULL) {
            completionHandler(NULL, error2);
            return;
        }
        completionHandler(result, NULL);
    }] resume];
}

- (void)updateItem:(BTDToDoItem * _Nonnull)item
              then:(ToDoItemCompletionHandler)completionHandler {
    NSURLComponents *urlComponens = [self getBaseUrl];
    urlComponens.path = @"/todos";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlComponens.URL];
    request.HTTPMethod = @"PUT";

    NSError *error;

    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:[item toDictionary] options:kNilOptions error:&error];

    if (error != nil) {
        completionHandler(NULL, error);
    }

    request.HTTPBody = bodyData;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [[NSURLSession.sharedSession dataTaskWithRequest:request
                                   completionHandler:^(NSData * _Nullable data,
                                                       NSURLResponse * _Nullable response,
                                                       NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
            return;
        }
        NSError *error2 = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error2];

        if (error2 != NULL) {
            completionHandler(NULL, error2);
            return;
        }

        BTDToDoItem *item = [[BTDToDoItem alloc] initWithDict:dictionary];
        completionHandler(item, NULL);
    }] resume];
}

- (void)newItem:(BTDToDoItem *)item
           then:(ToDoItemCompletionHandler)completionHandler {

    NSURLComponents *urlComponens = [self getBaseUrl];
    urlComponens.path = @"/todos";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlComponens.URL];
    request.HTTPMethod = @"POST";

    NSError *error;

    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:[item toDictionary] options:kNilOptions error:&error];

    if (error != nil) {
        completionHandler(NULL, error);
    }

    request.HTTPBody = bodyData;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [[NSURLSession.sharedSession dataTaskWithRequest:request
                                   completionHandler:^(NSData * _Nullable data,
                                                       NSURLResponse * _Nullable response,
                                                       NSError * _Nullable error) {
        if (error != NULL) {
            completionHandler(NULL, error);
            return;
        }
        NSError *error2 = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error2];

        if (error2 != NULL) {
            completionHandler(NULL, error2);
            return;
        }

        BTDToDoItem *item = [[BTDToDoItem alloc] initWithDict:dictionary];
        completionHandler(item, NULL);
    }] resume];
}

- (void)deleteItem:(BTDToDoItem *)item then:(void(^)(NSError * error))completionHandler {
    NSURLComponents *urlComponens = [self getBaseUrl];
    urlComponens.path = [NSString stringWithFormat:@"/todos/%@/delete", item.id];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlComponens.URL];
    request.HTTPMethod = @"DELETE";

    NSError *error;

    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:[item toDictionary] options:kNilOptions error:&error];

    if (error != nil) {
        completionHandler(error);
    }

    request.HTTPBody = bodyData;

    [[NSURLSession.sharedSession dataTaskWithRequest:request
                                   completionHandler:^(NSData * _Nullable data,
                                                       NSURLResponse * _Nullable response,
                                                       NSError * _Nullable error) {
        completionHandler(error);
    }] resume];
}

@end
