//
//  ROBResultsViewController.h
//  Rent or Buy
//
//  Created by Adam Hickey on 10/12/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ROBCalculationInput.h"

@interface ROBResultsViewController : UIViewController

@property (nonatomic, strong) ROBCalculationInput *calculationInput;
@property (weak, nonatomic) IBOutlet UIImageView *rentImage;
@property (weak, nonatomic) IBOutlet UIImageView *neutralImage;
@property (weak, nonatomic) IBOutlet UIImageView *buyImage;

@end
