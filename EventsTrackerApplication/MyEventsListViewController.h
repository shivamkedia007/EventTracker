//
//  MyEventsListViewController.h
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 03/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol eventSelectionDelegate <NSObject>

- (void) eventSelected:(NSMutableDictionary *)selectedEventDictionary;

@end

@interface MyEventsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *incommingEventsArray;
@property (nonatomic, strong) NSString *userId;

@property (nonatomic, assign) id<eventSelectionDelegate> delegate;

@end
