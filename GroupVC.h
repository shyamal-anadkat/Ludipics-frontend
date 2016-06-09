//
//  GroupVC.h
//  LudipicsUpdated
//
//  Created by Akshansh Thakur on 4/22/16.
//  Copyright © 2016 Akshansh Thakur. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestViewController;

@interface GroupVC : UITableViewController

@property (nonatomic, strong) NSArray *Images;
@property (nonatomic, strong) NSArray *Title;
@property (nonatomic, strong) NSArray *Description;
@property (nonatomic, strong) NSString *navTitle;
@property (strong, nonatomic) IBOutlet UITabBarItem *Camera;


@end
