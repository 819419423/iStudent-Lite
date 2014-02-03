//
//  LeftMenuViewController.h
//  iStudent
//
//  Created by Kobe Dai on 9/4/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray                  *classMenuArray;
    NSMutableArray                  *lifeMenuArray;
    NSMutableArray                  *billMenuArray;
    NSMutableArray                  *classImageNamesArray;
    NSMutableArray                  *lifeImageNamesArray;
    NSMutableArray                  *billImageNamesArray;
}

@property (strong, nonatomic) NSMutableArray                *clssMenuArray;
@property (strong, nonatomic) NSMutableArray                *lifeMenuArray;
@property (strong, nonatomic) NSMutableArray                *billMenuArray;
@property (strong, nonatomic) NSMutableArray                *classImageNamesArray;
@property (strong, nonatomic) NSMutableArray                *lifeImageNamesArray;
@property (strong, nonatomic) NSMutableArray                *billImageNamesArray;

@end
