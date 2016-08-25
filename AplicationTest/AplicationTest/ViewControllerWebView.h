//
//  ViewControllerWebView.h
//  AplicationTest
//
//  Created by Administrator on 8/25/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerWebView : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (retain, nonatomic)NSString *weburl;
@end
