//
//  HistoryViewController.m
//  MedsAI
//
//  Created by whoami on 3/17/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "HistoryViewController.h"
#import "SWRevealViewController.h"

@interface HistoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray<NSString*>* images;
@property (nonatomic, strong) NSArray<NSString*>* names;
@property (nonatomic, strong) NSArray<NSString*>* manufacturers;
@property (nonatomic, strong) NSArray<NSString*>* types_images;
@property (nonatomic, strong) NSArray<NSString*>* manufcs;

@end

@implementation HistoryViewController


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
    
    self.types_images = @[@"capsule", @"capsule", @"thunderbolt", @"capsule", @"thunderbolt"];
    self.names = @[@"Лазолван", @"Анальгин", @"Амброксол", @"Но-шпа", @"Ксилометазолин"];
    self.manufcs = @[@"Институт де Ангели С.Р.Л.", @"Лекхим", @"АЛСИ", @"Хиноин Завод Фармацевтики", @"Никомед"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.image.image = [UIImage imageNamed:self.types_images[indexPath.row]];
    cell.title.text = self.names[indexPath.row];
//    cell.producer.text = @"It works";
    cell.manuf.text = self.manufcs[indexPath.row];
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
    
}

@end
