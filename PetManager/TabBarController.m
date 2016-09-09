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
    
    UIViewController *taskListViewController = [[TaskListViewController alloc] initWithNibName:@"TaskListViewController" bundle:nil];
    taskListViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Tasks" image:[UIImage imageNamed:@"text-list"] tag:0];
    
    
    UIViewController *petListViewController = [[PetListViewController alloc] initWithNibName:@"PetListViewController" bundle:nil];
    petListViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Pets" image:[UIImage imageNamed:@"pet-dog"] tag:0];

    UINavigationController *navctl = [[UINavigationController alloc]init];
    navctl.navigationBar.hidden = YES;
    [navctl setViewControllers:@[petListViewController]];

    self.viewControllers = @[taskListViewController, navctl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
