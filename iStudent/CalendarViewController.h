//
//  CalendarViewController.h
//  iStudent
//
//  Created by JingD on 1/24/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView       *calendarTableView;
@property (strong, nonatomic) IBOutlet UIView            *calendarView;
@property (strong, nonatomic) IBOutlet UILabel           *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel           *monthLabel;

@property (strong, nonatomic) NSFetchedResultsController *calendarFRC;

- (IBAction)nextMonth: (id)sender;
- (IBAction)preMonth: (id)sender;
- (IBAction)fakeNextMonth: (id)sender;
- (IBAction)fakePreMonth:(id)sender;

@end
