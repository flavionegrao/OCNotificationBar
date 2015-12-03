//
//  OCLocalNotificationBar.m
//  OCNotificationBar
//
//  Created by Flavio Negrão Torres on 02/12/15.
//  Copyright © 2015 Apetis. All rights reserved.
//

#import "OCLocalNotificationBar.h"

@interface OCLocalNotificationBar()
//@property (nonatomic, weak) UIView* contentView;
@property (nonatomic, weak) UILabel* textLabel;
@property (nonatomic, weak) UILabel* detailTextLabel;
@property (nonatomic, weak) UIImageView* imageView;
@property (nonatomic, weak) UIView* accessoryContainerView;
@property (nonatomic, strong) NSLayoutConstraint* accessoryViewWidthConstraint;

@property (nonatomic, weak) CALayer* bottomHairlineLayer;
@end

@implementation OCLocalNotificationBar

- (id)init {
    return [self initWithFrame:CGRectZero];
    
}

- (instancetype) initWithFrame:(CGRect)frame {
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self = [super initWithEffect:effect];
    if (self)  {
        self.frame = frame;
        [self config];
    }
    return self;
}

- (instancetype) initWithEffect:(UIVisualEffect *)effect {
    self = [super initWithEffect:effect];
    if (self) {
        [self config];
    }
    return self;
}

#pragma mark - Config

- (void) config {
    [self createSubViews];
    [self configAutoLayoutConstraints];
    [self applyDefaults];
    [self configGestureRecognizers];
}

- (void) createSubViews {
    
    //    UIView* contentView = [[UIView alloc]initWithFrame:self.bounds];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    UILabel* textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UILabel* detailTextLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UIView* accessoryContainerView = [[UIView alloc]initWithFrame:CGRectZero];
    
    //    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    accessoryContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:textLabel];
    [self.contentView addSubview:detailTextLabel];
    [self.contentView addSubview:accessoryContainerView];
    [self addSubview:self.contentView];
    
    self.imageView = imageView;
    self.textLabel = textLabel;
    self.detailTextLabel = detailTextLabel;
    self.accessoryContainerView = accessoryContainerView;
    //    self.contentView = contentView;
    
}


- (void) configAutoLayoutConstraints {
    
    NSDictionary* views = @{@"imageView":self.imageView,
                            @"textLabel":self.textLabel,
                            @"detailTextLabel":self.detailTextLabel,
                            @"contentView":self.contentView,
                            @"accessoryContainerView":self.accessoryContainerView};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[contentView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[imageView]-[textLabel]-[accessoryContainerView]-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[imageView]-[detailTextLabel]-[accessoryContainerView]-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView]-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[textLabel][detailTextLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[accessoryContainerView]-|" options:0 metrics:nil views:views]];
    
    self.accessoryViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.accessoryContainerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self.contentView addConstraint:self.accessoryViewWidthConstraint];
    
    [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.detailTextLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}


- (void) applyDefaults {
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    //    self.contentView.backgroundColor = [UIColor clearColor];
}


#pragma mark - Getter and Setters


- (void) setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    [self setNeedsLayout];
}


- (void) setBottomHairlineColor:(UIColor *)bottomHairlineColor {
    _bottomHairlineColor = bottomHairlineColor;
    self.bottomHairlineLayer.backgroundColor = bottomHairlineColor.CGColor;
}

- (void) setAccessoryView:(UIView *)accessoryView {
    _accessoryView = accessoryView;
    
    [self.accessoryContainerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    if (accessoryView) {
        self.accessoryViewWidthConstraint.constant= accessoryView.frame.size.width;
        accessoryView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.accessoryContainerView addSubview:accessoryView];
        
        NSDictionary* views = @{@"accessoryView":accessoryView};
        [self.accessoryContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[accessoryView]|" options:0 metrics:nil views:views]];
        [self.accessoryContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[accessoryView]|" options:0 metrics:nil views:views]];
        
    } else {
        self.accessoryViewWidthConstraint.constant = 0;
    }
    
    [self setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}


#pragma mark - View Layout

- (void) layoutSubviews {
    if (!self.bottomHairlineLayer) {
        CALayer* subLayer = [CALayer layer];
        subLayer.backgroundColor = self.bottomHairlineColor.CGColor ?: [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:subLayer];
        self.bottomHairlineLayer = subLayer;
    }
    self.bottomHairlineLayer.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 0.5);
    
    CAShapeLayer* maskLayer = [CAShapeLayer new];
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithOvalInRect:self.imageView.bounds];
    maskLayer.frame = self.imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.imageView.layer.mask = maskLayer;
}


#pragma mark - Gesture Recognizers

- (void) configGestureRecognizers {
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didReceiveTap:)];
    [self.contentView addGestureRecognizer:tap];
}

- (void) didReceiveTap:(id) sender {
    if (self.delegate) {
        [self.delegate notificationBarDidReceiveTap:self];
    }
}


@end
