//
//  BBViewController.h
//  MedsAI
//
//  Created by Vlad on 18/03/2018.
//  Copyright © 2018 Mountain Viewer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AATableViewCell.h"
@interface BBViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet NSArray<NSString*> *aaa;
@property (strong, nonatomic) IBOutlet NSArray<NSString*> * bbb;

@end
