//
//  MyShareCell.m
//  BeStronger
//
//  Created by Roy on 17/3/18.
//  Copyright © 2017年 Roy. All rights reserved.
//

#import "MyShareCell.h"

@implementation MyShareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

 
}

+(id)shareCell
{

    return [[NSBundle mainBundle]loadNibNamed:@"fenXiangCell" owner:nil options:nil][0];

}

@end
