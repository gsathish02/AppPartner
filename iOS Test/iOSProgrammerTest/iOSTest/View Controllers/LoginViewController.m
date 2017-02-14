//
//  LoginViewController.m
//  iOSTest
//
//  Created by App Partner on 9/6/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "LoginViewController.h"
#import "MenuViewController.h"
#import "LoginClient.h"
#import "AppDelegate.h"


@interface LoginViewController ()
@property (nonatomic, strong) LoginClient *client;
@end

@implementation LoginViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Take username and password input from the user using UITextFields
 *
 * 3) Using the following endpoint, make a request to login
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php
 *    Parameter One: username
 *    Parameter Two: password
 *
 * 4) A valid username is 'AppPartner'
 *    A valid password is 'qwerty'
 *
 * 5) Calculate how long the API call took in milliseconds
 *
 * 6) If the response is an error display the error in a UIAlertView
 *
 * 7) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertView
 *
 * 8) When login is successful, tapping 'OK' in the UIAlertView should bring you back to the main menu.
 **/


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Login";
    
    //Corner
    [_userName.layer setBorderColor:[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
    [_userName.layer setBorderWidth:2.0];
    _userName.layer.cornerRadius = 5;
    _userName.clipsToBounds = YES;
    
    [_password.layer setBorderColor:[[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor]];
    [_password.layer setBorderWidth:2.0];
    _password.layer.cornerRadius = 5;
    _password.clipsToBounds = YES;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:false];
    //Padding
    self.userName.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    self.password.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didPressLoginButton:(id)sender
{
    LoginClient *loginClient = [[LoginClient alloc]init];
    if([_userName.text  isEqual: @""] || [_password.text  isEqual: @""]){
        [self showAlertView:@"Fields should not be empty" withMessage:nil];
    }else{
        [loginClient loginWithUsername:_userName.text password:_password.text completion:^(NSDictionary* result, CFTimeInterval timeTaken){
            
            NSString * Status = [result objectForKey:@"message"];
            if(timeTaken >0){
                NSString * duration = [NSString stringWithFormat: @"Operation took %2.2f sec", timeTaken];
                [self showAlertView:Status withMessage:duration];
            }else{
                [self showAlertView:Status withMessage:nil];
            }
        }];
    }
}

-(void)showAlertView: (NSString*) Title withMessage:(NSString*) message{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:Title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
