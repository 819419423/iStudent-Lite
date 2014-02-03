//
//  SemesterViewController.m
//  iStudent
//
//  Created by JingD on 1/24/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "SemesterViewController.h"
#import "SemesterCell.h"
#import "SemesterNoCell.h"
#import "SemesterDetailsViewController.h"
#import "Semester.h"

@interface SemesterViewController () {
    
    NSDateFormatter *df;
}

@end

@implementation SemesterViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(detailsVCDismissed)
                                                 name: @"SemesterDetailsVCDismissed"
                                               object: nil];
    
    df = [[NSDateFormatter alloc] init];
    [df setDateFormat: @"MMM dd yyyy"];
    
    self.view.layer.shadowRadius = 6.0f;
    self.view.layer.shadowOpacity = 0.6f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    [self.semesterTableView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"semester_bg"]]];
    
//    Semester *semester = [NSEntityDescription insertNewObjectForEntityForName: @"Semester" inManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
//    semester.name = @"Fall Semester";
//    [[AppDelegate sharedDelegate].managedObjectContext save: nil];
    
    self.semesterFRC = [[iStudent sharedInstance] getFRCWithEntityName: @"Semester" withKey: @"_pk"];
    
    [self.semesterFRC performFetch: nil];
}

#pragma private methods

- (void)detailsVCDismissed {
    
    [self.semesterFRC performFetch: nil];
    [self.semesterTableView reloadData];
}

#pragma mark UITableView data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.semesterFRC.fetchedObjects.count == 0 ? 1 : self.semesterFRC.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.semesterFRC.fetchedObjects.count == 0) {
        
        static NSString *CellIdentifier = @"SemesterNoCell";
        SemesterNoCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[SemesterNoCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        }
        
        cell.bgImageView.layer.masksToBounds = YES;
        cell.bgImageView.layer.cornerRadius = 5.0f;
        
        return cell;
        
    } else {
        
        static NSString *CellIdentifier = @"SemesterCell";
        SemesterCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[SemesterCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
        }
        
        Semester *semester = [self.semesterFRC.fetchedObjects objectAtIndex: indexPath.row];
        cell.nameLabel.text = [NSString stringWithFormat: @"%@ %@", semester.name, semester.year];
        cell.timeLabel.text = [NSString stringWithFormat: @"%@ - %@", [df stringFromDate: semester.startDate], [df stringFromDate: semester.endDate]];
        
        cell.bgImageView.layer.masksToBounds = YES;
        cell.bgImageView.layer.cornerRadius = 5.0f;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120.0f;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"ExistingSemeterToDetails"]) {
        
        UIButton *button = (id)sender;
        SemesterCell *cell = (SemesterCell *)button.superview.superview.superview;
        NSIndexPath *indexPath = [self.semesterTableView indexPathForCell: cell];
        Semester *selectedSemester = [self.semesterFRC.fetchedObjects objectAtIndex: indexPath.row];
        
        SemesterDetailsViewController *detailsVC = (SemesterDetailsViewController *)segue.destinationViewController;
        
        detailsVC.semester = selectedSemester;
        
    } else if ([segue.identifier isEqualToString: @"NewSemesterToDetails"]) {
        
        //SemesterDetailsViewController *detailsVC = (SemesterDetailsViewController *)segue.destinationViewController;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
