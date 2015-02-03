//
//  EventDetailsViewController.m
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 02/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "ImageViewTableViewCell.h"
#import "Constants.h"
#import "SwitchTableViewCell.h"
#import "MyEventsListViewController.h"

typedef enum
{
    kImageViewItem,
    kEventNameItem,
    kEventPlaceItem,
    kEventPriceItem,
    kEventMyEvent
}kEventDetailsItems;

@interface EventDetailsViewController ()

@property (nonatomic, strong) NSMutableArray *rowsArray;
@property (nonatomic) BOOL isMyEvent;

@end

@implementation EventDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setTitle:NSLocalizedString(@"Event Details", @"")];
    
    self.rowsArray = [NSMutableArray arrayWithObjects:
                      @(kImageViewItem),
                      @(kEventNameItem),
                      @(kEventPlaceItem),
                      @(kEventPriceItem),
                      @(kEventMyEvent), nil];

    UINib *nib = [UINib nibWithNibName:@"ImageViewTableViewCell"
                                bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"ImageViewTableViewCellIdentifier"];
    
    nib = [UINib nibWithNibName:@"SwitchTableViewCell"
                         bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"SwitchTableViewCellIdentifier"];
    
    // Adding the Swipe Gesture
    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                   action:@selector(screenSwipeLeft)];
    swipeleft.numberOfTouchesRequired=1;
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self checkIfTheCurrentEventIsFollowedByUser];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Swipe gesture Methods

- (void) screenSwipeLeft
{
    MyEventsListViewController *myEventListScreen = [[MyEventsListViewController alloc] init];
    
    [myEventListScreen setDelegate:self];
    [myEventListScreen setUserId:self.incommingUserId];
    
    [self.navigationController pushViewController:myEventListScreen
                                         animated:YES];
}

#pragma mark - EventSwipe Methods

- (void) eventSelected:(NSMutableDictionary *)selectedEventDictionary
{
    self.incommingEventDictionary = selectedEventDictionary;

    [self checkIfTheCurrentEventIsFollowedByUser];
    
    [self.tableView reloadData];
}

#pragma mark - Private Methods

- (void) switchButtonPressed:(UISwitch *)sender
{
    // save the Info in the header dictionary
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *valueArray = [userDefault objectForKey:self.incommingUserId];
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:valueArray];
    
    if(sender.isOn)
    {
        BOOL isPresent = NO;
        
        for(NSMutableDictionary *dictionary in valueArray)
        {
            if([dictionary[CONSTANT_EVENT_ID] isEqualToString:self.incommingEventDictionary[CONSTANT_EVENT_ID]])
                isPresent = YES;
        }
        
        if(!isPresent)
            [tempArray addObject:self.incommingEventDictionary];
    }
    else
    {
        BOOL isPresent = NO;
        
        for(NSMutableDictionary *dictionary in valueArray)
        {
            if([dictionary[CONSTANT_EVENT_ID] isEqualToString:self.incommingEventDictionary[CONSTANT_EVENT_ID]])
            {
                isPresent = YES;
            }
        }
        
        if(isPresent)
            [tempArray removeObject:self.incommingEventDictionary];
    }
    
    valueArray = [NSMutableArray arrayWithArray:tempArray];
    [userDefault setObject:valueArray
                    forKey:self.incommingUserId];
    [userDefault synchronize];
}

- (void) checkIfTheCurrentEventIsFollowedByUser
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *valueArray = [userDefault objectForKey:self.incommingUserId];
    
    self.isMyEvent = NO;
    for(NSMutableDictionary *dictionary in valueArray)
    {
        if([dictionary[CONSTANT_EVENT_ID] isEqualToString:self.incommingEventDictionary[CONSTANT_EVENT_ID]])
            self.isMyEvent = YES;
    }
}

#pragma mark - UITableView
#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rowsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *imageCellIdentifier = @"ImageViewTableViewCellIdentifier";
    NSString *normalCellIdentifier = @"UITableViewCellIdentifier";
    NSString *switchCellIdentifier = @"SwitchTableViewCellIdentifier";
    
    ImageViewTableViewCell *imageViewCell = [tableView dequeueReusableCellWithIdentifier:imageCellIdentifier];
    
    if(imageViewCell == nil)
        imageViewCell = [[ImageViewTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                      reuseIdentifier:imageCellIdentifier];
    [imageViewCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    SwitchTableViewCell *switchCell = [tableView dequeueReusableCellWithIdentifier:switchCellIdentifier];
    
    if(switchCell == nil)
        switchCell = [[SwitchTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                reuseIdentifier:switchCellIdentifier];
    [switchCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [switchCell.cellTextLabel setTextColor:[UIColor darkGrayColor]];
    [switchCell.cellTextLabel setFont:[UIFont systemFontOfSize:15]];

    UITableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:normalCellIdentifier];
    
    if(normalCell == nil)
        normalCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                            reuseIdentifier:normalCellIdentifier];
    [normalCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [normalCell.textLabel setTextColor:[UIColor darkGrayColor]];
    [normalCell.textLabel setFont:[UIFont systemFontOfSize:15]];
    [normalCell.detailTextLabel setTextColor:[UIColor blackColor]];
    [normalCell.detailTextLabel setFont:[UIFont boldSystemFontOfSize:17]];
    
    NSNumber *itemNumber = self.rowsArray[indexPath.row];
    
    switch (itemNumber.intValue)
    {
        case kImageViewItem:
        {
            [imageViewCell.eventImageView setImage:[UIImage imageNamed:self.incommingEventDictionary[CONSTANT_EVENT_IMAGE_NAME]]];
            
            return imageViewCell;
        }
            break;
            
        case kEventNameItem:
        {
            [normalCell.textLabel setText:NSLocalizedString(@"Name", @"")];
            [normalCell.detailTextLabel setText:self.incommingEventDictionary[CONSTANT_EVENT_NAME]];
        }
            break;
            
        case kEventPlaceItem:
        {
            [normalCell.textLabel setText:NSLocalizedString(@"Place", @"")];
            [normalCell.detailTextLabel setText:self.incommingEventDictionary[CONSTANT_EVENT_PLACE]];
        }
            break;
            
        case kEventPriceItem:
        {
            [normalCell.textLabel setText:NSLocalizedString(@"Price", @"")];
            NSNumber *price = self.incommingEventDictionary[CONSTANT_EVENT_PRICE];
            
            if(price.intValue == 0)
                [normalCell.detailTextLabel setText:NSLocalizedString(@"Free", @"")];
            else
                [normalCell.detailTextLabel setText:[NSString stringWithFormat:@"Rs: %@", price]];
        }
            break;
            
        case kEventMyEvent:
        {
            [switchCell.cellTextLabel setText:NSLocalizedString(@"Follow", @"")];
            [switchCell.switchButton addTarget:self
                                        action:@selector(switchButtonPressed:)
                              forControlEvents:UIControlEventValueChanged];
            if(self.isMyEvent)
                [switchCell.switchButton setOn:YES animated:YES];
            else
                [switchCell.switchButton setOn:NO animated:YES];
            
            return switchCell;
        }
            break;
            
        default:
            break;
    }
    
    return normalCell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *itemNumber = self.rowsArray[indexPath.row];
    if(itemNumber.intValue == kImageViewItem)
        return 250;
    else
        return 44;
}

#pragma mark - UITableViewDelegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
