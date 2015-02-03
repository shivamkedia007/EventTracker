//
//  EventListCollectionViewCell.m
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 02/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import "EventListCollectionViewCell.h"

@implementation EventListCollectionViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void) designUIComponent
{
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.layer setBorderWidth:2];
    [self.layer setCornerRadius:10];
}

@end
