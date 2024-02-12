//
//  MainViewController.m
//  BetterToDo
//
//  Created by Mike S. on 12/02/2024.
//

#import "MainViewController.h"
#import "ToDoService.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<ToDoItem *> *items;
@property (nonatomic, strong) ToDoService *service;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];

    self.service = [[ToDoService alloc] init];

    [self.service fetchAll:^(NSArray<ToDoItem *> *items, NSError *error) {
        if (error == nil) {
            self.items = [items mutableCopy];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

- (IBAction)didTapAdd:(UIBarButtonItem *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New todo item"
                                                                   message:@"Enter the content of the new todo item"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cellView = [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
    ToDoItem *item = self.items[indexPath.row];

    UIListContentConfiguration *configuration = [UIListContentConfiguration cellConfiguration];
    configuration.text = item.content;
    if (item.isDone) {
        configuration.image = [UIImage systemImageNamed:@"checkmark"];
    }
    cellView.contentConfiguration = configuration;

    return cellView;
}

#pragma mark - UITableViewDelegate

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoItem *item = self.items[indexPath.row];

    UIContextualAction *action = [UIContextualAction
                                  contextualActionWithStyle:UIContextualActionStyleNormal
                                  title:nil
                                  handler:^(UIContextualAction * _Nonnull action,
                                            __kindof UIView * _Nonnull sourceView,
                                            void (^ _Nonnull completionHandler)(BOOL)) {
        item.isDone = !item.isDone;
        [self.service updateItem:item
                            then:^(ToDoItem * _Nullable items,
                                   NSError * _Nullable error) {
            if (error == nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            }
        }];
    }];
    if (item.isDone) {
        action.image = [UIImage systemImageNamed:@"arrow.uturn.backward"];
        action.backgroundColor = [UIColor systemBlueColor];
    } else {
        action.image = [UIImage systemImageNamed:@"checkmark"];
        action.backgroundColor = [UIColor systemGreenColor];
    }
    UISwipeActionsConfiguration *configuration = [UISwipeActionsConfiguration configurationWithActions:@[action]];
    return configuration;
}

@end
