//
//  LoginClient.m
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "LoginClient.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#import <AFNetworking.h>

@interface LoginClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation LoginClient
/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request here to login.
 *
 * 2) Using the following endpoint, make a request to login
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php
 *
 * 3) Don't forget, the endpoint takes two parameters 'username' and 'password'
 *
 * 4) A valid username is 'AppPartner'
 *    A valid password is 'qwerty'
 **/

- (void)loginWithUsername:(NSString *)username password:(NSString *)password completion:(void (^)(NSDictionary *, CFAbsoluteTime))completion
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *params = @{@"username": username,
                             @"password": password};
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    [manager POST:@"http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/login.php" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        CFAbsoluteTime elapsedTime = CFAbsoluteTimeGetCurrent() - startTime;
        NSError* error;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        completion((NSDictionary*) result,elapsedTime);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSDictionary * errorResult = [[NSDictionary alloc]init];
        if(error.code == -1011){
            errorResult = @{@"errorCode": @"-1011",
                            @"message": @"Invalid UserName or Password"};
            completion((NSDictionary*) errorResult,0);
        }else{
            errorResult = @{@"errorCode": @"Request Failed",
                            @"message": @"Error"};
            completion((NSDictionary*) errorResult,0);
        }
    }];
}

@end
