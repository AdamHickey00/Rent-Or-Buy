//
//  ROBResultsViewController.m
//  Rent or Buy
//
//  Created by Adam Hickey on 10/12/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import "ROBResultsViewController.h"
#import "ROBGraphViewController.h"
#import "ROBCalculationSet.h"

@interface ROBResultsViewController ()

@end

@implementation ROBResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set image based on highest total amount
    ROBCalculationSet *set = [[ROBCalculationSet alloc] initWithCalculation:self.calculationInput];
    int highestRentalYear = set.HighestTotalAmountYear;
    
    // first hide all images
    self.buyImage.hidden = true;
    self.neutralImage.hidden = true;
    self.rentImage.hidden = true;
    
    // unhide image based on optimal years renting value
    if (highestRentalYear == 0) {
        self.buyImage.hidden = false;
    }
    else if (highestRentalYear > 4) {
        self.rentImage.hidden = false;
    }
    else {
        self.neutralImage.hidden = false;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"YearsRenting"]) {
        
        // Create and pass through the input values to controller
        ROBCalculationInput *calculationInput = self.calculationInput;
        ROBGraphViewController *controller = segue.destinationViewController;
        controller.calculationInput = calculationInput;
        
    }
    
}

@end
