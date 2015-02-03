//
//  EventDataStructure.h
//  EventsTrackerApplication
//
//  Created by Sibam Kedia on 02/02/15.
//  Copyright (c) 2015 Sibam Kedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventDataStructure : NSObject

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventPlace;
@property (nonatomic, strong) NSNumber *eventPrice;
@property (nonatomic, strong) NSString *eventImageName;

@end
