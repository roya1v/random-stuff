//
//  BTDToDoItem.h
//  BetterToDo
//
//  Created by Mike S. on 18/10/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTDToDoItem : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong, nullable) NSNumber *id;
@property (nonatomic, assign) BOOL isDone;

-(NSDictionary*) toDictionary;
-(id) initWithDict:(NSDictionary*) dictionary;

@end

NS_ASSUME_NONNULL_END
