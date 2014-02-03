//
//  DJKeyboard.m
//  iStudent
//
//  Created by JingD on 1/28/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "DJKeyboard.h"

@implementation DJKeyboard

- (id)init {
    self = [super init];
    if (self){
        self.navBarColor = [UIColor groupTableViewBackgroundColor];
        self.fontColor = [UIColor blackColor];
    }
    return self;
}

#pragma mark public methods

- (UIToolbar *)getToolbarWithPrevEnabled:(BOOL)prev NextEnabled:(BOOL)next {
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle: UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    [toolbar setBarTintColor: self.navBarColor];
    
    UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: self action: nil];
    
    NSArray *barButtonItems = [NSArray arrayWithObjects: [self getPreviousNextBarButtonItemWithPrevEnabled: prev NextEnabled: next], spaceButtonItem, [self getDoneButton], nil];
    [toolbar setItems: barButtonItems];
    
    return toolbar;
}

#pragma mark private methods

- (UIBarButtonItem *)getPreviousNextBarButtonItemWithPrevEnabled: (BOOL)pre NextEnabled: (BOOL)next {
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems: [NSArray arrayWithObjects: @"Previous", @"Next", nil]];
    [segmentedControl setEnabled: pre forSegmentAtIndex: 0];
    [segmentedControl setEnabled: next forSegmentAtIndex: 1];
    
    [segmentedControl addTarget: self action: @selector(segmentControlHandler:) forControlEvents: UIControlEventValueChanged];
    
    UIBarButtonItem *preNextBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: segmentedControl];
    
    return preNextBarButtonItem;
}

- (UIBarButtonItem *)getDoneButton {
    
    UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone target: self action: @selector(doneButtonPressed:)];
    
    return doneButtonItem;
}

- (void)segmentControlHandler: (id)sender {
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    // Previous
    if (segmentedControl.selectedSegmentIndex == 0) {
        
        if (self.delegate && [self.delegate respondsToSelector: @selector(previousClickedWithTag:)]) {
            
            [self.delegate previousClickedWithTag: self.currentTag];
        }
        
    // Next
    } else {
        
        if (self.delegate && [self.delegate respondsToSelector: @selector(nextClickedWithTag:)]) {
            
            [self.delegate nextClickedWithTag: self.currentTag];
        }
    }
}

- (void)doneButtonPressed: (id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector: @selector(doneClicked)]) {
        
        [self.delegate doneClicked];
    }
}

@end