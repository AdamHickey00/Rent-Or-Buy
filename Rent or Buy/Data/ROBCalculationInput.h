//
//  ROBCalculationInput.h
//  Rent or Buy
//
//  Created by Carly Messmer on 3/6/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ROBCalculationInput : NSObject

@property (nonatomic, assign) int totalYearsRenting;

@property (nonatomic, assign) double homePrice;
@property (nonatomic, assign) double monthlyRent;
@property (nonatomic, assign) double initialSavedAmount;
@property (nonatomic, assign) double rate;
@property (nonatomic, assign) double amountSavedPerMonth;
@property (nonatomic, assign) int loanTerm;
@property (nonatomic, assign) double propertyTaxYearly;
@property (nonatomic, assign) double insuranceMonthly;
@property (nonatomic, assign) double savingsInterestRate;
@property (nonatomic, assign) double maintenanceMonthly;

@end
