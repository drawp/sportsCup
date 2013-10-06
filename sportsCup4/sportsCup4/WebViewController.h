//
//  WebViewController.h
//  sportsCup4
//
//  Created by Ana Albir on 10/5/13.
//  Copyright (c) 2013 Ana Albir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController {
    IBOutlet UIWebView* _webView;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
