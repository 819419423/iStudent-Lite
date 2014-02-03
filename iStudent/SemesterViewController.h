//
//  SemesterViewController.h
//  iStudent
//
//  Created by JingD on 1/24/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemesterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView       *semesterTableView;
@property (strong, nonatomic) NSFetchedResultsController *semesterFRC;

@end
