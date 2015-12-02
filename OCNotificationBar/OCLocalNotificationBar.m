//
//  OCLocalNotificationBar.m
//  OCNotificationBar
//
//  Created by Flavio Negrão Torres on 02/12/15.
//  Copyright © 2015 Apetis. All rights reserved.
//

#import "OCLocalNotificationBar.h"

@interface OCLocalNotificationBar()
@property (nonatomic, weak) UIView* contentView;
@property (nonatomic, weak) UILabel* textLabel;
@property (nonatomic, weak) UILabel* detailTextLabel;
@property (nonatomic, weak) UIImageView* imageView;
@property (nonatomic, weak) UIView* accessoryContainerView;
@property (nonatomic, strong) NSLayoutConstraint* accessoryViewWidthConstraint;

@property (nonatomic, weak) CALayer* bottomHairlineLayer;
@property (nonatomic, strong) CAShapeLayer* maskLayer;
@end

@implementation OCLocalNotificationBar

- (id)init {
    return [self initWithFrame:CGRectZero];
    
}

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
        [self configAutoLayoutConstraints];
        [self applyDefaults];
    }
    return self;
}


#pragma mark - Config


- (void) createSubViews {
    
    UIView* contentView = [[UIView alloc]initWithFrame:self.bounds];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    UILabel* textLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UILabel* detailTextLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    UIView* accessoryContainerView = [[UIView alloc]initWithFrame:CGRectZero];
    
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    detailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    accessoryContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [contentView addSubview:imageView];
    [contentView addSubview:textLabel];
    [contentView addSubview:detailTextLabel];
    [contentView addSubview:accessoryContainerView];
    [self addSubview:contentView];
    
    self.imageView = imageView;
    self.textLabel = textLabel;
    self.detailTextLabel = detailTextLabel;
    self.accessoryContainerView = accessoryContainerView;
    self.contentView = contentView;
    
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
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[textLabel][detailTextLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[accessoryContainerView]-|" options:0 metrics:nil views:views]];
    
    self.accessoryViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.accessoryContainerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self.contentView addConstraint:self.accessoryViewWidthConstraint];
    
    [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
    [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
     [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.detailTextLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
}


- (void) applyDefaults {
    self.imageView.backgroundColor = [UIColor grayColor];
    self.imageView.layer.cornerRadius = 3.0f;
    self.imageView.clipsToBounds = YES;
}


#pragma mark - Getter and Setters

//- (void) setText:(NSString *)text {
//    _text = text;
//    self.textLabel.text = text;
//    [self.textLabel sizeToFit];
//    [self setNeedsUpdateConstraints];
//}
//
//- (void) setDetailText:(NSString *)detailText {
//    _detailText = detailText;
//    self.detailTextLabel.text = detailText;
//    [self.detailTextLabel sizeToFit];
//    [self setNeedsUpdateConstraints];
//}


- (void) setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
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
    
    
    if (!self.maskLayer) {
        self.maskLayer = [CAShapeLayer new];
    }
    
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithOvalInRect:self.imageView.bounds];
    self.maskLayer.frame = self.imageView.bounds;
    self.maskLayer.path = maskPath.CGPath;
    self.imageView.layer.mask = self.maskLayer;
    
    self.bottomHairlineLayer.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 0.5);
}


@end
