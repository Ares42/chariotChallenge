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
    
    NSLog(@"Email = %@", self.textFieldEmail.text);
    NSLog(@"Password = %@", self.textFieldPassword.text);
    
    [self serverLoginTest];
    
    
    
}

-(void)serverLoginTest {
    /*
    NSString *post = [NSString stringWithFormat: @"&Username=%@, &Password=%@", @"username", @"password"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.chariotnow.com/1/auth/sign_in"]]];
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
    */
    
    NSString *fixedURL = [NSString stringWithFormat:@"https://api.chariotnow.com/1/auth/sign_in"];
    NSURL *url = [NSURL URLWithString:fixedURL];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    request.HTTPMethod = @"POST";
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [dictionary setValue:self.textFieldEmail.text forKey:@"email"];
    [dictionary setValue:self.textFieldPassword.text forKey:@"password"];
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    [request setHTTPBody:data];
    if (!error) {
        NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            NSInteger responseStatusCode = [httpResponse statusCode];
            if (responseStatusCode == 200 && data) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                    NSDictionary *fetchedData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    [self performSegueWithIdentifier:@"segue" sender:self];
                    NSLog(@"it works!");
                });
            } else {
                NSLog(@"Sending to individuals failed");
            }
        }];
        [uploadTask resume];
        NSLog(@"Connected to server");
    } else {
        NSLog(@"Cannot connect to server");
    }
    
}




@end
