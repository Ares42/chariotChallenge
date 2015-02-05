//
//  ViewController.m
//  chariotChallenge
//
//  Created by Luke Solomon on 2/3/15.
//  Copyright (c) 2015 Luke Solomon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)buttonLogIn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonLogIn:(UIButton *)sender {
    NSString *post = [NSString stringWithFormat: @"&Username=%@ &Password=%@", @"username", @"password"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.abcde.com/xyz/login.aspx"]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];
     NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
     if (conn){
         NSLog(@"Connection Successful");
     } else {
         NSLog(@"Connection Failed");
     }
}



@end
