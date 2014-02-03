//
//  Semester.h
//  iStudent
//
//  Created by JingD on 1/31/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Courses;

@interface Semester : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSSet *courses;
@end

@interface Semester (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Courses *)value;
- (void)removeCoursesObject:(Courses *)value;
- (void)addCourses:(NSSet *)values;
- (void)removeCourses:(NSSet *)values;

@end
