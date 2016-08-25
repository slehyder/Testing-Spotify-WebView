//
//  ViewControllerProfile.m
//  AplicationTest
//
//  Created by Administrator on 8/24/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "ViewControllerProfile.h"

@interface ViewControllerProfile ()

@end

@implementation ViewControllerProfile


-(id) initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if (self) {
        
#pragma mark - init var the class conneciton utilitys
        
        self.data =[[NSMutableArray alloc] init];
        
        _AFSession = [AFHTTPSessionManager manager];
 
    }
    
    return self;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(Back)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.image.clipsToBounds=YES;

    self.tableview.rowHeight = UITableViewAutomaticDimension;
    
    self.tableview.estimatedRowHeight = 100.0 ;
    
    self.Name.text=[NSString stringWithFormat:@"Artist: %@",self.Model.name];
    
    self.popularity.text=[NSString stringWithFormat:@"Popularity: %@",self.Model.popularity];
    
    self.followers.text=[NSString stringWithFormat:@"Followers: %@",self.Model.followers];
    
    [self.image hnk_setImageFromURL:[NSURL URLWithString:self.Model.urlImage] placeholder:[UIImage imageNamed:@"default_profile_2_400x400"]];
    
    
    [self GetInf:self.Model.idartist];
    // Do any additional setup after loading the view.
}

-(void)GetInf:(NSString *)ID{

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *encoded = [[NSString stringWithFormat:@"%@",Endpoint_GET_ArtistProfile(ID)]  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [[_AFSession GET:encoded parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        @autoreleasepool {
            
            for (NSDictionary*into in [responseObject objectForKey:@"items"]) {
                
#pragma mark - init model twitter
                
                self.ModelAlbuns=[[ModelAlbuns alloc] init];
                
                self.ModelAlbuns.nameAlbun=[NSString stringWithFormat:@"%@",[into valueForKey:@"name"]];
                
                if ([[into valueForKey:@"images"] count]!=0) {
                    
                    self.ModelAlbuns.urlImageAlbun=[NSString stringWithFormat:@"%@",[[[into valueForKey:@"images"] objectAtIndex:0] valueForKey:@"url"]];
                }else{
                    
                    self.ModelAlbuns.urlImageAlbun=@"No image";
                    
                }
                
                self.ModelAlbuns.availableMarket=[into valueForKey:@"available_markets"];
                
                self.ModelAlbuns.urlExternal=[into valueForKey:@"external_urls"];
                
                [self.data addObject:self.ModelAlbuns];
                
            }
            
            
        }
  
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableview reloadData];
            
        });

    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.description);
     
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    }] resume];
    


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    self.ModelAlbuns =[self.data objectAtIndex:indexPath.row];
    
    if ([self.ModelAlbuns.availableMarket count]<=5) {
        
        
        static NSString *cellIdentifier = @"CellWithAvalaibleMarkets";
        CellWithAvalaibleMarkets *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            
            cell = [CellWithAvalaibleMarkets Cell];
            
        }
        
        cell.namealbun.text=[NSString stringWithFormat:@"Albun: %@",self.ModelAlbuns.nameAlbun];
        
        NSMutableString *String = [NSMutableString string];
        
        for(int i = 0; i < self.ModelAlbuns.availableMarket.count; i++) {
            
            NSString *Response = [NSString stringWithFormat: @"%@", [self.ModelAlbuns.availableMarket objectAtIndex: i]];
            
            if (i==self.ModelAlbuns.availableMarket.count-1) {
                [String appendString:[NSString stringWithFormat:@"%@ ",Response]];
            }else{
            
            [String appendString:[NSString stringWithFormat:@"%@, ",Response]];
            }
        }
        
        cell.nameAvailablemarket.text=String;
        
    [cell.imagealbun hnk_setImageFromURL:[NSURL URLWithString:self.ModelAlbuns.urlImageAlbun] placeholder:[UIImage imageNamed:@"default_profile_2_400x400"]];
        
        return cell;
        
    }else{
    
    
        
        static NSString *cellIdentifier = @"CellAlbuns";
        CellAlbuns *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            
            cell = [CellAlbuns CellAlbuns];
            
        }
        
        cell.namealbun.text=self.ModelAlbuns.nameAlbun;
        
        [cell.image hnk_setImageFromURL:[NSURL URLWithString:self.ModelAlbuns.urlImageAlbun] placeholder:[UIImage imageNamed:@"default_profile_2_400x400"]];
        
        return cell;
    
    
    
    }
    
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

self.ModelAlbuns =[self.data objectAtIndex:indexPath.row];
    
 
    ViewControllerWebView *webview = [self.storyboard instantiateViewControllerWithIdentifier:[NSString stringWithFormat:@"webview"]];
    
    webview.weburl =[self.ModelAlbuns.urlExternal valueForKey:@"spotify"];
    
    [self.navigationController pushViewController:webview animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.data count];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (IBAction)Back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
