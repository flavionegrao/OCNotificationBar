//
//  OCNotificationBar.m
//  OCNotificationBar
//
//  Created by Flavio Negrão Torres on 11/20/15.
//  Copyright © 2015 Apetis. All rights reserved.
//

#import "OCNotificationBar.h"

@interface OCNotificationBar()
@property (nonatomic, weak) UIView* contentView;
@property (nonatomic, weak) UILabel* textLabel;
@property (nonatomic, weak) UIImageView* imageView;
@property (nonatomic, weak) UIView* progressViewBackground;
@property (nonatomic, weak) UIView* progressView;
@property (nonatomic, weak) UIView* accessoryContainerView;
@property (nonatomic, strong) NSLayoutConstraint* progressViewWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint* accessoryViewWidthConstraint;
@property (nonatomic, weak) CALayer* bottomHairlineLayer;
@end

@implementation OCNotificationBar

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
    UIView* progressViewBackground = [[UIView alloc]initWithFrame:CGRectZero];
    UIView* progressView= [[UIView alloc]initWithFrame:CGRectZero];
    UIView* accessoryContainerView = [[UIView alloc]initWithFrame:CGRectZero];
    
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    progressViewBackground.translatesAutoresizingMaskIntoConstraints = NO;
    progressView.translatesAutoresizingMaskIntoConstraints = NO;
    accessoryContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [contentView addSubview:imageView];
    [contentView addSubview:textLabel];
    [contentView addSubview:progressViewBackground];
    [contentView addSubview:progressView];
    [contentView addSubview:accessoryContainerView];
    [self addSubview:contentView];
    
    self.imageView = imageView;
    self.textLabel = textLabel;
    self.progressViewBackground = progressViewBackground;
    self.progressView = progressView;
    self.accessoryContainerView = accessoryContainerView;
    self.contentView = contentView;

}


- (void) configAutoLayoutConstraints {
    
    NSDictionary* views = @{@"imageView":self.imageView,
                            @"labelView":self.textLabel,
                            @"progressViewBackground":self.progressViewBackground,
                            @"progressView":self.progressView,
                            @"contentView":self.contentView,
                            @"accessoryContainerView":self.accessoryContainerView};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[contentView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[imageView]-[labelView]-[accessoryContainerView]-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[imageView]-[progressViewBackground]-[accessoryContainerView]-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[imageView]-[progressView]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[labelView]-[progressViewBackground]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[labelView]-[progressView]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[accessoryContainerView]-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.progressViewBackground attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10]];
    
    self.accessoryViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.accessoryContainerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self.contentView addConstraint:self.accessoryViewWidthConstraint];
    
    self.progressViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.progressView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self.progressView addConstraint:self.progressViewWidthConstraint];
    
    [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:44]];
    [self.imageView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
}


- (void) applyDefaults {
    self.imageView.backgroundColor = [UIColor grayColor];
    self.imageView.layer.cornerRadius = 3.0f;
    self.imageView.clipsToBounds = YES;
    
    self.progressBarColor = [UIColor colorWithRed:0.24 green:0.73 blue:0.57 alpha:1];
    self.progressBarBackgroundColor = [UIColor grayColor];
    
    self.progressViewBackground.layer.cornerRadius = 5.0f;
    self.progressView.layer.cornerRadius = 5.0f;
}


#pragma mark - Getter and Setters

- (void) setText:(NSString *)text {
    _text = text;
    self.textLabel.text = text;
    [self.textLabel sizeToFit];
    [self setNeedsUpdateConstraints];
}


- (void) setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
}


- (void) setProgress:(float)progress {
    if (progress <= 0 ) {
        _progress = 0;
        
    } else if (progress >= 1) {
        _progress = 1;
        
    } else {
        _progress = progress;
    }
    self.progressViewWidthConstraint.constant = self.progressViewBackground.frame.size.width * self.progress;
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}


- (void) setProgressBarColor:(UIColor *)progressBarColor {
    _progressBarColor = progressBarColor;
    self.progressView.backgroundColor = progressBarColor;
}


- (void) setProgressBarBackgroundColor:(UIColor *)progressBarBackgroundColor {
    _progressBarBackgroundColor = progressBarBackgroundColor;
    self.progressViewBackground.backgroundColor = progressBarBackgroundColor;
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
        self.accessoryViewWidthConstraint.active = NO;
        accessoryView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.accessoryContainerView addSubview:accessoryView];
        
        NSDictionary* views = @{@"accessoryView":accessoryView};
        [self.accessoryContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[accessoryView]|" options:0 metrics:nil views:views]];
        [self.accessoryContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[accessoryView]|" options:0 metrics:nil views:views]];
        
    } else {
        self.accessoryViewWidthConstraint.active = YES;
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
}

@end
