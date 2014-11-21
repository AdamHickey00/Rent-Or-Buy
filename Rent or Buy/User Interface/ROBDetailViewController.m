//
//  ROBDetailViewController.m
//  Rent or Buy
//
//  Created by Carly Messmer on 3/8/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import "ROBDetailViewController.h"
#import "ROBFormatter.h"

@implementation ROBDetailViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];

    ROBFormatter *formatter = [[ROBFormatter alloc] init];
    
    self.navigation.title = @"Detail";
    self.yearsRentingCell.textLabel.text = self.calculation.yearsRentingText;
    self.totalValueText.text = self.calculation.totalValueText;
    
    // Fill in calculation details
    self.downPayment.text = [formatter formatCurrencyFromValue:self.calculation.downPayment];
    self.mortgage.text = [formatter formatCurrencyFromValue:self.calculation.mortgage];
    self.totalYearsOwning.text = [NSString stringWithFormat:@"%u", self.calculation.yearsOwning];
    self.loanPayment.text = [formatter formatCurrencyFromValue:self.calculation.loanPayment];
    self.rentPaid.text = [formatter formatCurrencyFromValue:self.calculation.rentPaid];
    self.interestPaid.text = [formatter formatCurrencyFromValue:self.calculation.interestPaid];
    self.pmiPaid.text = [formatter formatCurrencyFromValue:self.calculation.pmiPaid];
    self.totalInsurancePaid.text = [formatter formatCurrencyFromValue:self.calculation.totalInsurancePaid];
    self.totalMaintenancePaid.text = [formatter formatCurrencyFromValue:self.calculation.totalMaintenancePaid];
    self.totalPropertyTaxPaid.text = [formatter formatCurrencyFromValue:self.calculation.totalPropertyTaxPaid];
    self.taxWriteoff.text = [formatter formatCurrencyFromValue:self.calculation.taxWriteoff];
    self.savingsDuringLoan.text = [formatter formatCurrencyFromValue:self.calculation.savingsDuringLoan];
    self.saivngsAfterLoan.text = [formatter formatCurrencyFromValue:self.calculation.savingsAfterLoan];
    self.totalValue.text = [formatter formatCurrencyFromValue:self.calculation.totalValue];
    
}

@end
