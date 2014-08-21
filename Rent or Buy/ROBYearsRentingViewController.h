//
//  ROBYearsRentingViewController.h
//  Rent or Buy
//
//  Created by Carly Messmer on 3/8/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ROBYearsRentingTableCell.h"

@interface ROBYearsRentingViewController : UITableViewController

@property (nonatomic, strong) ROBCalculationInput *calculationInput;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *graphView;

- (IBAction)segmentedControlValueChanged:(id)sender;

@end
