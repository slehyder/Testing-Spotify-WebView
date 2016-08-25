//
//  CellWithAvalaibleMarkets.m
//  AplicationTest
//
//  Created by Administrator on 8/25/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "CellWithAvalaibleMarkets.h"

@implementation CellWithAvalaibleMarkets

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.imagealbun.layer.cornerRadius=20;
    
    self.imagealbun.clipsToBounds = YES;
    // Configure the view for the selected state
}

+ (CellWithAvalaibleMarkets *)Cell
{
    NSArray *objects;
    CellWithAvalaibleMarkets *cell;
    
    objects = [[NSBundle mainBundle] loadNibNamed:@"CellWithAvalaibleMarkets" owner:nil options:nil];
    
    cell = objects[0];
    
    return cell;
}

@end
