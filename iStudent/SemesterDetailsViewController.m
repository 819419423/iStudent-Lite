//
//  SemesterDetailsViewController.m
//  iStudent
//
//  Created by JingD on 1/27/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "SemesterDetailsViewController.h"

@interface SemesterDetailsViewController () {
    
    NSDateFormatter *df;
    DJKeyboard      *keyboard;
    NSArray         *namePickerArray;
    NSArray         *yearPickerArray;
}

@end

@implementation SemesterDetailsViewController

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
    
    [self setupFields];
    [self setupKeyboardToolbar];
    [self setupPickers];
    
    if (self.semester == nil) {
        self.clipImageView.hidden = YES;
    } else {
        self.clipImageView.hidden = NO;
    }
}

#pragma mark UITextField delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    BOOL showPrev = textField.tag != 1;
    BOOL showNext = textField.tag != 4;
    
    if (textField.tag == 1) {
        textField.inputView = self.namePickerView;
        if ([textField.text isEqualToString: @""] || textField.text == nil) {
            textField.text = [namePickerArray objectAtIndex: 0];
        }
    } else if (textField.tag == 2) {
        textField.inputView = self.yearPickerView;
        if ([textField.text isEqualToString: @""] || textField.text == nil) {
            textField.text = [yearPickerArray objectAtIndex: 0];
        }
    } else {
        textField.inputView = self.startDatePicker;
        if ([textField.text isEqualToString: @""] || textField.text == nil) {
            if (df == nil) {
                df = [[NSDateFormatter alloc] init];
                [df setDateFormat: @"yyyy-MM-dd"];
            }
            textField.text = [df stringFromDate: [NSDate date]];
        }
    }
    
    [textField setInputAccessoryView: [keyboard getToolbarWithPrevEnabled: showPrev NextEnabled: showNext]];
    keyboard.currentTag = textField.tag;
    
    [self.scrollView setContentOffset: CGPointMake(0, textField.frame.origin.y-40) animated: YES];
}

#pragma mark private methods

- (void)setupFields {
    
    if (df == nil) {
        
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"MMM dd yyyy"];
    }
    
    if (self.semester != nil) {
        
        self.name.text = self.semester.name != nil ? self.semester.name : @"";
        self.year.text = self.semester.year != nil ? self.semester.year : @"";
        self.startDate.text = [df stringFromDate: self.semester.startDate] != nil ? [df stringFromDate: self.semester.startDate] : @"";
        self.endDate.text = [df stringFromDate: self.semester.endDate] != nil ? [df stringFromDate: self.semester.endDate] : @"";
        
    } else {
        
        self.name.text = @"";
        self.year.text = @"";
        self.startDate.text = @"";
        self.endDate.text = @"";
    }
    
    self.name.tag = 1;
    self.year.tag = 2;
    self.startDate.tag = 3;
    self.endDate.tag = 4;
}

- (void)setupKeyboardToolbar {
    
    if (keyboard == nil) {
        
        keyboard = [[DJKeyboard alloc] init];
        keyboard.delegate = self;
    }
}

- (void)setupPickers {
    
    // name
    namePickerArray = @[@"Spring Semester", @"Summer Semester", @"Fall Semester", @"Winter Semester"];
    self.namePickerView = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, 320, 216)];
    self.namePickerView.delegate = self;
    self.namePickerView.dataSource = self;
    self.namePickerView.tag = 1;
    
    // year
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 2010; i <= 2030; i++) {
        [tempArray addObject: [NSString stringWithFormat: @"%d", i]];
    }
    yearPickerArray = [[NSArray alloc] initWithArray: tempArray];
    self.yearPickerView = [[UIPickerView alloc] initWithFrame: CGRectMake(0, 0, 320, 216)];
    self.yearPickerView.delegate = self;
    self.yearPickerView.dataSource = self;
    self.yearPickerView.tag = 2;
    
    [self.namePickerView reloadAllComponents];
    [self.yearPickerView reloadAllComponents];
    
    // start date & end date
    self.startDatePicker = [[UIDatePicker alloc] init];
    [self.startDatePicker setDatePickerMode: UIDatePickerModeDate];
    [self.startDatePicker addTarget: self action: @selector(datePickerValueChanged:) forControlEvents: UIControlEventValueChanged];
}

