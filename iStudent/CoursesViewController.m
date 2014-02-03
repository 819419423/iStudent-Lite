//
//  CoursesViewController.m
//  iStudent
//
//  Created by JingD on 1/28/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "CoursesViewController.h"
#import "CoursesCell.h"

@interface CoursesViewController ()

@end

@implementation CoursesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.layer.shadowRadius = 6.0f;
    self.view.layer.shadowOpacity = 0.6f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [self.coursesTableView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"semester_bg"]]];
    
    //self.courseFRC = [iStudent sharedInstance] getFRCWithEntityName:  withKey1:<#(NSString *)#> withKey2:<#(NSString *)#>
}

#pragma mark UITableView data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CoursesCell";
    CoursesCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[CoursesCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    cell.bgImageView.layer.masksToBounds = YES;
    cell.bgImageView.layer.cornerRadius = 5.0f;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 190.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
