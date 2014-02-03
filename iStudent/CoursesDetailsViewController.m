//
//  CoursesDetailsViewController.m
//  iStudent
//
//  Created by JingD on 1/29/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "CoursesDetailsViewController.h"
#import "Semester.h"

@interface CoursesDetailsViewController () {
    
    NSFetchedResultsController *semesterFRC;
    DJKeyboard *keyboard;
    NSDateFormatter *df;
}

@end

@implementation CoursesDetailsViewController

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
    
    semesterFRC = [[iStudent sharedInstance] getFRCWithEntityName: @"Semester" withKey: @"_pk"];
    
    [self setupFields];
    [self setupKeyboardToolbar];
    [self setupPickers];
    
    self.semester.tag = 1;
    self.name.tag = 2;
    self.ID.tag = 3;
    self.begin.tag = 4;
    self.end.tag = 5;
    self.location.tag = 6;
    self.room.tag = 7;
    self.website.tag = 8;
}

#pragma mark UIPickerView data source methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return semesterFRC.fetchedObjects.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    Semester *s = [semesterFRC.fetchedObjects objectAtIndex: row];
    
    return [NSString stringWithFormat: @"%@, %@", s.name, s.year];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    Semester *s = [semesterFRC.fetchedObjects objectAtIndex: row];
    self.semester.text = [NSString stringWithFormat: @"%@, %@", s.name, s.year];
}

#pragma mark UITextField delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    BOOL preEnabled = textField.tag == 1 ? NO : YES;
    BOOL nextEnabled = textField.tag == 8 ? NO : YES;
    
    // semester
    if (textField.tag == 1) {
        [textField setInputView: self.semesterPickerView];
    // start time
    } else if (textField.tag == 4) {
        [textField setInputView: self.startPicker];
    // end time
    } else if (textField.tag == 5) {
        [textField setInputView: self.endPicker];
    }
    
    [textField setInputAccessoryView: [keyboard getToolbarWithPrevEnabled: preEnabled NextEnabled: nextEnabled]];
    keyboard.currentTag = textField.tag;
    
    [self.theScrollView setScrollEnabled: NO];
    
    [self.theScrollView setContentOffset: CGPointMake(0, textField.frame.origin.y-40)];
}

#pragma mark DJKeyboard delegate methods

- (void)nextClickedWithTag:(int)currentTag {
    
    if (currentTag == 1) {
        [self.name becomeFirstResponder];
    } else if (currentTag == 2) {
        [self.ID becomeFirstResponder];
    } else if (currentTag == 3) {
        [self.begin becomeFirstResponder];
    } else if (currentTag == 4) {
        [self.end becomeFirstResponder];
    } else if (currentTag == 5) {
        [self.location becomeFirstResponder];
    } else if (currentTag == 6) {
        [self.room becomeFirstResponder];
    } else if (currentTag == 7) {
        [self.website becomeFirstResponder];
    }
}

- (void)previousClickedWithTag:(int)currentTag {
    
    if (currentTag == 2) {
        [self.semester becomeFirstResponder];
    } else if (currentTag == 3) {
        [self.name becomeFirstResponder];
    } else if (currentTag == 4) {
        [self.ID becomeFirstResponder];
    } else if (currentTag == 5) {
        [self.begin becomeFirstResponder];
    } else if (currentTag == 6) {
        [self.end becomeFirstResponder];
    } else if (currentTag == 7) {
        [self.location becomeFirstResponder];
    } else if (currentTag == 8) {
        [self.room becomeFirstResponder];
    }
}

- (void)doneClicked {
    
    if (self.semester.isFirstResponder) {
        [self.semester resignFirstResponder];
    } else if (self.name.isFirstResponder) {
        [self.name resignFirstResponder];
    } else if (self.ID.isFirstResponder) {
        [self.ID resignFirstResponder];
    } else if (self.location.isFirstResponder) {
        [self.location resignFirstResponder];
    } else if (self.room.isFirstResponder) {
        [self.room resignFirstResponder];
    } else if (self.website.isFirstResponder) {
        [self.website resignFirstResponder];
    } else if (self.begin.isFirstResponder) {
        [self.begin resignFirstResponder];
    } else if (self.end.isFirstResponder) {
        [self.end resignFirstResponder];
    }
    
    [self.theScrollView setScrollEnabled: YES];
    [self.theScrollView setContentOffset: CGPointZero];
}

#pragma mark private methods

- (void)setupFields {
    
    if (self.course == nil) {
        self.semester.text = @"";
        self.name.text = @"";
        self.ID.text = @"";
        self.begin.text = @"";
        self.end.text = @"";
        self.location.text = @"";
        self.room.text = @"";
        self.website.text = @"";
        [self.monSwitch setOn: NO];
        [self.tueSwitch setOn: NO];
        [self.wedSwitch setOn: NO];
        [self.thuSwitch setOn: NO];
        [self.friSwitch setOn: NO];
        
    } else {
        self.semester.text = [NSString stringWithFormat: @"%@, %@", self.course.semester.name, self.course.semester.year];
        self.name.text = self.course.name;
        self.ID.text = self.course.id;
        if (df == nil) {
            df = [[NSDateFormatter alloc] init];
            [df setDateFormat: @"hh:mm a"];
        }
        self.begin.text = [df stringFromDate: self.course.start];
        self.end.text = [df stringFromDate: self.course.end];
        self.location.text = self.course.location;
        self.room.text = self.course.room;
        self.website.text = self.course.website;
        self.monSwitch.on = [self.course.monday boolValue] ? YES : NO;
        self.tueSwitch.on = [self.course.tuesday boolValue] ? YES : NO;
        self.wedSwitch.on = [self.course.wednesday boolValue] ? YES : NO;
        self.thuSwitch.on = [self.course.thursday boolValue] ? YES : NO;
        self.friSwitch.on = [self.course.friday boolValue] ? YES : NO;
    }
}

