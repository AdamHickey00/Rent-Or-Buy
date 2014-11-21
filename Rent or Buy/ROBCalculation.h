//
//  ROBCalculation.h
//  Rent or Buy
//
//  Created by Adam Hickey on 4/13/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROBCalculationInput.h"

@interface ROBCalculation : NSObject

- (id)initWithValue:(int)yearRenting :(ROBCalculationInput *)calculationInput;

@property (nonatomic, assign) int yearsRenting;
@property (nonatomic, assign) NSString *yearsRentingText;
@property (nonatomic, assign) NSString *totalValueText;

// Calculated outputs
@property (nonatomic, assign, getter = getDownPayment) double downPayment;
@property (nonatomic, assign, getter = getMortgage) double mortgage;
@property (nonatomic, assign, getter = getYearsOwning) int yearsOwning;
@property (nonatomic, assign, getter = getLoanPayment) double loanPayment;
@property (nonatomic, assign, getter = getRentPaid) double rentPaid;
@property (nonatomic, assign, getter = getInterestPaid) double interestPaid;
@property (nonatomic, assign, getter = getPmiPaid) double pmiPaid;
@property (nonatomic, assign, getter = getTotalInsurancePaid) double totalInsurancePaid;
@property (nonatomic, assign, getter = getTotalMaintenancePaid) double totalMaintenancePaid;
@property (nonatomic, assign, getter = getTotalPropertyTaxPaid) double totalPropertyTaxPaid;
@property (nonatomic, assign, getter = getTaxWriteoff) double taxWriteoff;
@property (nonatomic, assign, getter = getSavingsDuringLoan) double savingsDuringLoan;
@property (nonatomic, assign, getter = getSavingsAfterLoan) double savingsAfterLoan;

// Todo
@property (nonatomic, assign, getter = getTotalValue) double totalValue;

@end
