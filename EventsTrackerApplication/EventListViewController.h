//
//  EventListViewController.h
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 02/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEventsListViewController.h"

@interface EventListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, eventSelectionDelegate>

@property (nonatomic, strong) NSString *incommingUserID;
@property (nonatomic, strong) NSMutableArray *incommingUserEventsArray;

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
