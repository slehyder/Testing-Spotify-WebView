//
//  ViewControllerProfile.h
//  AplicationTest
//
//  Created by Administrator on 8/24/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Haneke.h"
#import "ModelArtist.h"
#import "AFNetworking.h"
#import "ModelAlbuns.h"
#import "CellAlbuns.h"
#import "CellWithAvalaibleMarkets.h"
#import "ViewControllerWebView.h"
@interface ViewControllerProfile : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)AFHTTPSessionManager *AFSession;
@property (retain, nonatomic)ModelArtist *Model;
@property (retain, nonatomic)ModelAlbuns *ModelAlbuns;
@property (strong, nonatomic)NSMutableArray *data;
#define Endpoint_GET_ArtistProfile(idArtist) [NSString stringWithFormat:@"https://api.spotify.com/v1/artists/%@/albums",idArtist]
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *followers;
@property (weak, nonatomic) IBOutlet UILabel *popularity;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
