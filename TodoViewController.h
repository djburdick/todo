//
//  TodoViewController.h
//  Todo List
//
//  Created by DJ Burdick on 10/10/13.
//  Copyright (c) 2013 DJ Burdick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"

@interface TodoViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, CellDelegate>

@property(strong, nonatomic) NSMutableArray *items;

@end
