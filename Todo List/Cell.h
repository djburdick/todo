//
//  Cell.h
//  Todo List
//
//  Created by DJ Burdick on 10/10/13.
//  Copyright (c) 2013 DJ Burdick. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellDelegate <NSObject>

@optional
- (void)addItemDoneEditing:(id)sender;

@end

@interface Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *item;
@property (weak, nonatomic) UITableView *parent;
@property (strong, nonatomic) id <CellDelegate> delegate;

@end
