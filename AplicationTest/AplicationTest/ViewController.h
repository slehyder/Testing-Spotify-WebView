//
//  ViewController.h
//  AplicationTest
//
//  Created by Administrator on 8/24/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
#import "AFNetworking.h"
#import "ModelArtist.h"
#import "Haneke.h"
#import "ViewControllerProfile.h"

@interface ViewController : UIViewController<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;

@property (weak, nonatomic) IBOutlet UICollectionView *colletionview;
@property (strong, nonatomic)AFHTTPSessionManager *AFSession;
@property (strong, nonatomic)NSMutableArray *dataSearch;
@property (strong, nonatomic)ModelArtist *Model;
@property (strong, nonatomic)UIRefreshControl *ref;

#define Endpoint_GET_Artist(Name,type) [NSString stringWithFormat:@"https://api.spotify.com/v1/search?q=%@&type=%@",Name,type]

#define Endpoint_GET_ArtistProfile(idArtist) [NSString stringWithFormat:@"https://api.spotify.com/v1/artists/%@/albums",idArtist]

@end

