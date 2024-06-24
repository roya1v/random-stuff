//
//  BTDToDoService.h
//  BetterToDo
//
//  Created by Mike S. on 18/10/2023.
//

#import <Foundation/Foundation.h>
#import <BetterToDoKit/BTDToDoItem.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ToDoItemCompletionHandler)(BTDToDoItem * _Nullable  items,
                                          NSError * _Nullable  error);

typedef void (^ToDoItemsCompletionHandler)( NSArray<BTDToDoItem *> * _Nullable items,
                                            NSError * _Nullable  error);

@interface BTDToDoService : NSObject
- (void)fetchAll:(ToDoItemsCompletionHandler)completionHandler;
- (void)updateItem:(BTDToDoItem*)item
              then:(ToDoItemCompletionHandler)completionHandler;
- (void)newItem:(BTDToDoItem*)item
           then:(ToDoItemCompletionHandler)completionHandler;
- (void)deleteItem:(BTDToDoItem*)item
              then:(void(^)(NSError * _Nullable error))completionHandler;
@end

NS_ASSUME_NONNULL_END
