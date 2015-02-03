//
//  EventListViewController.m
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 02/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import "EventListViewController.h"
#import "Constants.h"
#import "EventListCollectionViewCell.h"
#import "EventListTableViewCell.h"
#import "EventDetailsViewController.h"
#import "EventDataStructure.h"
#import "MyEventsListViewController.h"

@interface EventListViewController ()

@property (nonatomic, strong) NSMutableArray *eventListArray;
@property (nonatomic) BOOL isInListView;
@property (nonatomic, strong) UIBarButtonItem *toggleBarButtonItem;

@end

@implementation EventListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isInListView = true;
    
    self.toggleBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:GRID_TOGGLE_BUTTON_IMAGE]
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(toggleButtonPressed:)];
    [self.navigationItem setRightBarButtonItem:self.toggleBarButtonItem
                                      animated:YES];
    
    // Getting the Value for all the Events
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.eventListArray = [userDefaults objectForKey:@"All Events"];
    
    [self.navigationItem setTitle:[NSString stringWithFormat:NSLocalizedString(@"Event List (%d)", @""), self.eventListArray.count]];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    UINib *nib = [UINib nibWithNibName:@"EventListTableViewCell"
                                bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"EventListTableViewCellIdentifier"];
    
    nib = [UINib nibWithNibName:@"EventListCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:@"EventListCollectionViewCellIdentifier"];

    UISwipeGestureRecognizer *swipeleft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(screenSwipeLeft)];
    swipeleft.numberOfTouchesRequired=1;
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
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
    [myEventListScreen setUserId:self.incommingUserID];
    
    [self.navigationController pushViewController:myEventListScreen
                                         animated:YES];
}

#pragma mark - IBAction Methods

- (void) toggleButtonPressed:(UIBarButtonItem *)sender
{
    if(self.isInListView)
    {
        self.isInListView = false;
        [self.toggleBarButtonItem setImage:[UIImage imageNamed:LIST_TOGGLE_BUTTON_IMAGE]];
        
        [self.collectionView setHidden:NO];
        [self.collectionView setDelegate:self];
        [self.collectionView setDataSource:self];
        [self.collectionView reloadData];
        
        [self.tableView setHidden:YES];
        [self.tableView setDelegate:nil];
        [self.tableView setDataSource:nil];
    }
    else
    {
        self.isInListView = true;
        [self.toggleBarButtonItem setImage:[UIImage imageNamed:GRID_TOGGLE_BUTTON_IMAGE]];

        [self.collectionView setHidden:YES];
        [self.collectionView setDelegate:nil];
        [self.collectionView setDataSource:nil];
        
        [self.tableView setHidden:NO];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView reloadData];
    }
}

#pragma mark - EventSelection Delegate Methods

- (void)eventSelected:(NSMutableDictionary *)selectedEventDictionary
{
    [self goToDetailsScreenWithItem:selectedEventDictionary];
}

#pragma mark - Private Methods

- (void) goToDetailsScreenWithItem:(NSMutableDictionary *)valueDictionary
{
    // Moving to the List screen
    UIStoryboard *mainStroryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EventDetailsViewController *eventDetailsViewController = [mainStroryBoard instantiateViewControllerWithIdentifier:@"EventDetailsViewControllerIdentifier"];
    [eventDetailsViewController setIncommingEventDictionary:valueDictionary];
    [eventDetailsViewController setIncommingUserId:self.incommingUserID];
    
    [self.navigationController pushViewController:eventDetailsViewController
                                         animated:YES];
}

#pragma mark - UITableView
#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"EventListTableViewCellIdentifier";
    
    EventListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
        cell = [[EventListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                             reuseIdentifier:cellIdentifier];
    
    NSMutableDictionary *dictionary = self.eventListArray[indexPath.row];
    
    [cell.eventImageView setImage:[UIImage imageNamed:dictionary[CONSTANT_EVENT_IMAGE_NAME]]];
    [cell.eventNameLabel setText:dictionary[CONSTANT_EVENT_NAME]];
    [cell.eventPlaceLabel setText:dictionary[CONSTANT_EVENT_PLACE]];
    NSNumber *price = dictionary[CONSTANT_EVENT_PRICE];
    if(price.doubleValue == 0.0)
        [cell.priceLabel setText:NSLocalizedString(@"Free Entry", @"")];
    else
        [cell.priceLabel setText:NSLocalizedString(@"Paid", @"")];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - UITableViewDelegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row >= self.eventListArray.count)
        return;
    
    NSMutableDictionary *valueDictionary = self.eventListArray[indexPath.row];
    
    [self goToDetailsScreenWithItem:valueDictionary];
}

#pragma mark - UICollectionView
#pragma mark UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.eventListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"EventListCollectionViewCellIdentifier";
    
    EventListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                           forIndexPath:indexPath];
    [cell designUIComponent];
    
    NSMutableDictionary *dictionary = self.eventListArray[indexPath.row];
    
    [cell.eventImageView setImage:[UIImage imageNamed:dictionary[CONSTANT_EVENT_IMAGE_NAME]]];
    [cell.eventNameLabel setText:dictionary[CONSTANT_EVENT_NAME]];
    [cell.eventPlaceLabel setText:dictionary[CONSTANT_EVENT_PLACE]];
    NSNumber *price = dictionary[CONSTANT_EVENT_PRICE];
    if(price.doubleValue == 0.0)
        [cell.priceLabel setText:NSLocalizedString(@"Free Entry", @"")];
    else
        [cell.priceLabel setText:NSLocalizedString(@"Paid", @"")];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int itemsPerRow = 2;
    UIInterfaceOrientation orientation =  [UIApplication sharedApplication].statusBarOrientation;
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        itemsPerRow = 3;
    }
    
    CGFloat width = floor((self.collectionView.frame.size.width - ((itemsPerRow + 1)* IPAD_INSET))/itemsPerRow);
    
    return CGSizeMake(width, 250);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row >= self.eventListArray.count)
        return;
    
    NSMutableDictionary *valueDictionary = self.eventListArray[indexPath.row];
    [self goToDetailsScreenWithItem:valueDictionary];
}

#pragma mark - Collection view flow layout delegate implementation

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat inset;
    inset = IPAD_INSET;
    
    return UIEdgeInsetsMake(inset, inset, inset, inset);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return IPAD_INSET;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return IPAD_INSET;
}

#pragma mark - Screen Rotation Methods

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self.collectionView performBatchUpdates:nil completion:nil];
    [self.collectionView reloadData];
}

@end
