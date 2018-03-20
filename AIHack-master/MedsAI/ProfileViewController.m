//
//  ProfileViewController.m
//  MedsAI
//
//  Created by whoami on 3/17/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "ProfileViewController.h"
#import "SWRevealViewController.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIImageView* avatar;
@property (weak, nonatomic) IBOutlet UILabel* name;
@property (weak, nonatomic) IBOutlet UILabel* other;
@property (weak, nonatomic) IBOutlet UIButton* edit;
@property (weak, nonatomic) IBOutlet UIButton* searchSettings;
@property (weak, nonatomic) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSArray<NSString*>* extraNames;
@property (nonatomic, strong) NSArray<NSString*>* imageNames;

@end

@implementation ProfileViewController

- (void)configureRevealVC {
    SWRevealViewController *revealViewController = self.revealViewController;
    
    if (revealViewController) {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector(revealToggle:)];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureRevealVC];
    _extraNames = @[@"Аллергия", @"Противопоказания", @"Особые случаи", @"Другие пользователи"];
    _imageNames = @[@"allergy", @"contraindications", @"situations", @"users"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _avatar.image = [UIImage imageNamed:@"emil"];
    _avatar.layer.cornerRadius = _avatar.bounds.size.width/2.0;
//    _avatar.layer.borderWidth = 0.5;
//    _avatar.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1].CGColor;
    _avatar.clipsToBounds = YES;
    [self.searchSettings addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) change: (id) sender {
    
    return;
}

- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return false;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProfileTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.title.text = self.extraNames[indexPath.row];
    cell.image.image = [UIImage imageNamed:_imageNames[indexPath.row]];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
