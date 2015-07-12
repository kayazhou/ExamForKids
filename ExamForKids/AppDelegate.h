//
//  AppDelegate.h
//  ExamForKids
//
//  Created by kaisya on 7/8/15.
//  Copyright (c) 2015 kaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;


BOOL addition;
BOOL subtraction;
BOOL underTen;
BOOL underHundred;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UINavigationController *navController;

@end

