//
//  ROBHomeViewController.h
//  Rent or Buy
//
//  Created by Carly Messmer on 1/26/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ROBHomeViewController : UITableViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

// Simple fields
@property (weak, nonatomic) IBOutlet UITextField *homePrice;
@property (weak, nonatomic) IBOutlet UITextField *monthlyRent;
@property (weak, nonatomic) IBOutlet UITextField *amountSaved;
@property (weak, nonatomic) IBOutlet UITextField *rate;

@property (weak, nonatomic) IBOutlet UISlider *homePriceScroller;
@property (weak, nonatomic) IBOutlet UISlider *monthlyRentScroller;
@property (weak, nonatomic) IBOutlet UISlider *amountSavedScroller;
@property (weak, nonatomic) IBOutlet UISlider *rateScroller;

- (IBAction)homePriceStartEditing:(UITextField *)sender;
- (IBAction)monthlyRentStartEditing:(UITextField *)sender;
- (IBAction)amountSavedStartEditing:(UITextField *)sender;
- (IBAction)rateStartEditing:(UITextField *)sender;

- (IBAction)homePriceEditingEnd:(UITextField *)sender;
- (IBAction)monthlyRentEditingEnd:(UITextField *)sender;
- (IBAction)amountSavedEditingEnd:(UITextField *)sender;
- (IBAction)rateEditingEnd:(UITextField *)sender;

- (IBAction)homePriceSliderChanged:(UISlider *)sender;
- (IBAction)monthlyRentSliderChanged:(UISlider *)sender;
- (IBAction)amountSavedSliderChanged:(UISlider *)sender;
- (IBAction)rateSliderChanged:(UISlider *)sender;

// Advanced fields
@property (weak, nonatomic) IBOutlet UITextField *savingsAfterRent;
@property (weak, nonatomic) IBOutlet UIPickerView *loanTermPickerView;
@property (weak, nonatomic) IBOutlet UITextField *propertyTaxYearly;
@property (weak, nonatomic) IBOutlet UITextField *insuranceMonthly;
@property (weak, nonatomic) IBOutlet UITextField *savingsInterestRate;
@property (weak, nonatomic) IBOutlet UITextField *maintenanceMonthly;

- (IBAction)savingsPerMonthStartEditing:(UITextField *)sender;
- (IBAction)propertyTaxYearlyStartEditing:(UITextField *)sender;
- (IBAction)insuranceMonthlyStartEditing:(UITextField *)sender;
- (IBAction)savingsInterestRateStartEditing:(UITextField *)sender;
- (IBAction)maintenanceMonthlyStartEditing:(UITextField *)sender;

- (IBAction)savingsPerMonthEditingEnd:(UITextField *)sender;
- (IBAction)propertyTaxYearlyEditingEnd:(UITextField *)sender;
- (IBAction)insuranceMonthlyEditingEnd:(UITextField *)sender;
- (IBAction)savingsInterestEditingEnd:(UITextField *)sender;
- (IBAction)maintenanceMonthlyEditingEnd:(UITextField *)sender;

// Advanced cells
@property (weak, nonatomic) IBOutlet UIView *savingsAfterRentCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *propertyTaxCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *insuranceCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *savingsInterestCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *maintenanceCell;

@property (weak, nonatomic) IBOutlet UILabel *simpleLabel;
@property (weak, nonatomic) IBOutlet UILabel *advancedLabel;

@end
