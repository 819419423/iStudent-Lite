//
//  CalendarCell.h
//  iStudent
//
//  Created by JingD on 1/24/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton     *sunButton;
@property (strong, nonatomic) IBOutlet UIButton     *monButton;
@property (strong, nonatomic) IBOutlet UIButton     *tueButton;
@property (strong, nonatomic) IBOutlet UIButton     *wedButton;
@property (strong, nonatomic) IBOutlet UIButton     *thuButton;
@property (strong, nonatomic) IBOutlet UIButton     *friButton;
@property (strong, nonatomic) IBOutlet UIButton     *satButton;

@end
