//
//  ChatClient.m
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "ChatClient.h"
#import <AFNetworking.h>

@interface ChatClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation ChatClient

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make a request to fetch chat data used in this app.
 *
 * 2) Using the following endpoint, make a request to fetch data
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php
 **/
- (void)fetchChatData:(void (^)(id responseObject, NSError *error))completion{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSError* error;
        NSDictionary* result = [NSJSONSerialization JSONObjectWithData:responseObject
                                                               options:kNilOptions
                                                                 error:&error];
            completion(result,nil);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
         completion(nil,error);
    }];
}

@end
