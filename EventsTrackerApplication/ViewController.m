//
//  ViewController.m
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 02/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import "ViewController.h"
#import "EventListViewController.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    [self populateDataBase];
    
    [self.navigationItem setTitle:NSLocalizedString(@"Event Tracker Application", @"Navigation Title")];
    
    [self.loginButton setTitle:NSLocalizedString(@"Login", @"button Title")
                      forState:UIControlStateNormal];
    
    [self.loginIDLabel setText:NSLocalizedString(@"Login ID", @"Login label Title")];
    
    [self.loginTextField setPlaceholder:NSLocalizedString(@"Login ID", @"")];
    
    [self.loginTextField setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Populating Database with Some values

- (void) populateDataBase
{
    NSMutableArray *eventArray = [NSMutableArray array];
    
    NSMutableDictionary *eventDictionary = nil;
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"1" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Metallica Concert", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"Palace Grounds", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(100) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"no_image_available.png" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"2" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Saree Exhibition", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"Malleswaram Grounds", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(0) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"sareeExibition.png" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"3" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Wine tasting event", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"Links Brewery", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(150) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"wineTastingImage.png" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"4" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Startups Meet", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"Kanteerava Indoor Stadium", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(200) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"no_image_available.png" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"5" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Summer Noon Party", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"Kumara Park", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(300) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"summerWorkShop.png" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"6" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Rock and Roll nights", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"Sarjapur Road", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(175) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"RockAndRoll.png" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"7" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Barbecue Fridays", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"White Field", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(550) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"BarbequeFriday.jpg" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"8" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Summer workshop", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"Indiranagar", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(0) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"no_image_available.png" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"9" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Impressions & Expressions", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"MG Road", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(0) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"no_image_available.png" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    eventDictionary = nil;
    eventDictionary = [[NSMutableDictionary alloc] init];
    [eventDictionary setObject:@"10" forKey:CONSTANT_EVENT_ID];
    [eventDictionary setObject:NSLocalizedString(@"Italian carnival", @"Event Name") forKey:CONSTANT_EVENT_NAME];
    [eventDictionary setObject:NSLocalizedString(@"Electronic City", @"Event Place Name") forKey:CONSTANT_EVENT_PLACE];
    [eventDictionary setObject:@(0) forKey:CONSTANT_EVENT_PRICE];
    [eventDictionary setObject:@"no_image_available.png" forKey:CONSTANT_EVENT_IMAGE_NAME];
    [eventArray addObject:eventDictionary];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:eventArray forKey:@"All Events"];
    [userDefaults synchronize];
}

#pragma mark - IBAction Methods

- (IBAction)loginButtonPressed:(UIButton *)sender
{
    if([self performValidation])
    {
        [self.view endEditing:YES];
        
        // Getting the Data for the user.
        NSString *loginID = self.loginTextField.text;
        loginID = [loginID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSMutableArray *valueArray = (NSMutableArray *)[userDefaults objectForKey:loginID];

        if(valueArray == nil)
        {
            valueArray = [NSMutableArray array];
            
            [userDefaults setObject:valueArray
                             forKey:loginID];
            
            [userDefaults synchronize];
        }
    
        // Moving to the List screen
        UIStoryboard *mainStroryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        EventListViewController *eventListViewController = [mainStroryBoard instantiateViewControllerWithIdentifier:@"EventListViewControllerIdentifier"];
        
        [eventListViewController setIncommingUserID:loginID];
        [eventListViewController setIncommingUserEventsArray:valueArray];
        
        [self.navigationController pushViewController:eventListViewController
                                             animated:YES];
    }
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self loginButtonPressed:nil];
    
    return YES;
}

#pragma mark - Private Methods

- (BOOL) performValidation
{
    NSString *alertString = nil;
    NSString *loginID = self.loginTextField.text;
    loginID = [loginID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(loginID.length == 0)
        alertString = NSLocalizedString(@"Please enter some valid login ID", @"");
    
    if(alertString.length > 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", @"")
                                                        message:alertString
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                              otherButtonTitles:nil];
        [alert show];
        
        return NO;
    }
    
    return YES;
}

@end
