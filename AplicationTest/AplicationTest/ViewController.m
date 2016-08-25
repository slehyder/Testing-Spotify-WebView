//
//  ViewController.m
//  AplicationTest
//
//  Created by Administrator on 8/24/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(id) initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if (self) {
        
#pragma mark - init var the class conneciton utilitys
       
        
        _AFSession = [AFHTTPSessionManager manager];
        
        self.dataSearch =[[NSMutableArray alloc] init];
        
    }
    
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.colletionview registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    self.colletionview.backgroundColor = [UIColor clearColor];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor grayColor];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.colletionview addSubview:refreshControl];
    self.colletionview.alwaysBounceVertical = YES;
    self.ref=refreshControl;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)refresh{

    [self searchBarSearchButtonClicked:self.searchbar];


}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [[self.AFSession operationQueue] cancelAllOperations];
    
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self performSelector:@selector(sendSearchRequest:) withObject:searchBar.text afterDelay:0.1f];

    [searchBar resignFirstResponder];
    
}

-(void)sendSearchRequest:(NSString *)search{
    
    [self.dataSearch removeAllObjects];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *encoded = [[NSString stringWithFormat:@"%@",Endpoint_GET_Artist(search,@"artist")]  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[_AFSession GET:encoded parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

        [self.ref endRefreshing];
        
        @autoreleasepool {
            
#pragma mark - set data in array data
            
            for (NSDictionary*into in [[responseObject objectForKey:@"artists"] objectForKey:@"items"]) {
                
#pragma mark - init model twitter
                
                self.Model=[[ModelArtist alloc] init];
                
                self.Model.name=[NSString stringWithFormat:@"%@",[into valueForKey:@"name"]];
                
                if ([[into valueForKey:@"images"] count]!=0) {
                    
                    self.Model.urlImage=[NSString stringWithFormat:@"%@",[[[into valueForKey:@"images"] objectAtIndex:0] valueForKey:@"url"]];
                }else{
                
                self.Model.urlImage=@"No image";
                
                }
                
                self.Model.idartist=[NSString stringWithFormat:@"%@",[into valueForKey:@"id"]];
                
                self.Model.followers=[NSString stringWithFormat:@"%@",[[into valueForKey:@"followers"] valueForKey:@"total"]];
                
                self.Model.popularity=[NSString stringWithFormat:@"%@",[into valueForKey:@"popularity"]];
  
                [self.dataSearch addObject:self.Model];
                
            }
    
            
        }
 
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.colletionview reloadData];
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
       
        
        [self.ref endRefreshing];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }] resume];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSearch count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];

    
    self.Model =[self.dataSearch objectAtIndex:indexPath.row];
    
    [cell.avatar hnk_setImageFromURL:[NSURL URLWithString:self.Model.urlImage] placeholder:[UIImage imageNamed:@"default_profile_2_400x400"]];

    cell.name.text=self.Model.name;
  
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    float with=collectionView.frame.size.width/3-1;
    
    return CGSizeMake(with, with);

}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 1.0;

}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
   return 1.0;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.Model =[self.dataSearch objectAtIndex:indexPath.row];
    
    ViewControllerProfile *profile = [self.storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"profile"]];
 
    profile.Model=[self.dataSearch objectAtIndex:indexPath.row];
    
    UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:profile];
    
    [self presentViewController:navControl animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
