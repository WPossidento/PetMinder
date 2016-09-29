//
//  TabBarController.m
//  PetManager
//
//  Created by Olivia Taylor on 9/9/16.
//  Copyright © 2016 Olivia Taylor. All rights reserved.
//

#import "TabBarController.h"
#import "TaskListViewController.h"
#import "PetListViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                       [UIColor whiteColor], NSForegroundColorAttributeName,
//                                                       nil] forState:UIControlStateNormal];
    
    UIViewController *taskListViewController = [[TaskListViewController alloc] initWithNibName:@"TaskListViewController" bundle:nil];
    taskListViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tasks" image:[UIImage imageNamed:@"text-list"] tag:0];
//    taskListViewController.tabBarItem.image = [[UIImage imageNamed:@"text-list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *petListViewController = [[PetListViewController alloc] initWithNibName:@"PetListViewController" bundle:nil];
    petListViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Pets" image:[UIImage imageNamed:@"pet-dog"] tag:0];
//    petListViewController.tabBarItem.image = [[UIImage imageNamed:@"pet-dog"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.00 green:0.65 blue:1.00 alpha:1.0]];
    
    UINavigationController *navctl1 = [[UINavigationController alloc]init];
    [navctl1 setViewControllers:@[taskListViewController]];
    UINavigationController *navctl2 = [[UINavigationController alloc]init];
    [navctl2 setViewControllers:@[petListViewController]];

    self.viewControllers = @[navctl1, navctl2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
