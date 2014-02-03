//
//  SemesterCell.h
//  iStudent
//
//  Created by JingD on 1/26/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemesterCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView          *bgImageView;
@property (strong, nonatomic) IBOutlet UIButton             *editButton;
@property (strong, nonatomic) IBOutlet UILabel              *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel              *timeLabel;

@end
