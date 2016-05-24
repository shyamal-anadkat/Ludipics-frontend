//
//  GroupVC.m
//  LudipicsUpdated
//
//  Copyright © 2016 Ludipics. All rights reserved.
//

#import "GroupVC.h"
#import "GroupTableCellVC.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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