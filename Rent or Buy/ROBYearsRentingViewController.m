//
//  ROBYearsRentingViewController.m
//  Rent or Buy
//
//  Created by Carly Messmer on 3/8/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import "ROBYearsRentingViewController.h"
#import "ROBCalculationInput.h"
#import "ROBCalculationSet.h"
#import "ROBDetailViewController.h"
#import "ROBCalculation.h"
#import "ROBFormatter.h"

@interface ROBYearsRentingViewController ()

@property (nonatomic, strong) ROBCalculationSet *calculationSet;
@property (nonatomic, strong) ROBFormatter *formatter;

@end

@implementation ROBYearsRentingViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.formatter = [[ROBFormatter alloc] init];
    
    // Initialize calculation sets for number of years renting
    self.calculationSet = [[ROBCalculationSet alloc] initWithCalculation:self.calculationInput];
    
    // Toggle segmented control visibility
    [self toggleViewVisibility];
    
}

#pragma table view methods
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.calculationSet.calculations allKeys] count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"YearsRentingCell";

    ROBYearsRentingTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   
    // Get calculation set associated with year renting
    ROBCalculation *calculation = [self getCalculationFromIndexPath:indexPath];
    
    // Pass the current calculation to the table cell
    cell.yearsRentingLabel.text = calculation.yearsRentingText;
    cell.amountLabel.text = [self.formatter formatCurrency:[NSString stringWithFormat:@"%f", calculation.totalValue]];
    cell.calculation = calculation;
    
    // bold the highest total amount
    double highestAmount = self.calculationSet.HighestTotalAmount;
    double currentTotalAmount = floor(calculation.totalValue);
    
    if (highestAmount == currentTotalAmount){
        cell.amountLabel.font = [UIFont boldSystemFontOfSize:18];
        cell.amountLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"Detail"]) {
        
        // Get current calculation
        NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
        ROBCalculation *calculation = [self getCalculationFromIndexPath:selectedIndexPath];
        
        // Pass through selected calculation set
        ROBDetailViewController *controller = segue.destinationViewController;
        controller.calculation = calculation;
        
    }
    
}

- (void) toggleViewVisibility {

    bool graphSelected = false;
    
    //NSLog(@"selectedSegmentIndex: %d",(int)self.segmentedControl.selectedSegmentIndex);
    
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        graphSelected = true;
        self.tableView.dataSource = nil;
    }
    else {
        self.tableView.dataSource = self;
    }
    
    [self.tableView reloadData];
    [self.graphView setHidden:!graphSelected];
    
}

- (ROBCalculation *) getCalculationFromIndexPath:(NSIndexPath *)indexPath {
    
    // Get the calculation set from the index path
    int currentYearRenting = (int)indexPath.row;
    ROBCalculation *calculation = [self.calculationSet GetCalculationForRentingYear:currentYearRenting];
    
    return calculation;
    
}

- (IBAction)segmentedControlValueChanged:(id)sender {
    [self toggleViewVisibility];
}

@end
