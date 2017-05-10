//
//  ShareViewController.m
//  BeStronger
//
//  Created by Roy on 17/3/15.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "ShareViewController.h"
#import "MyShareCell.h"

@interface ShareViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title=@"分享中心";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark tableview协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellId=@"shareCell";
    MyShareCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[MyShareCell shareCell];
    }
    
    cell.iconImageView.image=[UIImage imageNamed:@"me_hei"];
    cell.userNameLabel.text=[NSString stringWithFormat:@"用户%d", indexPath.row];
    cell.contentLabel.text=[NSString stringWithFormat:@"上面的步骤看起来复杂，但是当你习惯xib来编程的时候，使用鼠标拖拉空间，微调界面，那种感觉就像自己不是纯粹的程序员"];
    cell.contentImageView1.image=[UIImage imageNamed:@"login_logo"];
    

    return cell;

}



@end
