//
//  LeaderboardVC.m
//  LudipicsUpdated
//
//  Created by Shyamal Anadkat on 6/21/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

#import "LeaderboardVC.h"
#import "RKSwipeBetweenViewControllers.h"

@implementation LeaderboardVC

- (void)viewDidLoad


{
[super viewDidLoad];
     self.hidesBottomBarWhenPushed = FALSE;
     UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];

RKSwipeBetweenViewControllers *navigationController = [[RKSwipeBetweenViewControllers alloc]initWithRootViewController:pageController];

//%%% DEMO CONTROLLERS
UIViewController *global = [[UIViewController alloc]init];
UIViewController *local = [[UIViewController alloc]init];


    
    

    
    
    
global.view.backgroundColor = [UIColor redColor];
local.view.backgroundColor = [UIColor whiteColor];

[navigationController.viewControllerArray addObjectsFromArray:@[global,local]];

self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
self.window.rootViewController = navigationController;
[self.window makeKeyAndVisible];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = false;
    self.navigationController.navigationBarHidden = false;
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image Name"]] ;
    //[self addSubview:imageView ];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"customBackground.png"]];
    
}



@end
