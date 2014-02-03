//
//  DJKeyboard.h
//  iStudent
//
//  Created by JingD on 1/28/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DJKeyboardDelegate <NSObject>
- (void)nextClickedWithTag: (int)currentTag;
- (void)previousClickedWithTag: (int)currentTag;
- (void)doneClicked;
@end

@interface DJKeyboard : NSObject

@property (nonatomic, strong) UIColor              *navBarColor;
@property (nonatomic, strong) UIColor              *fontColor;
@property (weak, nonatomic) id<DJKeyboardDelegate> delegate;
@property (nonatomic) int                          currentTag;

- (UIToolbar *)getToolbarWithPrevEnabled: (BOOL)prev NextEnabled: (BOOL)next;

@end
