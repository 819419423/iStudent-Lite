//
//  SemesterDetailsViewController.h
//  iStudent
//
//  Created by JingD on 1/27/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Semester.h"
#import "DJKeyboard.h"

@interface SemesterDetailsViewController : UIViewController <DJKeyboardDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView          *bgImageView;
@property (strong, nonatomic) IBOutlet UIImageView          *clipImageView;
@property (strong, nonatomic) IBOutlet UIScrollView         *scrollView;
@property (strong, nonatomic) IBOutlet UITextField          *name;
@property (strong, nonatomic) IBOutlet UITextField          *year;
@property (strong, nonatomic) IBOutlet UITextField          *startDate;
@property (strong, nonatomic) IBOutlet UITextField          *endDate;
@property (strong, nonatomic) Semester                      *semester;
@property (strong, nonatomic) UIPickerView                  *namePickerView;
@property (strong, nonatomic) UIPickerView                  *yearPickerView;
@property (strong, nonatomic) UIDatePicker                  *startDatePicker;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
