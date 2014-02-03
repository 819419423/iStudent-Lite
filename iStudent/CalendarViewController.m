//
//  CalendarViewController.m
//  iStudent
//
//  Created by JingD on 1/24/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarCell.h"
#import "NSDate+Reporting.h"

@interface CalendarViewController () {
    
    NSArray *_daysArray;
    NSDateFormatter *df;
    NSDateFormatter *df1;
    int currentYear;
    int currentMonth;
}

@end

@implementation CalendarViewController

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
    
    [self.calendarView setBackgroundColor: [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.png"]]];
    
    self.calendarFRC = [[iStudent sharedInstance] getFRCWithEntityName: @"Calendar" withKey: @"date"];
    
    [self setupCurrentMonthAndCurrentYear];
    
    [self setupFRCWithinCurrentMonth];
    
    [self setupCurrentCalendar];

    [self.calendarTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CalendarCell";
    CalendarCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil) {
        cell = [[CalendarCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    NSArray *weekdaysArray = [_daysArray objectAtIndex: indexPath.row];
    
    
    [cell.sunButton setTitle: [[weekdaysArray objectAtIndex: 0] objectForKey: @"dateLabel"] forState: UIControlStateNormal];
    [cell.monButton setTitle: [[weekdaysArray objectAtIndex: 1] objectForKey: @"dateLabel"] forState: UIControlStateNormal];
    [cell.tueButton setTitle: [[weekdaysArray objectAtIndex: 2] objectForKey: @"dateLabel"] forState: UIControlStateNormal];
    [cell.wedButton setTitle: [[weekdaysArray objectAtIndex: 3] objectForKey: @"dateLabel"] forState: UIControlStateNormal];
    [cell.thuButton setTitle: [[weekdaysArray objectAtIndex: 4] objectForKey: @"dateLabel"] forState: UIControlStateNormal];
    [cell.friButton setTitle: [[weekdaysArray objectAtIndex: 5] objectForKey: @"dateLabel"] forState: UIControlStateNormal];
    [cell.satButton setTitle: [[weekdaysArray objectAtIndex: 6] objectForKey: @"dateLabel"] forState: UIControlStateNormal];
    
    cell.sunButton.alpha = [[[weekdaysArray objectAtIndex: 0] objectForKey: @"hidden"] boolValue] ? 0.4 : 1;
    cell.monButton.alpha = [[[weekdaysArray objectAtIndex: 1] objectForKey: @"hidden"] boolValue] ? 0.4 : 1;
    cell.tueButton.alpha = [[[weekdaysArray objectAtIndex: 2] objectForKey: @"hidden"] boolValue] ? 0.4 : 1;
    cell.wedButton.alpha = [[[weekdaysArray objectAtIndex: 3] objectForKey: @"hidden"] boolValue] ? 0.4 : 1;
    cell.thuButton.alpha = [[[weekdaysArray objectAtIndex: 4] objectForKey: @"hidden"] boolValue] ? 0.4 : 1;
    cell.friButton.alpha = [[[weekdaysArray objectAtIndex: 5] objectForKey: @"hidden"] boolValue] ? 0.4 : 1;
    cell.satButton.alpha = [[[weekdaysArray objectAtIndex: 6] objectForKey: @"hidden"] boolValue] ? 0.4 : 1;
    
//    if (indexPath.row == 1) {
//        [cell.tueButton setBackgroundImage: [UIImage imageNamed: @"free"] forState: UIControlStateNormal];
//        [cell.monButton setBackgroundImage: [UIImage imageNamed: @"busy"] forState: UIControlStateNormal];
//    }
//    
//    if (indexPath.row == 2) {
//        [cell.thuButton setBackgroundImage: [UIImage imageNamed: @"busy"] forState: UIControlStateNormal];
//        [cell.friButton setBackgroundImage: [UIImage imageNamed: @"free"] forState: UIControlStateNormal];
//    }
//    
//    if (indexPath.row == 3) {
//        [cell.satButton setBackgroundImage: [UIImage imageNamed: @"today"] forState: UIControlStateNormal];
//    }
//    
//    if (indexPath.row == 4) {
//        cell.satButton.alpha = 0.4;
//    }
    
    return cell;
}

- (IBAction)nextMonth:(id)sender {
    
    if (currentMonth == 12) {
        currentYear++;
        currentMonth = 1;
        
    } else {
        currentMonth++;
    }
    
    [self.monthLabel setText: [self getMonthNameWithMonthNumber: currentMonth]];
    [self.yearLabel setText: [NSString stringWithFormat: @"%d", currentYear]];
    
    [self setupCurrentCalendar];
    
    [self.calendarTableView reloadData];
}

- (IBAction)preMonth:(id)sender {
    
    if (currentMonth == 1) {
        currentYear--;
        currentMonth = 12;
        
    } else {
        currentMonth--;
    }
    
    [self.monthLabel setText: [self getMonthNameWithMonthNumber: currentMonth]];
    [self.yearLabel setText: [NSString stringWithFormat: @"%d", currentYear]];
    
    [self setupCurrentCalendar];
    
    [self.calendarTableView reloadData];
}

- (IBAction)fakeNextMonth:(id)sender {
    [self nextMonth: nil];
}

- (IBAction)fakePreMonth:(id)sender {
    [self preMonth: nil];
}

- (void)setupFRCWithinCurrentMonth {
    
    // get all calendar data within current month
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"date >= %@ AND date <= %@", [self getFirstDayWithMonthNumber: currentMonth withYearNumber: currentYear], [self getLastDayWithMonthNumber: currentMonth withYearNumber: currentYear]];
    [self.calendarFRC.fetchRequest setPredicate: predicate];
    [self.calendarFRC performFetch: nil];
}

#pragma private methods

- (void)setupCurrentMonthAndCurrentYear {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: (NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate: [NSDate date]];
    
    currentMonth = components.month;
    currentYear = components.year;
    
    [self.monthLabel setText: [self getMonthNameWithMonthNumber: currentMonth]];
    [self.yearLabel setText: [NSString stringWithFormat: @"%d", currentYear]];
}

- (void)setupCurrentCalendar {
    
    NSMutableArray *daysArray = [[NSMutableArray alloc] initWithCapacity: 6];
    NSDate *currentDate = [self getFirstDateOfCurrentCalendar];
    
    for (int i = 0; i < 6; i++) {
        
        NSMutableArray *weekdaysArray = [[NSMutableArray alloc] initWithCapacity: 7];
        for (int j = 0; j < 7; j++) {
            
            NSMutableDictionary *dayDict = [[NSMutableDictionary alloc] init];
            
            NSString *dateNumberString = [NSString stringWithFormat: @"%d", [self getDateNumberWithDate: currentDate]];
            [dayDict setObject: dateNumberString forKey: @"dateLabel"];
            [dayDict setObject: currentDate forKey: @"date"];
            
            if ([currentDate compare: [self getFirstDayWithMonthNumber: currentMonth withYearNumber: currentYear]] == NSOrderedAscending) {
                [dayDict setObject: [NSNumber numberWithBool: YES] forKey: @"hidden"];
            } else if ([currentDate compare: [self getLastDayWithMonthNumber: currentMonth withYearNumber: currentYear]] == NSOrderedDescending) {
                [dayDict setObject: [NSNumber numberWithBool: YES] forKey: @"hidden"];
            } else {
                [dayDict setObject: [NSNumber numberWithBool: NO] forKey: @"hidden"];
            }
            
            [weekdaysArray addObject: dayDict];
            
            currentDate = [NSDate oneDayAfter: currentDate];
        }
        
        [daysArray addObject: weekdaysArray];
    }
    
    _daysArray = [[NSArray alloc] initWithArray: daysArray];
}

- (int)getWeekdayWithDate: (NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: NSWeekdayCalendarUnit fromDate: date];
    
    return [components weekday];
}

- (int)getDateNumberWithDate: (NSDate *)date {
    
    if (df == nil) {
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"dd"];
    }
    
    return [[df stringFromDate: date] intValue];
}

- (NSDate *)getFirstDateOfCurrentCalendar {
    
    NSDate *firstDateOfCurrentMonth = [self getFirstDayWithMonthNumber: currentMonth withYearNumber: currentYear];
    int weekdayOfFirstDate = [self getWeekdayWithDate: firstDateOfCurrentMonth];
    
    NSDate *firstDateOfCurrentCalendar = firstDateOfCurrentMonth;
    
    for (int i = weekdayOfFirstDate-1; i >= 1; i--) {
        
        firstDateOfCurrentCalendar = [NSDate oneDayBefore: firstDateOfCurrentCalendar];
    }
    
    return firstDateOfCurrentCalendar;
}

- (NSDate *)getFirstDayWithMonthNumber: (int)month withYearNumber: (int)year {
    
    if (df1 == nil) {
        df1 = [[NSDateFormatter alloc] init];
        [df1 setDateFormat: @"yyyy-MM-dd"];
    }
    
    NSString *dateString = [NSString stringWithFormat: @"%d-%d-01", year, month];
    
    return [df1 dateFromString: dateString];
}

- (NSDate *)getLastDayWithMonthNumber: (int)month withYearNumber: (int)year {
    
    return [NSDate lastDayWithMonth: [self getFirstDayWithMonthNumber: month withYearNumber: year]];
}

- (NSString *)getMonthNameWithMonthNumber: (int)month {
    
    NSString *monthName = (month == 1) ? @"January" :
                          (month == 2) ? @"Feburary" :
                          (month == 3) ? @"March" :
                          (month == 4) ? @"April" :
                          (month == 5) ? @"May" :
                          (month == 6) ? @"June" :
                          (month == 7) ? @"July" :
                          (month == 8) ? @"August" :
                          (month == 9) ? @"September" :
                         (month == 10) ? @"October" :
                         (month == 11) ? @"November" : @"December";
    
    return monthName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
