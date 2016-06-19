//
//  GroupVC.m
//  LudipicsUpdated
//
//  Copyright © 2016 Ludipics. All rights reserved.
//

#import "GroupVC.h"
#import "GroupTableCellVC.h"
#import "LudipicsUpdated-Swift.h"

@interface GroupVC ()

@end

@implementation GroupVC
- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
    // Do any additional setup after loading the view from its nib.\
    
    
    _Title = @[@"Stranger Shenanigans",@"Nightlife", @"College Life", @"Artsy",@"People Watching"];
    
    _Description = @[@"3802 Members",@"332 Members",@"3423 Members",@"2344 Members",@"5234 Members"];
    
    _Images = @[@"StrangerSh",@"Nightlife",@"college-life",@"Artsy",@"peoplewatching"];
    
    
    
}

- (void)viewDidLayoutSubviews
{
    
    [super viewDidLayoutSubviews];
    CGRect rect = self.navigationController.navigationBar.frame;
    float y = rect.size.height + rect.origin.y;
    self.tableView.contentInset = UIEdgeInsetsMake(y ,0,0,0);
    
}

- (NSInteger) numberofSectionsinTableView:(UITableView*) tableView {
    return 1;
}

- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection:(NSInteger)section {
    
    return _Title.count;
    
}



- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"tableCell";
    
    GroupTableCellVC *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    
    int row = [indexPath row];
    cell.TitleLabel.text = _Title[row];
    cell.DescriptionLabel.text = _Description[row];
    cell.ThumbImage.image = [UIImage imageNamed:_Images[row]];
    
    return cell;
    
}



-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"cameraVCID"];
    [self presentViewController:controller animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"detailShow"]) {
        
        
        GroupPhotoDetailVC *groupphotodetailvc = [segue destinationViewController];
        
        
        
        NSIndexPath *myPath = [self.tableView indexPathForSelectedRow];
        
        
        
        GroupTableCellVC *cell = [self.tableView cellForRowAtIndexPath:myPath];
        NSString *cellText = cell.TitleLabel.text;
        _navTitle = cellText;
        groupphotodetailvc.photodetailnavVC.title = _navTitle;
        int row = [myPath row];
        
        groupphotodetailvc.DetailMod = @[_Title[row],_Description[row],_Images[row]];
        
    }
}
*/
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"detailShow"]) {
        
        NSIndexPath *myPath = [self.tableView indexPathForSelectedRow];
        TestViewController *groupphotodetailvc = [segue destinationViewController];
        
        GroupTableCellVC *cell = [self.tableView cellForRowAtIndexPath:myPath];
        NSString *cellText = cell.TitleLabel.text;
        _navTitle = cellText;
        groupphotodetailvc.navTitle.title = _navTitle;
        int row = [myPath row];
        groupphotodetailvc.DetailMod = @[_Title[row],_Description[row],_Images[row]];

    }
    
       
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end