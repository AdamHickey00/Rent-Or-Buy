//
//  ROBCalculation.m
//  Rent or Buy
//
//  Created by Adam Hickey on 4/13/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import "ROBCalculation.h"
#import "ROBCalculationInput.h"

@interface ROBCalculation ()

@property (nonatomic, retain) ROBCalculationInput *calculationInput;
@property (nonatomic, assign, getter = getCurrentAmountSaved) double currentAmountSaved;

- (double) getPmiMonths;
- (double) getPmiPayment;

@end

@implementation ROBCalculation

- (id) initWithValue:(int)yearsRenting :(ROBCalculationInput *)calculationInput {
    
    self = [super init];
    
    self.yearsRenting = yearsRenting;
    self.calculationInput = calculationInput;
    
    return self;
    
}

- (double) getTotalAmount {
    
    double value;
    
    value = self.calculationInput.homePrice;
    
    return value;
    
}

// Down payment: Inital amount + Amount saved while renting
- (double) getDownPayment {
    
    double value;
    
    double monthsRenting = self.yearsRenting * 12;
    double amountSavedWhileRenting = monthsRenting * self.calculationInput.amountSavedPerMonth;

    value = self.calculationInput.initialSavedAmount + amountSavedWhileRenting;
    
    return value;
    
}

// Mortgage: Home price - Down payment
- (double) getMortgage {
    
    double value;
    
    value = self.calculationInput.homePrice - self.downPayment;
    
    return value;
    
}

// Mortgage: Loan term + Years renting
- (int) getYearsOwning {
    
    double value;
    
    value = self.calculationInput.totalYearsRenting - self.yearsRenting + self.calculationInput.loanTerm;
    
    return value;
    
}

// Loan * (MonthlyInterest / (1 - (1 + MonthlyInterest) ^ -NumberOfMonths))
- (double) getLoanPayment {
    
    double annualInterestRate = self.calculationInput.rate;
    double monthlyInterest = annualInterestRate / 12;
    NSInteger numberOfPayments = self.calculationInput.loanTerm * 12; // loan term * number of months
    NSInteger negativeNumberOfPayments = numberOfPayments * -1;
    double loan = [self getMortgage];
    
    // (1 + MonthlyInterest)  => temp1
    double temp1 = 1 + monthlyInterest;
    
    // (1 + MonthlyInterest) ^ -NumberOfMonths  => temp2
    double temp2 = pow(temp1, negativeNumberOfPayments);
    
    // 1 - (1 + MonthlyInterest) ^ -NumberOfMonths) => temp3
    double temp3 = 1 - temp2;
    
    // MonthlyInterest / (1 - 1 + MonthlyInterest) ^ -NumberOfMonths) => temp4
    double temp4 = monthlyInterest / temp3;
    
    double value = loan * temp4;
    
    return value;
    
}

- (NSString *) yearsRentingText {
    
    NSString *suffix;
    
    if (self.calculationInput.totalYearsRenting <= 1) {
        suffix = @" year renting";
    }
    else {
        suffix = @" years renting";
    }
    
    NSString *rent = [NSString stringWithFormat:@"%i", self.yearsRenting];
    
    return [NSString stringWithFormat:@"%@%@", rent, suffix];
    
}

- (double) getRentPaid {
    
    double value;
    
    value = self.yearsRenting * self.calculationInput.monthlyRent * 12;
    
    return value;
    
}

// (Loan payment * number of months) - mortgage amount
- (double) getInterestPaid {
    
    double value;
    
    double temp1 = self.loanPayment * self.calculationInput.loanTerm * 12;
    value = temp1 - self.mortgage;
    
    return value;
    
}

// number of months paying pmi * the amount of pmi per month
- (double) getPmiPaid {
    
    double value;
    
    int pmiMonths = self.getPmiMonths;
    double pmiPayment = self.getPmiPayment;
    
    value = (double) pmiMonths * pmiPayment;
    
    return value;
    
}