#pragma mark UIPickerView data source methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return pickerView.tag == 1 ? namePickerArray.count : yearPickerArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return pickerView.tag == 1 ? [namePickerArray objectAtIndex: row] : [yearPickerArray objectAtIndex: row];
}

#pragma mark UIPickerView delegate methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView.tag == 1) {
        
        [self.name setText: [namePickerArray objectAtIndex: row]];
        
    } else {
        
        [self.year setText: [yearPickerArray objectAtIndex: row]];
    }
}

#pragma mark DJKeyboard delegate methods

- (void)nextClickedWithTag:(int)currentTag {
    
    switch (currentTag){
        case 1: {
            [self.year becomeFirstResponder];
        }
            break;
            
        case 2: {
            [self.startDate becomeFirstResponder];
        }
            break;
            
        case 3: {
            [self.endDate becomeFirstResponder];
        }
            break;
            
        default: {
        }
            break;
    }
}

- (void)previousClickedWithTag:(int)currentTag {
    
    switch (currentTag){
        case 2: {
            [self.name becomeFirstResponder];
        }
            break;
            
        case 3: {
            [self.year becomeFirstResponder];
        }
            break;
            
        case 4: {
            [self.startDate becomeFirstResponder];
        }
            break;
            
        default: {
        }
            break;
    }
}

- (void)doneClicked {
    
    if ([self.name isFirstResponder]) {
        [self.name resignFirstResponder];
    } else if ([self.year isFirstResponder]) {
        [self.year resignFirstResponder];
    } else if ([self.startDate isFirstResponder]) {
        [self.startDate resignFirstResponder];
    } else if ([self.endDate isFirstResponder]) {
        [self.endDate resignFirstResponder];
    }
    
    [self.scrollView setContentOffset: CGPointZero animated: YES];
}

- (void)datePickerValueChanged: (UIDatePicker *)picker {
    
    if (df == nil) {
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat: @"yyyy-MM-dd"];
    }
    
    if (self.startDate.isFirstResponder) {
        self.startDate.text = [df stringFromDate: picker.date];
    } else {
        self.endDate.text = [df stringFromDate: picker.date];
    }
}

- (IBAction)save:(id)sender {
    
    if ([self.name.text isEqualToString: @""] || [self.year.text isEqualToString: @""] || [self.startDate.text isEqualToString: @""] || [self.endDate.text isEqualToString: @""]) {
        
        NSString *body = [self.name.text isEqualToString: @""] ? @"Semester name is required." :
                         [self.year.text isEqualToString: @""] ? @"Semester year is required." :
                         [self.startDate.text isEqualToString: @""] ? @"Start date is required." : @"End date is required";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Save Failed"
                                                            message: body
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
        
    } else {
        
        // edit existing one
        if (self.semester != nil) {
            self.semester.name = self.name.text;
            self.semester.year = self.year.text;
            self.semester.startDate = [df dateFromString: self.startDate.text];
            self.semester.endDate = [df dateFromString: self.endDate.text];
        // add new one
        } else {
            Semester *newSemester = [NSEntityDescription insertNewObjectForEntityForName: @"Semester" inManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
            newSemester.name = self.name.text;
            newSemester.year = self.year.text;
            newSemester.startDate = [df dateFromString: self.startDate.text];
            newSemester.endDate = [df dateFromString: self.endDate.text];
        }
        
        NSError *error;
        [[AppDelegate sharedDelegate].managedObjectContext save: &error];
        
        if (!error) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Save Successful"
                                                                message: @"New semester has been saved."
                                                               delegate: self
                                                      cancelButtonTitle: @"OK"
                                                      otherButtonTitles: nil];
            [alertView show];
            
        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Save Failed"
                                                                message: @"There's some unknown errors."
                                                               delegate: nil
                                                      cancelButtonTitle: @"OK"
                                                      otherButtonTitles: nil];
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self dismissViewControllerAnimated: YES completion: ^(void) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName: @"SemesterDetailsVCDismissed" object: nil userInfo: nil];
        
    }];
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
