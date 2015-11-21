//
//  OCNotificationBar.h
//  OCNotificationBar
//
//  Created by Flavio Negrão Torres on 11/20/15.
//  Copyright © 2015 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCNotificationBar : UIView

#pragma mark - Text
@property (nonatomic, strong) NSString* text;

// Default is black color
@property (nonatomic, strong) UIColor* textColor;


#pragma mark - Image
@property (nonatomic, strong) UIImage* image;


#pragma mark - Progress Bar
@property (nonatomic, assign) float progress;

// Default is dark green
@property (nonatomic, strong) UIColor* progressBarColor;

// Default is gray color
@property (nonatomic, strong) UIColor* progressBarBackgroundColor;


#pragma mark - Other

// Default is lightGrayColor
@property (nonatomic, strong) UIColor* bottomHairlineColor;

@end
