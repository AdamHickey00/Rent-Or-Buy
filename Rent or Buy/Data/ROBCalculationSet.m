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

@end
