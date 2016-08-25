//
//  CellAlbuns.m
//  AplicationTest
//
//  Created by Administrator on 8/25/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "CellAlbuns.h"

@implementation CellAlbuns

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.image.layer.cornerRadius=20;
    
    self.image.clipsToBounds = YES;
    // Configure the view for the selected state
}

+ (CellAlbuns *)CellAlbuns
{
    NSArray *objects;
    CellAlbuns *cell;
    
    objects = [[NSBundle mainBundle] loadNibNamed:@"CellAlbuns" owner:nil options:nil];
    
    cell = objects[0];
    
    return cell;
}

@end
