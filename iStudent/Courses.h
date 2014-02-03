//
//  Courses.h
//  iStudent
//
//  Created by JingD on 1/31/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Semester;

@interface Courses : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSDate *start;
@property (nonatomic, retain) NSDate *end;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * room;
@property (nonatomic, retain) NSNumber *monday;
@property (nonatomic, retain) NSNumber *tuesday;
@property (nonatomic, retain) NSNumber *wednesday;
@property (nonatomic, retain) NSNumber *thursday;
@property (nonatomic, retain) NSNumber *friday;
@property (nonatomic, retain) Semester *semester;

@end
