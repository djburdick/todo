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

        [self addNewBlankItem];

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
    [self syncAllCellsWithDataStore];

    [self addNewBlankItem];

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
    cell.item.delegate = self;  // so we can access textFieldShouldReturn

    if (indexPath.row == self.items.count-1) {
        [cell.item becomeFirstResponder];

        [tableView selectRowAtIndexPath:indexPath animated:TRUE scrollPosition:UITableViewScrollPositionNone];
    }
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (!self.tableView.editing) {
        NSString *addText = textField.text;

        [self addTodoText:addText];
        [self addNewBlankItem];

        [textField resignFirstResponder];
        [self.tableView reloadData];
    } else {
        [self setEditing:NO animated:YES];
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self setEditing:YES animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];

    if(!editing) {
        // triggered when user hits "done"
        [self syncAllCellsWithDataStore];
    }
}

- (void)syncAllCellsWithDataStore
{
    for (int i=0; i < self.items.count; i++) {
        Cell *cell = (Cell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];

        [self.items replaceObjectAtIndex:i withObject:cell.item.text];
    }
}

- (void)addNewBlankItem {
    NSString *myStr = @"";
    [self.items addObject:myStr];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

- (void)addTodoText:(NSString *)todoText {
    [self.items replaceObjectAtIndex:self.items.count-1 withObject:todoText];
}


@end
