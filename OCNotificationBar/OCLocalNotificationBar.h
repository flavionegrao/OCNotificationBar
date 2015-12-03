//
//  OCLocalNotificationBar.h
//  OCNotificationBar
//
//  Created by Flavio Negrão Torres on 02/12/15.
//  Copyright © 2015 Apetis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCLocalNotificationBarDelegate;

@interface OCLocalNotificationBar : UIVisualEffectView

#pragma mark - Text Labels
@property (nonatomic, weak, readonly) UILabel* textLabel;
@property (nonatomic, weak, readonly) UILabel* detailTextLabel;


#pragma mark - Image
@property (nonatomic, strong, nullable) UIImage* image;


#pragma mark - AccessoryView
// if set the view will be placed on the right hand side vertically centrelized
@property (nonatomic, strong, nullable) UIView* accessoryView;


#pragma mark - Other

// Default is lightGrayColor
@property (nonatomic, strong, nullable) UIColor* bottomHairlineColor;

#pragma mark - Delegate
@property (nonatomic, assign, nullable) id <OCLocalNotificationBarDelegate>  delegate;

@end


@protocol OCLocalNotificationBarDelegate <NSObject>

- (void) notificationBarDidReceiveTap:(nonnull OCLocalNotificationBar*) bar;

@end
