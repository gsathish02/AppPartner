//
//  AnimationViewController.h
//  iOSTest
//
//  Created by App Partner on 12/13/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationViewController : UIViewController{
    CGPoint pointLocation;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UIView *imageParentView;
@property (strong, nonatomic) IBOutlet UIButton *spinButton;


@end
