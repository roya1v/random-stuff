//
//  BTDToDoItem.m
//  BetterToDo
//
//  Created by Mike S. on 18/10/2023.
//

#import "BTDToDoItem.h"

NS_ASSUME_NONNULL_BEGIN

@implementation BTDToDoItem

- (nonnull NSDictionary *)toDictionary {
    NSMutableDictionary *itemDictionary = [[NSMutableDictionary alloc] init];
    itemDictionary[@"id"] = self.id;
    itemDictionary[@"content"] = self.content;
    itemDictionary[@"is_done"] = [[NSNumber alloc] initWithBool:self.isDone];
    return itemDictionary;
}

- (nonnull id)initWithDict:(nonnull NSDictionary *)dictionary {
    self = [self init];
    if(self) {
        self.id = dictionary[@"id"];
        self.content = dictionary[@"content"];
        self.isDone = [dictionary[@"is_done"] boolValue];
    }
    return self;
}

- (nonnull id)init:(nonnull NSString *)content {
    self = [self init];
    if(self) {
        self.content = content;
        self.isDone = NO;
    }
    return self;
}

- (nonnull id)init:(nonnull NSString *)content isDone:(BOOL)isDone {
    self = [self init];
    if(self) {
        self.content = content;
        self.isDone = isDone;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
