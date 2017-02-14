//
//  ChatTableViewCell.m
//  iOSTest
//
//  Created by App Partner on 9/23/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "ChatTableViewCell.h"

@interface ChatTableViewCell ()

@property (nonatomic, strong) Message *message;
@end

@implementation ChatTableViewCell

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Setup cell to match mockup
 * 
 * 2) Include user's avatar image
 **/


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setCellData:(Message *)message
{
    dispatch_async(dispatch_get_global_queue(0,0), ^{
       
        NSData * data = [[NSData alloc] initWithContentsOfURL:message.avatarURL];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cellImage.image = [UIImage imageWithData: data];
        });
        self.cellImage.layer.cornerRadius = self.cellImage.frame.size.height /2;
        self.cellImage.layer.masksToBounds = YES;
        self.cellImage.layer.borderWidth = 0;
    });
    [self.header setText:message.username];
    [self.body setText:message.text];
    //UIFont *cellFont = [UIFont systemFontOfSize:16.0];
}

@end
