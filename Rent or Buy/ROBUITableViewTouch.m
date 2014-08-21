//
//  ROBUITableViewTouch.m
//  Rent or Buy
//
//  Created by Adam Hickey on 3/29/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import "ROBUITableViewTouch.h"

@implementation ROBUITableViewTouch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
