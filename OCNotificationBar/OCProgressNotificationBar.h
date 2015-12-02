//
//  OCNotificationBar.h
//  OCNotificationBar
//
//  Created by Flavio Negrão Torres on 11/20/15.
//  Copyright © 2015 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCProgressNotificationBar : UIView

#pragma mark - Text
@property (nonatomic, strong, nullable) NSString* text;

// Default is black color
@property (nonatomic, strong, nullable) UIColor* textColor;


#pragma mark - Image
@property (nonatomic, strong, nullable) UIImage* image;


#pragma mark - AccessoryView
// if set the view will be placed on the right hand side vertically centrelized
@property (nonatomic, strong, nullable) UIView* accessoryView;


#pragma mark - Progress Bar
@property (nonatomic, assign) float progress;

// Default is dark green
@property (nonatomic, strong, nullable) UIColor* progressBarColor;

// Default is gray color
@property (nonatomic, strong, nullable) UIColor* progressBarBackgroundColor;


#pragma mark - Other

// Default is lightGrayColor
@property (nonatomic, strong, nullable) UIColor* bottomHairlineColor;

@end
