//
//  UserProfileViewController.m
//  chariotChallenge
//
//  Created by Luke Solomon on 2/9/15.
//  Copyright (c) 2015 Luke Solomon. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldFirst;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLast;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCurrentPassword;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNewPassword;
@property (weak, nonatomic) IBOutlet UIButton *buttonUpdate;


@end

@implementation UserProfileViewController {
    NSDictionary *userProfileData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self serverGetRequest];
    
    self.textFieldFirst.text = userProfileData[@"first_name"];
}

-(void)serverGetRequest {
    
    NSString *fixedUrl = [NSString stringWithFormat:@"https://api.chariotnow.com/1/user/me"];
    
    NSURL *url = [NSURL URLWithString:fixedUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    //[request setValue:@"Chariot-Token" forKey:@"eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJleHBpcmUiOjE0MjM4NTY3ODgsInVzZXJpZCI6NDYxOX0.-ooG23KFagd6NJ7--7hJTC--bCXScXr8TDOl57T3JrIgHIO8sB3j7aRC4WdZSvHtYdzuY1mOhb2Cp4tOgAvc_A"];
    
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        NSInteger responseStatusCode = [httpResponse statusCode];
        
        if (responseStatusCode == 200 && data) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                userProfileData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"It Worked!");
                NSLog(@"%@", userProfileData);
            });
            
        } else {
            NSLog(@"cannot connect to server");
            
        }
        
    }];
    
    [dataTask resume];
}

@end