//
//  ViewController.m
//  OCNotificationBar
//
//  Created by Flavio Negrão Torres on 11/20/15.
//  Copyright © 2015 Apetis. All rights reserved.
//

#import "ViewController.h"
#import "OCProgressNotificationBar.h"
#import "OCLocalNotificationBar.h"

@interface ViewController ()

@property (nonatomic, strong) OCProgressNotificationBar* progressNotificationBar;
@property (nonatomic, strong) OCLocalNotificationBar* localNotificationBar;
@property (nonatomic,assign) float originalTableViewOffset;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.originalTableViewOffset = self.tableView.contentOffset.y;
}


- (OCProgressNotificationBar*) progressNotificationBar {
    if (!_progressNotificationBar) {
        _progressNotificationBar = [[OCProgressNotificationBar alloc]initWithFrame:CGRectZero];
        _progressNotificationBar.alpha = 0;
        
        _progressNotificationBar.text = @"Uploading your file...";
        _progressNotificationBar.textColor = [UIColor blueColor];
        _progressNotificationBar.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        _progressNotificationBar.image = [UIImage imageNamed:@"sample_image"];
        _progressNotificationBar.bottomHairlineColor = [UIColor blueColor];
    }
    return _progressNotificationBar;
}

- (OCLocalNotificationBar*) localNotificationBar {
    if (!_localNotificationBar) {
        _localNotificationBar = [[OCLocalNotificationBar alloc]initWithFrame:CGRectZero];
        _localNotificationBar.alpha = 0;
        
        _localNotificationBar.textLabel.text = @"Main Text";
        _localNotificationBar.textLabel.font = [UIFont boldSystemFontOfSize:12];
        _localNotificationBar.detailTextLabel.text = @"Detail Text";
        _localNotificationBar.detailTextLabel.font = [UIFont systemFontOfSize:12];
        _localNotificationBar.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        _localNotificationBar.image = [UIImage imageNamed:@"sample_image"];
        _localNotificationBar.bottomHairlineColor = [UIColor blueColor];
    }
    return _localNotificationBar;
}


- (IBAction)didTouchShowProgressNotificationBar:(id)sender {
    CGRect frame = self.tableView.bounds;
    frame.size.height = 60;
    self.progressNotificationBar.frame = frame;
    
    [self.tableView addSubview:self.progressNotificationBar];
    [UIView animateWithDuration:0.5 animations:^{
        [self adjustNotificationBarFrame];
        self.progressNotificationBar.alpha = 1;
    }];
}


- (IBAction)didTouchShowLocalNotificationBar:(id)sender {
    CGRect frame = self.tableView.bounds;
    frame.size.height = 60;
    self.localNotificationBar.frame = frame;
    
    [self.tableView addSubview:self.localNotificationBar];
    [UIView animateWithDuration:0.5 animations:^{
        [self adjustNotificationBarFrame];
        self.localNotificationBar.alpha = 1;
    }];
}


- (IBAction)didTouchHideNotificationBar:(id)sender {
    UIView* notificationBar;
    
    if ([self.tableView.subviews containsObject:self.progressNotificationBar]) {
        notificationBar = self.progressNotificationBar;
        
    } else if ([self.tableView.subviews containsObject:self.localNotificationBar]) {
        notificationBar = self.localNotificationBar;
    }
    
    
    CGRect frame = notificationBar.frame;
    frame.origin.y = self.tableView.contentOffset.y + self.originalTableViewOffset;
    [UIView animateWithDuration:0.5 animations:^{
        notificationBar.frame = frame;
        notificationBar.alpha = 0;
    } completion:^(BOOL finished) {
        [notificationBar removeFromSuperview];
    }];
}


- (IBAction)didTouchMoreProgress:(id)sender {
    self.progressNotificationBar.progress += 0.05f;
}


- (IBAction)didTouchLessProgress:(id)sender {
    self.progressNotificationBar.progress -= 0.05f;
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [self adjustNotificationBarFrame];
    [self.view bringSubviewToFront:self.progressNotificationBar];
    [self.view bringSubviewToFront:self.localNotificationBar];
}


- (void) adjustNotificationBarFrame {
    CGRect frame = self.tableView.bounds;
    frame.size.height = 60;
    frame.origin.y -= self.originalTableViewOffset;
    self.progressNotificationBar.frame = frame;
    self.localNotificationBar.frame = frame;
}


- (IBAction)showAccessory:(id)sender {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    [button sizeToFit];
    self.progressNotificationBar.accessoryView = button;
    self.localNotificationBar.accessoryView = button;
}


- (IBAction)hideAccessory:(id)sender {
    self.progressNotificationBar.accessoryView = nil;
    self.localNotificationBar.accessoryView = nil;
}
@end
