//
//  CellAlbuns.h
//  AplicationTest
//
//  Created by Administrator on 8/25/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellAlbuns : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *namealbun;
+ (CellAlbuns *)CellAlbuns;
@end
