//
//  ToDoService.h
//  BetterToDo
//
//  Created by Mike S. on 18/10/2023.
//

#import <Foundation/Foundation.h>
#import "ToDoItem.h"

@interface ToDoService : NSObject
- (void) fetchAll: (void (^_Nullable)( NSArray<ToDoItem *> * _Nullable  items, NSError * _Nullable  error))completionHandler;
@end
