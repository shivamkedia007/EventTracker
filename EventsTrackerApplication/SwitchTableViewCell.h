//
//  SwitchTableViewCell.h
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 02/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UISwitch *switchButton;
@property (nonatomic, strong) IBOutlet UILabel *cellTextLabel;

@end
