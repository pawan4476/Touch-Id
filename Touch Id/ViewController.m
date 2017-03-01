//
//  ViewController.m
//  Touch Id
//
//  Created by Nagam Pawan on 3/1/17.
//  Copyright © 2017 Nagam Pawan. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self touchIdVerification];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchIdVerification{
    
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Touch Id test" reply:^(BOOL success, NSError *error) {
            
            if (error) {
                
                [self alert:@"Error" :@"There is a error in login"];
                
            }
            
            if (success) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [self performSegueWithIdentifier:@"present" sender:nil];
                    
                });
                
            }
            else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                [self alert:@"Verification failed" :@"Touch Id not recognized"];
                    
                });
                
            }
        }];
    }
    
    else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self alert:@"Touch Id Failed" :@"Your device will not support Touch Id"];
            
        });
    }
    
}

-(void)alert:(NSString *)title :(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
