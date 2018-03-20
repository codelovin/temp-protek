//
//  PharmacyViewController.m
//  MedsAI
//
//  Created by whoami on 3/17/18.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import "PharmacyViewController.h"
#import "SWRevealViewController.h"

@interface PharmacyViewController () <UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (nonatomic, weak) IBOutlet UITableView* tableView;

@property (nonatomic, strong) NSArray<NSString*>* names;
@property (nonatomic, strong) NSArray<NSString*>* kms;

@property (nonatomic, strong) NSArray<NSNumber*>* locs1;
@property (nonatomic, strong) NSArray<NSNumber*>* locs2;

@property (nonatomic, strong) NSArray<NSNumber*>* deltas1;
@property (nonatomic, strong) NSArray<NSNumber*>* deltas2;

@end

@implementation PharmacyViewController

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
    
    self.names = @[@"Ригла", @"Самсон Фарма", @"Неофарм"];
    self.kms = @[@"350м", @"900м", @"1.2км"];
    self.locs1 = @[@55.687186, @55.88718, @54.987186];
    self.locs2 = @[@37.557725, @36.957725, @37.287186];
    self.deltas1 = @[@0.002, @0.002, @0.002];
    self.deltas2 = @[@0.002, @-0.001, @0.001];
    NSLog(@"Loaded!");
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = userLocation.coordinate.latitude;
    location.longitude = userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [mapView setRegion:region animated:YES];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    AptekaTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.km.text = self.kms[indexPath.row];
    cell.title.text = self.names[indexPath.row];
    [cell.image setImage: [UIImage imageNamed:@"pharmacy-1"]];
    MKMapView* mapView = cell.map;
    mapView.delegate = self;
//    mapView.showsUserLocation = YES;
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D locs = {[self.locs1[indexPath.row] floatValue], [self.locs2[indexPath.row] floatValue]};
    [annotation setCoordinate:locs];
    [annotation setTitle:[NSString stringWithFormat: @"%@ %@", @"Аптека", self.names[indexPath.row]]]; //You can set the subtitle too
    [mapView addAnnotation:annotation];
    MKPointAnnotation *annotation2 = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D locs2 = {[self.locs1[indexPath.row] floatValue]+[self.deltas1[indexPath.row] floatValue], [self.locs2[indexPath.row] floatValue]+[self.deltas2[indexPath.row] floatValue
                                                                                                                                        ]};
    [annotation2 setCoordinate:locs2];
    [annotation2 setTitle:[NSString stringWithFormat: @"%@ %@", @"Аптека", self.names[indexPath.row]]]; //You can set the subtitle too
    [mapView addAnnotation:annotation2];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(locs2, 500, 1250);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    [mapView setRegion:adjustedRegion animated:YES];
//
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

- (BOOL) tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
