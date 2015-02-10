//
//  UserProfileViewController.m
//  chariotChallenge
//
//  Created by Luke Solomon on 2/9/15.
//  Copyright (c) 2015 Luke Solomon. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)serverGetRequest {
    
    NSString *fixedUrl = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=avengers&y=&plot=short&r=json"];
    NSURL *url = [NSURL URLWithString:fixedUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        NSInteger responseStatusCode = [httpResponse statusCode];
        
        if (responseStatusCode == 200 && data) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                
                NSDictionary *fetchedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", fetchedData);
            });
            
        } else {
            
            NSLog(@"cannot connect to server");
            
        }
    }];
    [dataTask resume];
}

@end
