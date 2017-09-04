//
//  ViewController.m
//  DrawByCollectionView
//
//  Created by 宋永建 on 2017/4/24.
//  Copyright © 2017年 宋永建. All rights reserved.
//

#import "ViewController.h"
#import "DrawLineViewController.h"
#import "DrawCircleViewController.h"
#import "ProgressViewViewController.h"
#import "DrawBarViewController.h"
#import "BrokenLine2ViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *titleList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.tableFooterView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 64, ScreenW, ScreenH - 64);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 200;
    [self.view addSubview:tableView];
}

- (void)jump2DrawLineVC {
    DrawLineViewController *vc = [[DrawLineViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jump2DrawCircleVC {
    DrawCircleViewController *vc = [[DrawCircleViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jump2ProgressVC {
    ProgressViewViewController *vc = [[ProgressViewViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jump2DrawBarVC {
    DrawBarViewController *vc = [[DrawBarViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)jump2BrokenLine2VC {
    BrokenLine2ViewController *vc = [[BrokenLine2ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"DrawVCIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID];
    }
    [cell.textLabel setText:self.titleList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self jump2DrawLineVC];
    } else if (indexPath.row == 1) {
        [self jump2BrokenLine2VC];
    } else if (indexPath.row == 2) {
        [self jump2DrawCircleVC];
    } else if (indexPath.row == 3) {
        [self jump2ProgressVC];
    } else if (indexPath.row == 4) {
        [self jump2DrawBarVC];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *)titleList {
    if (_titleList == nil) {
        _titleList = @[@"LineChart-1",@"LineChart-2",@"PieChart",@"progressCircle"]; //,@"柱状图"
    }
    return _titleList;
}

@end
