//
//  TodoViewController.m
//  Todo List
//
//  Created by DJ Burdick on 10/10/13.
//  Copyright (c) 2013 DJ Burdick. All rights reserved.
//

#import "TodoViewController.h"
#import "Cell.h"

static const int TodoSections = 1;

@interface TodoViewController ()
@property(strong, nonatomic) NSMutableArray *items;

@end

@implementation TodoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
        
        NSString *myStr = @"Install Todo List";
        [self.items addObject:myStr];
        NSString *myStr2 = @"";  // default to new blank item
        [self.items addObject:myStr2];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UINib *cellNib = [UINib nibWithNibName:@"Cell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"Cell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTodoItem)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)addNewTodoItem
{
    NSString *myStr = @"";  // add blank item for editing
    [self.items addObject:myStr];

    [self.tableView reloadData];
}

- (void) addItemDoneEditing:(Cell *)cell
{
    NSString *addText = cell.item.text;

    [self addTodoText:addText];

    [cell.item resignFirstResponder];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TodoSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item.text = [self.items objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.item.delegate = self;

    if (indexPath.row == self.items.count-1) {
        [cell.item becomeFirstResponder];

        [tableView selectRowAtIndexPath:indexPath animated:TRUE scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *addText = textField.text;

    [self addTodoText:addText];

    [textField resignFirstResponder];
    [self.tableView reloadData];

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
// TODO save to datasource
}

- (void)addTodoText:(NSString *)todoText {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.items replaceObjectAtIndex:[indexPath row] withObject:todoText];
}

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
