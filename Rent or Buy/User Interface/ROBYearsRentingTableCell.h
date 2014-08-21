//
//  ROBYearsRentingTableCell.h
//  Rent or Buy
//
//  Created by Carly Messmer on 3/8/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ROBCalculationInput.h"
#import "ROBCalculation.h"

@interface ROBYearsRentingTableCell : UITableViewCell

@property (nonatomic, assign) ROBCalculation *calculation;

@property (weak, nonatomic) IBOutlet UILabel *yearsRentingLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end
