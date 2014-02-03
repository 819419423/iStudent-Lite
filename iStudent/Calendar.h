//
//  Calendar.h
//  iStudent
//
//  Created by JingD on 1/28/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Calendar : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * dateLabel;
@property (nonatomic, retain) NSNumber * hidden;

@end
