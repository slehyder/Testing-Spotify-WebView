//
//  CellWithAvalaibleMarkets.h
//  AplicationTest
//
//  Created by Administrator on 8/25/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWithAvalaibleMarkets : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagealbun;
@property (weak, nonatomic) IBOutlet UILabel *namealbun;
@property (weak, nonatomic) IBOutlet UILabel *nameAvailablemarket;
+ (CellWithAvalaibleMarkets *)Cell;
@end
