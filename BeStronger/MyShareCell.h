//
//  MyShareCell.h
//  BeStronger
//
//  Created by Roy on 17/3/18.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyShareCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@property (weak, nonatomic) IBOutlet UIImageView *contentImageView1;







+(id) shareCell;

@end
