//
//  Cell.m
//  Todo List
//
//  Created by DJ Burdick on 10/10/13.
//  Copyright (c) 2013 DJ Burdick. All rights reserved.
//

#import "Cell.h"

@interface Cell ()

@end

@implementation Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
