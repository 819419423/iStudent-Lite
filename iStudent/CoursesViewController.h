//
//  CoursesViewController.h
//  iStudent
//
//  Created by JingD on 1/28/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoursesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView              *coursesTableView;
@property (strong, nonatomic) NSFetchedResultsController        *courseFRC;

@end
