//
//  ROBCalculationSet.m
//  Rent or Buy
//
//  Created by Carly Messmer on 3/8/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import "ROBCalculationSet.h"
#import "ROBCalculationInput.h"
#import "ROBCalculation.h"

@interface ROBCalculationSet ()

@property (nonatomic, retain) ROBCalculationInput *calculationInput;

@end

@implementation ROBCalculationSet

- (id) initWithCalculation:(ROBCalculationInput *)calculationInput {
    
    self = [super init];
    
    self.calculationInput = calculationInput;
    
    // Initialize calculations
    self.calculations = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < self.calculationInput.totalYearsRenting; i++) {
        
        // Year renting, calculation input
        ROBCalculation *calculation = [[ROBCalculation alloc] initWithValue:i :calculationInput];
        [self.calculations setObject:calculation forKey:[NSString stringWithFormat:@"%i", i]];
        
    }
    
    return self;
    
}

- (ROBCalculation *) GetCalculationForRentingYear:(int) yearRenting {
    
    NSString *currentYearRentingKey = [NSString stringWithFormat:@"%d", yearRenting];
    ROBCalculation *calculation = [self.calculations valueForKey:currentYearRentingKey];
    
    return calculation;
    
}

- (int) HighestTotalAmountYear {
    
    // return rental year containing highest total amount
    double highestAmount = [self HighestTotalAmount];
    int rentalYear = 0;
    
    for (int i = 0; i < self.calculationInput.totalYearsRenting; i++) {
        
        ROBCalculation *calculation = [self GetCalculationForRentingYear:i];
        if (floor(highestAmount) == floor(calculation.totalValue)) {
            return rentalYear;
        }
        
        rentalYear += 1;
    }
    
    return rentalYear;
    
}

- (double) HighestTotalAmount {
    
    double highestAmount = 0;
    
    for (id key in self.calculations) {
        
        // return highest total amount in calculation dictionary
        ROBCalculation *input = [self.calculations objectForKey:key];
        if (input.totalValue > highestAmount) {
            highestAmount = input.totalValue;
        }
        
    }

    return floor(highestAmount);
    
}

@end
