//
//  EventDetailsViewController.h
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 02/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEventsListViewController.h"

@interface EventDetailsViewController : UIViewController <eventSelectionDelegate>

@property (nonatomic, strong) NSString *incommingUserId;
@property (nonatomic, strong) NSMutableDictionary *incommingEventDictionary;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
