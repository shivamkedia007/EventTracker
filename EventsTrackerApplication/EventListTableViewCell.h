//
//  EventListTableViewCell.h
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 02/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *eventImageView;
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventPlaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end
