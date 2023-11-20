//
//  ToDoService.h
//  BetterToDo
//
//  Created by Mike S. on 18/10/2023.
//

#import <Foundation/Foundation.h>
#import "ToDoItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ToDoItemCompletionHandler)(ToDoItem * _Nullable  items,
                                          NSError * _Nullable  error);

typedef void (^ToDoItemsCompletionHandler)( NSArray<ToDoItem *> * _Nullable items,
                                            NSError * _Nullable  error);

@interface ToDoService : NSObject
- (void)fetchAll:(ToDoItemsCompletionHandler)completionHandler;
- (void)updateItem:(ToDoItem*)item
              then:(ToDoItemCompletionHandler)completionHandler;
- (void)newItem:(ToDoItem*)item
           then:(ToDoItemCompletionHandler)completionHandler;
@end

NS_ASSUME_NONNULL_END
