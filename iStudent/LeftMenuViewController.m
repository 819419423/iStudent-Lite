//
//  LeftMenuViewController.m
//  iStudent
//
//  Created by Kobe Dai on 9/4/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

@synthesize clssMenuArray;
@synthesize lifeMenuArray;
@synthesize billMenuArray;
@synthesize classImageNamesArray;
@synthesize lifeImageNamesArray;
@synthesize billImageNamesArray;

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
    
    classMenuArray = [[NSMutableArray alloc] initWithObjects: @"Semester", @"Courses", @"Schedule", @"Homework", @"Grade", nil];
    classImageNamesArray = [[NSMutableArray alloc] initWithObjects: @"terms", @"course", @"schedule", @"homework", @"grade", nil];
    lifeMenuArray = [[NSMutableArray alloc] initWithObjects: @"Calendar", @"Journal", @"To Do List", @"Travel", @"Weather", @"Shopping", nil];
    lifeImageNamesArray = [[NSMutableArray alloc] initWithObjects: @"life_calendar", @"journal", @"to_do_list", @"travel", @"weather", @"shopping", nil];
    billMenuArray = [[NSMutableArray alloc] initWithObjects: @"Bills", @"Budget", @"Bill Reports", nil];
    billImageNamesArray = [[NSMutableArray alloc] initWithObjects: @"bills", @"budget", @"reports", nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [classMenuArray count];
    }
    else if (section == 1)
    {
        return [lifeMenuArray count];
    }
    else if (section == 2)
    {
        return [billMenuArray count];
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LeftMenuCell";
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil)
    {
        cell = [[LeftMenuCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    if (indexPath.section == 0)
    {
        cell.label.text = [classMenuArray objectAtIndex: indexPath.row];
        cell.imageView.image = [UIImage imageNamed: [classImageNamesArray objectAtIndex: indexPath.row]];
    }
    else if (indexPath.section == 1)
    {
        cell.label.text = [lifeMenuArray objectAtIndex: indexPath.row];
        cell.imageView.image = [UIImage imageNamed: [lifeImageNamesArray objectAtIndex: indexPath.row]];
    }
    else if (indexPath.section == 2)
    {
        cell.label.text = [billMenuArray objectAtIndex: indexPath.row];
        cell.imageView.image = [UIImage imageNamed: [billImageNamesArray objectAtIndex: indexPath.row]];
    }
    else
    {
        cell.label.text = @"Settings";
        cell.imageView.image = [UIImage imageNamed: @"settings"];
    }
    
    //[cell setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"background"]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"ChangeTopView" object: nil userInfo: [NSDictionary dictionaryWithObject: [classMenuArray objectAtIndex: indexPath.row] forKey: @"ViewController"]];
    }
    else if (indexPath.section == 1)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName: @"ChangeTopView" object: nil userInfo: [NSDictionary dictionaryWithObject: [lifeMenuArray objectAtIndex: indexPath.row] forKey: @"ViewController"]];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Class";
    }
    else if (section == 1)
    {
        return @"Life";
    }
    else if (section == 2)
    {
        return @"Bills";
    }
    else
    {
        return @"Configuration";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
