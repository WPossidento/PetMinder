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
    
    //Tab Bar
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    UIViewController *taskListViewController = [[TaskListViewController alloc] initWithNibName:@"TaskListViewController" bundle:nil];
    taskListViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tasks" image:[UIImage imageNamed:@"text-list"] tag:0];

    UIViewController *petListViewController = [[PetListViewController alloc] initWithNibName:@"PetListViewController" bundle:nil];
    petListViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Pets" image:[UIImage imageNamed:@"pet-dog"] tag:0];

    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.00 green:0.65 blue:1.00 alpha:1.0]];
    
    //Navigation controllers
    UINavigationController *navctl1 = [[UINavigationController alloc]init];
    [navctl1 setViewControllers:@[taskListViewController]];
    UINavigationController *navctl2 = [[UINavigationController alloc]init];
    [navctl2 setViewControllers:@[petListViewController]];

    self.viewControllers = @[navctl1, navctl2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
