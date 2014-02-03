//
//  InitialViewController.h
//  iStudent
//
//  Created by Kobe Dai on 9/4/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import "ECSlidingViewController.h"
#import "LeftMenuViewController.h"
#import "SemesterViewController.h"
#import "CoursesViewController.h"
#import "CalendarViewController.h"

@interface InitialViewController : ECSlidingViewController
{
    LeftMenuViewController                          *lmvc;
}

@property (strong, nonatomic) LeftMenuViewController                    *lmvc;
@property (strong, nonatomic) SemesterViewController                    *svc;
@property (strong, nonatomic) CoursesViewController                     *csvc;
@property (strong, nonatomic) CalendarViewController                    *cvc;

@end
