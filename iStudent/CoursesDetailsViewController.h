//
//  CoursesDetailsViewController.h
//  iStudent
//
//  Created by JingD on 1/29/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DJKeyboard.h"
#import "Courses.h"

@interface CoursesDetailsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, DJKeyboardDelegate>

@property (strong, nonatomic) Courses                   *course;

@property (strong, nonatomic) IBOutlet UITextField      *semester;
@property (strong, nonatomic) IBOutlet UITextField      *name;
@property (strong, nonatomic) IBOutlet UITextField      *ID;
@property (strong, nonatomic) IBOutlet UITextField      *begin;
@property (strong, nonatomic) IBOutlet UITextField      *end;
@property (strong, nonatomic) IBOutlet UITextField      *location;
@property (strong, nonatomic) IBOutlet UITextField      *room;
@property (strong, nonatomic) IBOutlet UITextField      *website;

@property (strong, nonatomic) IBOutlet UISwitch         *monSwitch;
@property (strong, nonatomic) IBOutlet UISwitch         *tueSwitch;
@property (strong, nonatomic) IBOutlet UISwitch         *wedSwitch;
@property (strong, nonatomic) IBOutlet UISwitch         *thuSwitch;
@property (strong, nonatomic) IBOutlet UISwitch         *friSwitch;

@property (strong, nonatomic) IBOutlet UIScrollView     *theScrollView;

@property (strong, nonatomic) UIPickerView              *semesterPickerView;
@property (strong, nonatomic) UIDatePicker              *startPicker;
@property (strong, nonatomic) UIDatePicker              *endPicker;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;


@end