// number of months until the house is payed off 20 percent
- (double) getPmiMonths {
    
    double pmiPaymentPeriods = 0;
    
    double percentageDown = self.downPayment / self.calculationInput.homePrice;
    double eightyPercentOfHomePrice = .8 * self.calculationInput.homePrice;
    
    // pmi is only applied if less than 20% is put down on the house
    if (percentageDown < .2) {
        
        double currentLoanAmount = self.mortgage;
        double loanPayment = self.loanPayment;
        double monthlyInterestRate = self.calculationInput.rate / 12;
        
        // iterate each loan payment until remaining balance is at 80 percent of original home value
        while (currentLoanAmount > eightyPercentOfHomePrice) {
            
            // simulate paying off loan
            double monthlyInterest = monthlyInterestRate * currentLoanAmount;
            double principalPaid  = loanPayment - monthlyInterest;
            currentLoanAmount = currentLoanAmount - principalPaid;
            pmiPaymentPeriods += 1;
            
        }
    }
    
    return pmiPaymentPeriods;
    
}

// (loan balance * pmi rate) / 12
- (double) getPmiPayment {
    
    double value;
    double mortgagePercentage = self.mortgage / self.calculationInput.homePrice;
    
    if (mortgagePercentage < .8) {
        value = 0;
    }
    else if (mortgagePercentage < .85) {
        value = (.0032 * self.mortgage) / 12;
    }
    else if (mortgagePercentage < .90) {
        value = (.0052 * self.mortgage) / 12;
    }
    else if (mortgagePercentage < .95) {
        value = (.0078 * self.mortgage) / 12;
    }
    else {
        value = (.009 * self.mortgage) / 12;
    }
    
    return value;
    
}

- (double) getTotalInsurancePaid {
    
    double value;
    
    value = self.calculationInput.insuranceMonthly * 12 * self.yearsOwning;
    
    return value;
    
}

- (double) getTotalMaintenancePaid {
    
    double value;
    
    value = self.calculationInput.maintenanceMonthly * 12 * self.yearsOwning;
    
    return value;
    
}

- (double) getTotalPropertyTaxPaid {
    
    double value;
    
    value = self.calculationInput.propertyTaxYearly * self.yearsOwning;
    
    return value;
    
}

- (double) getTaxWriteoff {
    
    double value;
    
    value = self.interestPaid * .3;
    
    return value;
    
}

// Pmt * (((1 + i)^n) - 1)/i
// Pmt = payment per month
// i = monthly interest rate
// n = number of months
- (double) getSavingsDuringLoan {

    double pmt = self.calculationInput.amountSavedPerMonth + self.calculationInput.monthlyRent - self.loanPayment;
    double i = self.calculationInput.savingsInterestRate / 12;
    double n = self.calculationInput.loanTerm * 12;
    
    double value = [self getFutureValue:pmt :i :n];
    
    return value;
    
}

// PV((1 + i))^n + Pmt * (((1 + i)^n) - 1)/i
// PV = present value
// Pmt = payment per month
// i = monthly interest rate
// n = number of months
- (double) getSavingsAfterLoan {
    
    double pmt = self.calculationInput.monthlyRent + self.calculationInput.amountSavedPerMonth;
    double pv = self.getSavingsDuringLoan;
    double i = self.calculationInput.savingsInterestRate / 12;
    double n = (self.yearsOwning - self.calculationInput.loanTerm) * 12;
    
    double presentValue = [self getPresentValue:pv :i :n];
    double futureValue = [self getFutureValue:pmt :i :n];
    
    double value;
    
    value = presentValue + futureValue;
    
    return value;
    
}

// Pmt * (((1 + i)^n) - 1)/i
// Pmt = payment per month
// i = monthly interest rate
// n = number of months
- (double) getFutureValue:(double)pmt :(double)i :(double)n {
    
    double value;
    
    // ((1 + i)^n) - 1
    double temp1 = pow(1 + i, n) - 1;
    
    // (((1 + i)^n) - 1)/i
    double temp2 = temp1 / i;
    
    value = temp2 * pmt;
    
    if (value < 0) {
        value = 0;
    }
    
    return value;
    
    return value;
    
}

// P(1 + i * n)
// p = beginning value
// i = monthly interest rate
// n = number of months
- (double) getPresentValue:(double)p :(double)i :(double)n {
    
    // (1 + i * n)
    double temp1 = 1 + i * n;;
    
    // P(1 + i * n)
    double value = p * temp1;
    
    if (value < 0) {
        value = 0;
    }
    
    return value;
    
}

// todo
- (double) getTotalValue {
    
    double value;
    
    value = 0;
    
    return value;
    
}

@end
