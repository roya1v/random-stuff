//
//  NewItemViewController.m
//  BetterToDo
//
//  Created by Mike S. on 19/02/2024.
//

#import "NewItemViewController.h"
#import <BetterToDoKit/BetterToDoKit.h>

@interface NewItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *itemContentTextField;
@end

@implementation NewItemViewController

#pragma mark - actions

- (IBAction)didTapCreate:(id)sender {
    id service = [[BTDToDoService alloc] init];
    BTDToDoItem *item = [[BTDToDoItem alloc] init];
    item.content = _itemContentTextField.text;
    [service newItem:item then:^(BTDToDoItem * _Nullable items, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self navigationController] popViewControllerAnimated:true];
        });
    }];
}

@end
