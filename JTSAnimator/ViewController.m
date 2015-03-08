//
//  ViewController.m
//  JTSAnimator
//
//  Created by Joshua Sullivan on 2/26/15.
//  Copyright (c) 2015 Joshua Sullivan. All rights reserved.
//

#import "ViewController.h"
#import "JTSTweener.h"
#import "JTSEaseQuadratic.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTapped:(id)sender
{
    [JTSTweener tweenerWithDuration:4.0
                      startingValue:0.0f
                        endingValue:100.0f
                        easingCurve:[JTSEaseQuadratic easeInOut]
                            options:nil
                      progressBlock:^(JTSTweener *tween, CGFloat value, NSTimeInterval elapsedTime) {
                          self.label.text = [NSString stringWithFormat:@"%i", (int)value];
                      }
                    completionBlock:nil];

}

@end
