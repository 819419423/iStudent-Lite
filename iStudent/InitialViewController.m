//
//  InitialViewController.m
//  iStudent
//
//  Created by Kobe Dai on 9/4/13.
//  Copyright (c) 2013 Jing Dai. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

@synthesize lmvc;

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
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(showLeftSlidingMenu:)
                                                 name: @"ShowLeftMenu"
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(hideLeftSlidingMenu:)
                                                 name: @"HideLeftMenu"
                                               object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(changeTopViewController:)
                                                 name: @"ChangeTopView"
                                               object: nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Storyboard" bundle: nil];
    lmvc = [storyboard instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
    self.svc = [storyboard instantiateViewControllerWithIdentifier: @"Semester"];
    self.csvc = [storyboard instantiateViewControllerWithIdentifier: @"Courses"];
    self.cvc = [storyboard instantiateViewControllerWithIdentifier: @"Calendar"];
    
    self.topViewController = self.svc;
    self.underLeftViewController = lmvc;
    self.anchorRightRevealAmount = 260.f;
    [self.view addGestureRecognizer: self.panGesture];
}

- (void)changeTopViewController: (NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    NSString *viewControllerName = [dict objectForKey: @"ViewController"];
    
    if ([viewControllerName isEqualToString: @"Semester"]) {
        self.topViewController = self.svc;
    } else if ([viewControllerName isEqualToString: @"Schedule"]) {
        self.topViewController = self.cvc;
    } else if ([viewControllerName isEqualToString: @"Courses"]) {
        self.topViewController = self.csvc;
    }
    
    [self resetTopViewWithAnimations:nil onComplete:nil];
}

- (void)showLeftSlidingMenu: (NSNotification *)notification
{
    [self anchorTopViewTo: ECRight];
}

- (void)hideLeftSlidingMenu: (NSNotification *)notification
{
    [self anchorTopViewTo: ECLeft];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
