//
//  ChatClient.h
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@interface ChatClient : NSObject

- (void)fetchChatData:(void (^)(id responseObject, NSError *error))completion;
@end
