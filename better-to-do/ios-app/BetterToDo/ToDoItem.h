//
//  ToDoItem.h
//  BetterToDo
//
//  Created by Mike S. on 18/10/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoItem : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) BOOL isDone;

@end

NS_ASSUME_NONNULL_END