- (void)setupKeyboardToolbar {
    
    if (keyboard == nil) {
        keyboard = [[DJKeyboard alloc] init];
        keyboard.delegate = self;
    }
}

- (void)setupPickers {
    
    if (self.semesterPickerView == nil) {
        
        [semesterFRC performFetch: nil];
        self.semesterPickerView = [[UIPickerView alloc] init];
        self.semesterPickerView.delegate = self;
        self.semesterPickerView.dataSource = self;
        [self.semesterPickerView reloadAllComponents];
    }
    
    if (self.startPicker == nil) {
        
        if (df == nil) {
            df = [[NSDateFormatter alloc] init];
            [df setDateFormat: @"hh:mm a"];
        }
        
        self.startPicker = [[UIDatePicker alloc] init];
        [self.startPicker setDatePickerMode: UIDatePickerModeTime];
        [self.startPicker addTarget: self action: @selector(pickerValueChanged:) forControlEvents: UIControlEventValueChanged];
    }
    
    if (self.endPicker == nil) {
        
        if (df == nil) {
            df = [[NSDateFormatter alloc] init];
            [df setDateFormat: @"hh:mm a"];
        }
        
        self.endPicker = [[UIDatePicker alloc] init];
        [self.endPicker setDatePickerMode: UIDatePickerModeTime];
        [self.endPicker addTarget: self action: @selector(pickerValueChanged:) forControlEvents: UIControlEventValueChanged];
    }
}

- (void)pickerValueChanged: (UIDatePicker *)picker {
    
    if (picker == self.startPicker) {
        [self.begin setText: [df stringFromDate: picker.date]];
    } else {
        [self.end setText: [df stringFromDate: picker.date]];
    }
}

- (IBAction)save:(id)sender {
    
    NSString *body = @"";
    
    NSLog(@"%@", [self querySemesterWithNameAndYear: self.semester.text]);
    
    if ([self.semester.text isEqualToString: @""] || [self.name.text isEqualToString: @""] || [self.begin.text isEqualToString: @""] || [self.end.text isEqualToString: @""]) {
        
        body = [self.semester.text isEqualToString: @""] ? @"Semester is required" :
               [self.name.text isEqualToString: @""] ? @"Name is required" :
               [self.begin.text isEqualToString: @""] ? @"Begin time is required" : @"End time is required";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Save Failed"
                                                            message: body
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
        
    } else {
        
        // new one
        if (self.course == nil) {
            self.course = [NSEntityDescription insertNewObjectForEntityForName: @"Courses" inManagedObjectContext: [AppDelegate sharedDelegate].managedObjectContext];
            self.course.name = self.name.text;
            self.course.id = self.ID.text;
            self.course.start = [df dateFromString: self.begin.text];
            self.course.end = [df dateFromString: self.end.text];
            self.course.location = self.location.text;
            self.course.room = self.room.text;
            self.course.monday = self.monSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            self.course.tuesday = self.tueSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            self.course.wednesday = self.wedSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            self.course.thursday = self.thuSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            self.course.friday = self.friSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            
            Semester *s = [self querySemesterWithNameAndYear: self.semester.text];
            self.course.semester = s;
            [s addCoursesObject: self.course];
            
        } else  {
            self.course.name = self.name.text;
            self.course.id = self.ID.text;
            self.course.start = [df dateFromString: self.begin.text];
            self.course.end = [df dateFromString: self.end.text];
            self.course.location = self.location.text;
            self.course.room = self.room.text;
            self.course.monday = self.monSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            self.course.tuesday = self.tueSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            self.course.wednesday = self.wedSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            self.course.thursday = self.thuSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            self.course.friday = self.friSwitch.isOn ? [NSNumber numberWithBool: YES] : [NSNumber numberWithBool: NO];
            
            Semester *s = [self querySemesterWithNameAndYear: self.semester.text];
            self.course.semester = s;
            [s addCoursesObject: self.course];
            
        }
        
        NSError *error;
        [[AppDelegate sharedDelegate].managedObjectContext save: &error];
        
        if (!error) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Save Successful"
                                                                message: @"New course has been saved."
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

- (Semester *)querySemesterWithNameAndYear: (NSString *)nameYear {
    
    NSArray *nameAndYear = [nameYear componentsSeparatedByString: @", "];
    
    if (nameAndYear != nil && nameAndYear.count == 2) {
        NSFetchedResultsController *sFRC = [[iStudent sharedInstance] getFRCWithEntityName: @"Semester" withKey: @"_pk"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name == %@ AND year == %@", [nameAndYear objectAtIndex: 0], [nameAndYear objectAtIndex: 1]];
        sFRC.fetchRequest.predicate = predicate;
        
        [sFRC performFetch: nil];
        
        return [sFRC.fetchedObjects objectAtIndex: 0];
    }
    else {
        return nil;
    }
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated: YES completion: nil];
}

#pragma mark private methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
