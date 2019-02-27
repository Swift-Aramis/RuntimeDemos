//
//  MainViewController.m
//  RuntimeLearn
//
//  Created by 提运佳 on 2019/2/25.
//  Copyright © 2019 Swift_Aramis. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main";
}

- (IBAction)buttonOneAction:(UIButton *)sender {

}

- (IBAction)buttonTwoAction:(UIButton *)sender {

}

- (IBAction)pushToDetailAction:(UIButton *)sender {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
