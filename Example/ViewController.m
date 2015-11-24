//
//  ViewController.m
//  OCNotificationBar
//
//  Created by Flavio Negrão Torres on 11/20/15.
//  Copyright © 2015 Apetis. All rights reserved.
//

#import "ViewController.h"
#import "OCNotificationBar.h"

@interface ViewController ()

@property (nonatomic, strong) OCNotificationBar* notificationBar;
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

- (OCNotificationBar*) notificationBar {
    if (!_notificationBar) {
        _notificationBar = [[OCNotificationBar alloc]initWithFrame:CGRectZero];
        _notificationBar.backgroundColor = [UIColor greenColor];
        _notificationBar.alpha = 0;
        
        _notificationBar.text = @"Uploading your file...";
        _notificationBar.textColor = [UIColor blueColor];
        _notificationBar.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        _notificationBar.image = [UIImage imageNamed:@"sample_image"];
        _notificationBar.bottomHairlineColor = [UIColor blueColor];
    }
    return _notificationBar;
}


- (IBAction)didTouchShowNotificationBar:(id)sender {
    CGRect frame = self.tableView.bounds;
    frame.size.height = 60;
    self.notificationBar.frame = frame;
    
    [self.tableView addSubview:self.notificationBar];
    [UIView animateWithDuration:0.5 animations:^{
        [self adjustNotificationBarFrame];
        self.notificationBar.alpha = 1;
    }];
}


- (IBAction)didTouchHideNotificationBar:(id)sender {
    if ([self.tableView.subviews containsObject:self.notificationBar]) {
        CGRect frame = self.notificationBar.frame;
        frame.origin.y = self.tableView.contentOffset.y + self.originalTableViewOffset;
        [UIView animateWithDuration:0.5 animations:^{
            self.notificationBar.frame = frame;
            self.notificationBar.alpha = 0;
        } completion:^(BOOL finished) {
            [self.notificationBar removeFromSuperview];
        }];
    }
}


- (IBAction)didTouchMoreProgress:(id)sender {
    self.notificationBar.progress += 0.05f;
}

- (IBAction)didTouchLessProgress:(id)sender {
    self.notificationBar.progress -= 0.05f;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [self adjustNotificationBarFrame];
    [self.view bringSubviewToFront:self.notificationBar];
}


- (void) adjustNotificationBarFrame {
    CGRect frame = self.tableView.bounds;
    frame.size.height = 60;
    frame.origin.y -= self.originalTableViewOffset;
    self.notificationBar.frame = frame;
}

- (IBAction)showAccessory:(id)sender {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    [button sizeToFit];
    self.notificationBar.accessoryView = button;
}


- (IBAction)hideAccessory:(id)sender {
    self.notificationBar.accessoryView = nil;
}
@end
