//
//  ROBDetailViewController.h
//  Rent or Buy
//
//  Created by Carly Messmer on 3/8/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ROBCalculation.h"

@interface ROBDetailViewController : UITableViewController

@property (nonatomic, assign) ROBCalculation *calculation;

@property (weak, nonatomic) IBOutlet UITableViewCell *yearsRentingCell;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigation;

@property (weak, nonatomic) IBOutlet UILabel *totalValue;
@property (weak, nonatomic) IBOutlet UILabel *downPayment;
@property (weak, nonatomic) IBOutlet UILabel *mortgage;
@property (weak, nonatomic) IBOutlet UILabel *totalYearsOwning;
@property (weak, nonatomic) IBOutlet UILabel *loanPayment;
@property (weak, nonatomic) IBOutlet UILabel *rentPaid;

// todo
@property (weak, nonatomic) IBOutlet UILabel *interestPaid;
@property (weak, nonatomic) IBOutlet UILabel *pmiPaid;
@property (weak, nonatomic) IBOutlet UILabel *totalInsurancePaid;
@property (weak, nonatomic) IBOutlet UILabel *totalMaintenancePaid;
@property (weak, nonatomic) IBOutlet UILabel *totalPropertyTaxPaid;
@property (weak, nonatomic) IBOutlet UILabel *taxWriteoff;
@property (weak, nonatomic) IBOutlet UILabel *savingsDuringLoan;
@property (weak, nonatomic) IBOutlet UILabel *saivngsAfterLoan;

@end
