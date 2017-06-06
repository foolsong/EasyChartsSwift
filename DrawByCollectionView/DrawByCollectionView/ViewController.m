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

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *titleList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    [self jump2DrawLineVC];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.tableFooterView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 64);
    tableView.delegate = self;
    tableView.dataSource = self;
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


#pragma  mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleList count];
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
        [self jump2DrawCircleVC];
    } else if (indexPath.row == 2) {
        [self jump2ProgressVC];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *)titleList {
    if (_titleList == nil) {
        _titleList = @[@"折线图",@"圆饼图",@"进度条"];
    }
    return _titleList;
}

@end
