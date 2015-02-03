//
//  MyEventsListViewController.m
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 03/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import "MyEventsListViewController.h"
#import "EventListTableViewCell.h"
#import "Constants.h"
#import "EventDetailsViewController.h"

@interface MyEventsListViewController ()

@property (nonatomic, strong) UIBarButtonItem *editbutton;
@property (nonatomic) BOOL isInEditionMode;

@end

@implementation MyEventsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self populateList];

    self.navigationItem.hidesBackButton = YES;
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    self.editbutton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", @"")
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                      action:@selector(editButtonPressed:)];
    self.isInEditionMode = NO;
    
    [self.navigationItem setRightBarButtonItem:self.editbutton
                                      animated:YES];

    UINib *nib = [UINib nibWithNibName:@"EventListTableViewCell"
                                bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"EventListTableViewCellIdentifier"];
    
    // Adding the Swipe Gesture
    UISwipeGestureRecognizer *swiperight = [[UISwipeGestureRecognizer alloc]initWithTarget:self
                                                                                    action:@selector(screenSwipeRight)];
    swiperight.numberOfTouchesRequired=1;
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void) updateNavigationTitle
{
    [self.navigationItem setTitle:[NSString stringWithFormat:NSLocalizedString(@"My Event List (%d)", @""), self.incommingEventsArray.count]];
}

- (void) populateList
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.incommingEventsArray = [userDefault objectForKey:self.userId];

    [self updateNavigationTitle];
    
    [self.tableView reloadData];
}

#pragma mark - Swipe gesture Methods

- (void) screenSwipeRight
{
    [self saveListOrder];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) editButtonPressed:(UIBarButtonItem *)sender
{
    if(self.isInEditionMode)
    {
        self.isInEditionMode = false;
        [self.editbutton setTitle:NSLocalizedString(@"Edit", @"")];
        
        [self.tableView setEditing:NO animated:YES];
    }
    else
    {
        self.isInEditionMode = true;
        [self.editbutton setTitle:NSLocalizedString(@"Done", @"")];
        
        [self.tableView setEditing:YES animated:YES];
    }
}

#pragma mark - Private Methods

- (void) saveListOrder
{
    // Saving the Order of the event
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.incommingEventsArray
                     forKey:self.userId];
}

#pragma mark - UITableView
#pragma mark - UITableViewDataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.incommingEventsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"EventListTableViewCellIdentifier";
    
    EventListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
        cell = [[EventListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                             reuseIdentifier:cellIdentifier];
    
    NSMutableDictionary *dictionary = self.incommingEventsArray[indexPath.row];
    
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

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.incommingEventsArray];

    [tempArray removeObjectAtIndex:indexPath.row];
    
    self.incommingEventsArray = tempArray;
    
    [self updateNavigationTitle];
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.incommingEventsArray];
    
    NSMutableDictionary *stringToMove = [tempArray objectAtIndex:sourceIndexPath.row];
    
    [tempArray removeObjectAtIndex:sourceIndexPath.row];
    [tempArray insertObject:stringToMove atIndex:destinationIndexPath.row];
    
    self.incommingEventsArray = tempArray;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark - UITableViewDelegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row >= self.incommingEventsArray.count)
        return;
    
    if(self.delegate)
    {
        if([self.delegate respondsToSelector:@selector(eventSelected:)])
        {
            // Moving to the previous screen
            [self saveListOrder];
            
            [self.navigationController popViewControllerAnimated:NO];
            
            NSMutableDictionary *valueDictionary = self.incommingEventsArray[indexPath.row];
            [self.delegate eventSelected:valueDictionary];
        }
    }
}

@end
