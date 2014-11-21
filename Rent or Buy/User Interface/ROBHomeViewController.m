//
//  ROBHomeViewController.m
//  Rent or Buy
//
//  Created by Carly Messmer on 1/26/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import "ROBHomeViewController.h"
#import "ROBFormatter.h"
#import "ROBCalculationInput.h"
#import "ROBResultsViewController.h"

@interface ROBHomeViewController ()

@property (nonatomic, strong) ROBFormatter *formatter;
@property (nonatomic, strong) NSMutableDictionary *tableViewCells;
@property (nonatomic, strong) NSMutableDictionary *tableViewCellsToAnimate;
@property (nonatomic) bool showAdvanced;

@end

@implementation ROBHomeViewController

int const NUMBER_OF_YEARS_RENTING = 10;
int const VISIBLE_CELL_HEIGHT = 44;

int const NUMBER_OF_SECTIONS = 2;
int const NUMBER_OF_ROWS_TOTAL = 12;
int const NUMBER_OF_ROWS_SECTION_0 = 11;
int const NUMBER_OF_ROWS_SECTION_1 = 1;
int const ADVANCED_ROW_INDEX = 10;

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self styleNavigationBar];
    
    self.tableViewCells = [[NSMutableDictionary alloc] init];
    self.tableViewCellsToAnimate = [[NSMutableDictionary alloc] init];
    
    // Initialize table view cells to keep track of hidden cells, visible by default
    for (int i = 0; i < NUMBER_OF_ROWS_TOTAL; i++) {
        [self setVisibleDictionaryKey:self.tableViewCells rowKey:i isVisible:true];
    }
    
    // Hide advanced cells by default
    self.showAdvanced = true;
    [self toggleAdvancedOptions];
    
    // Format default values
    self.formatter = [[ROBFormatter alloc] init];
    
    self.homePrice.text = [self.formatter formatCurrency:self.homePrice.text];
    self.monthlyRent.text = [self.formatter formatCurrency:self.monthlyRent.text];
    self.amountSaved.text = [self.formatter formatCurrency:self.amountSaved.text];
    self.rate.text = [self.formatter formatPercent:self.rate.text];
    
    // Advanced fields
    self.savingsAfterRent.text = [self.formatter formatCurrency:self.savingsAfterRent.text];
    [self.loanTermPickerView selectRow:1 inComponent:0 animated:NO]; // 15 year loan by default
    self.propertyTaxYearly.text = [self.formatter formatCurrency:self.propertyTaxYearly.text];
    self.insuranceMonthly.text = [self.formatter formatCurrency:self.insuranceMonthly.text];
    self.savingsInterestRate.text = [self.formatter formatPercent:self.savingsInterestRate.text];
    self.maintenanceMonthly.text = [self.formatter formatCurrency:self.maintenanceMonthly.text];
    
}

- (void) styleNavigationBar {
    
    // Set navigation text to white
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    // Set navigation color to blue
    UIColor *navigationColor = [UIColor colorWithRed:(76/255.0) green:(166/255.0) blue:(245/255.0) alpha:1]; // dark blue
    self.navigationController.navigationBar.barTintColor = navigationColor;
    self.navigationController.navigationBar.translucent = NO;
    
    // Set info button tint to white
    [self.infoButton setTintColor:[UIColor whiteColor]];
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Hide number pad if any touch is made outside of the pad.
    [self.homePrice resignFirstResponder];
    [self.monthlyRent resignFirstResponder];
    [self.amountSaved resignFirstResponder];
    [self.rate resignFirstResponder];
    
    // Advanced fields
    [self.savingsAfterRent resignFirstResponder];
    [self.propertyTaxYearly resignFirstResponder];
    [self.insuranceMonthly resignFirstResponder];
    [self.savingsInterestRate resignFirstResponder];
    [self.maintenanceMonthly resignFirstResponder];
    
}

#pragma text start editing events
- (IBAction) homePriceStartEditing:(UITextField *)textField {
    textField.text = [self.formatter stripCurrencySymbol:textField];
}

- (IBAction) monthlyRentStartEditing:(UITextField *)textField {
    textField.text = [self.formatter stripCurrencySymbol:textField];
}

- (IBAction) amountSavedStartEditing:(UITextField *)textField {
    textField.text = [self.formatter stripCurrencySymbol:textField];
}

- (IBAction) rateStartEditing:(UITextField *)textField {
    textField.text = [self.formatter stripPercentSymbol:textField];
}

- (IBAction)savingsPerMonthStartEditing:(UITextField *)textField {
    textField.text = [self.formatter stripCurrencySymbol:textField];
}

- (IBAction)propertyTaxYearlyStartEditing:(UITextField *)textField {
    textField.text = [self.formatter stripCurrencySymbol:textField];
}

- (IBAction)insuranceMonthlyStartEditing:(UITextField *)textField {
    textField.text = [self.formatter stripCurrencySymbol:textField];
}

- (IBAction)savingsInterestRateStartEditing:(UITextField *)textField {
    textField.text = [self.formatter stripPercentSymbol:textField];
}

- (IBAction)maintenanceMonthlyStartEditing:(UITextField *)textField {
    textField.text = [self.formatter stripCurrencySymbol:textField];
}

#pragma text editing end events
- (IBAction) homePriceEditingEnd:(UITextField *)textField {
    textField.text = [self.formatter formatCurrency:textField.text];
}

- (IBAction) monthlyRentEditingEnd:(UITextField *)textField {
    textField.text = [self.formatter formatCurrency:textField.text];
}

- (IBAction) amountSavedEditingEnd:(UITextField *)textField {
    textField.text = [self.formatter formatCurrency:textField.text];
}

- (IBAction) rateEditingEnd:(UITextField *)textField {
    textField.text = [self.formatter formatPercent:textField.text];
}

- (IBAction)savingsPerMonthEditingEnd:(UITextField *)textField {
    textField.text = [self.formatter formatCurrency:textField.text];
}

- (IBAction)propertyTaxYearlyEditingEnd:(UITextField *)textField {
    textField.text = [self.formatter formatCurrency:textField.text];
}

- (IBAction)insuranceMonthlyEditingEnd:(UITextField *)textField {
    textField.text = [self.formatter formatCurrency:textField.text];
}

- (IBAction)savingsInterestEditingEnd:(UITextField *)textField {
    textField.text = [self.formatter formatPercent:textField.text];
}

- (IBAction)maintenanceMonthlyEditingEnd:(UITextField *)textField {
    textField.text = [self.formatter formatCurrency:textField.text];
}

#pragma Slider changed events
- (IBAction) homePriceSliderChanged:(UISlider *)slider {
    [self setFormatFromSlider:true : slider : self.homePrice];
}

- (IBAction) monthlyRentSliderChanged:(UISlider *)slider {
    [self setFormatFromSlider:true : slider : self.monthlyRent];
}

- (IBAction) amountSavedSliderChanged:(UISlider *)slider {
    [self setFormatFromSlider:true : slider : self.amountSaved];
}

- (IBAction) rateSliderChanged:(UISlider *)slider {
    [self setFormatFromSlider:false : slider : self.rate];
}

- (void) setFormatFromSlider:(BOOL)currency :(UISlider *)slider :(UITextField *)textField{
    
    // Convert slider value to text
    NSString *sliderText = [NSString stringWithFormat:@"%f", slider.value];
    NSString *formattedText;
    
    if (currency == true) {
       formattedText = [self.formatter formatCurrency:sliderText];
    }
    else {
        formattedText = [self.formatter formatPercent:sliderText];
    }
    
    // Set associated text field text
    textField.text = formattedText;
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSString *identifier = segue.identifier;
    
    if ([identifier isEqualToString:@"YearsRenting"]) {
        
        // Create and pass through the input values to controller
        ROBCalculationInput *calculationInput = [self getCalculationInput];
        ROBResultsViewController *controller = segue.destinationViewController;
        controller.calculationInput = calculationInput;
        
    }
    
}

- (ROBCalculationInput *) getCalculationInput {
    
    ROBCalculationInput *calculationInput = [ROBCalculationInput alloc];
    
    // Set input values from text fields
    calculationInput.homePrice = [self.formatter getDoubleFromCurrency:self.homePrice.text];
    calculationInput.monthlyRent = [self.formatter getDoubleFromCurrency:self.monthlyRent.text];
    calculationInput.rate = [self.formatter getFloatFromPercent:self.rate.text];
    calculationInput.initialSavedAmount = [self.formatter getDoubleFromCurrency:self.amountSaved.text];
    
    // Advanced fields
    calculationInput.amountSavedPerMonth = [self.formatter getDoubleFromCurrency:self.savingsAfterRent.text];
    
    // Get loan term from picker
    int currentLoanTermRow = (int)[self.loanTermPickerView selectedRowInComponent:0];
    calculationInput.loanTerm = [self getLoanTermForRow:(int)currentLoanTermRow];
    
    calculationInput.propertyTaxYearly = [self.formatter getDoubleFromCurrency:self.propertyTaxYearly.text];
    calculationInput.insuranceMonthly = [self.formatter getDoubleFromCurrency:self.insuranceMonthly.text];
    calculationInput.savingsInterestRate = [self.formatter getFloatFromPercent:self.savingsInterestRate.text];
    calculationInput.maintenanceMonthly = [self.formatter getDoubleFromCurrency:self.maintenanceMonthly.text];
    
    calculationInput.totalYearsRenting = NUMBER_OF_YEARS_RENTING;
    
    return calculationInput;
    
}

- (void) setVisibleDictionaryKey:(NSMutableDictionary *) dictionary rowKey:(int) row isVisible:(BOOL) visible{
    
    // Set visiblity for specified row number
    [dictionary setObject:[NSNumber numberWithBool:visible] forKey:[NSString stringWithFormat:@"%i", row]];
    
}

- (void) toggleAdvancedOptions {
    
    // flip show advanced flag
    self.showAdvanced = !self.showAdvanced;
    
    [self setVisibleDictionaryKey:self.tableViewCells rowKey:4 isVisible:self.showAdvanced];          // loan term
    [self setVisibleDictionaryKey:self.tableViewCellsToAnimate rowKey:4 isVisible:self.showAdvanced]; // loan term
    
    [self setVisibleDictionaryKey:self.tableViewCells rowKey:5 isVisible:self.showAdvanced];          // savings after rent cell
    [self setVisibleDictionaryKey:self.tableViewCellsToAnimate rowKey:5 isVisible:self.showAdvanced]; // savings after rent cell
    
    [self setVisibleDictionaryKey:self.tableViewCells rowKey:6 isVisible:self.showAdvanced];          // property tax cell
    [self setVisibleDictionaryKey:self.tableViewCellsToAnimate rowKey:6 isVisible:self.showAdvanced]; // property tax cell
    
    [self setVisibleDictionaryKey:self.tableViewCells rowKey:7 isVisible:self.showAdvanced];          // insurance cell
    [self setVisibleDictionaryKey:self.tableViewCellsToAnimate rowKey:7 isVisible:self.showAdvanced]; // insurance cell
    
    [self setVisibleDictionaryKey:self.tableViewCells rowKey:8 isVisible:self.showAdvanced];          // savings interest cell
    [self setVisibleDictionaryKey:self.tableViewCellsToAnimate rowKey:8 isVisible:self.showAdvanced]; // savings interest cell
    
    [self setVisibleDictionaryKey:self.tableViewCells rowKey:9 isVisible:self.showAdvanced];          // maintenance cell
    [self setVisibleDictionaryKey:self.tableViewCellsToAnimate rowKey:9 isVisible:self.showAdvanced]; // maintenance cell
    
    [self.simpleLabel setHidden:!self.showAdvanced];
    [self.advancedLabel setHidden:self.showAdvanced];
    
    [self reloadRowsWithAnimation];
    [self.tableView reloadData];
    
}

- (void)reloadRowsWithAnimation {
    
    NSMutableArray* rowsToReload = [[NSMutableArray alloc] init];
    
    // Get list of rows to animate (only rows that have gone from not visible to visible
    for (id key in self.tableViewCellsToAnimate) {

        bool visible = [[self.tableViewCellsToAnimate valueForKey:key] boolValue];
        
        // add row to animation list if it is now visible
        if (visible == true) {
            NSInteger rowNumber = [key integerValue] + 1; // plus 1 because this is a row index and we want row number
            NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:rowNumber inSection:0];
            [rowsToReload addObject:rowToReload];
        }
        
    }
    
    [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationBottom];

}

// Get the number of hidden cells until the next visible cell
- (int) getOffsetForTableRow:(NSInteger) rowIndex {
    
    int offset = 0;
    
    for (int i = (int) rowIndex; i < NUMBER_OF_ROWS_SECTION_0; i++) {
        
        NSString *rowKey = [NSString stringWithFormat:@"%d", i];
        bool visible = [[self.tableViewCells valueForKey:rowKey] boolValue];
        
        if (visible == false) {
           offset++;
        }
        
    }
    
    return offset;
    
}

#pragma Table view methods

// Called to calculate heigh for cell row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    // Set cell height for row
    int row = (int)indexPath.row;
    NSString *rowKey = [NSString stringWithFormat:@"%d", row];
    NSNumber *visibleNumber = [self.tableViewCells valueForKey:rowKey];
    bool visible = [visibleNumber boolValue];
    
    int height;
 
    if (visible == 1) {
        height = VISIBLE_CELL_HEIGHT;
    }
    else {
        height = 0;
    }
    
    return height;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Check if simple/advanced row was selected
    if (indexPath.section == 0) {
        
        if (indexPath.row == ADVANCED_ROW_INDEX) {
            [self toggleAdvancedOptions];
        }
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // return number of visible cells
    if (section == 0) {
        return NUMBER_OF_ROWS_SECTION_0;
    }
    else {
        return NUMBER_OF_ROWS_SECTION_1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     // If row is hidden, then return next row
    NSString *rowKey = [NSString stringWithFormat:@"%d", (int) indexPath.row];
    bool visible = [[self.tableViewCells valueForKey:rowKey] boolValue];
    
    int offset = 0;
    if (visible == false) {
        offset = [self getOffsetForTableRow:indexPath.row];
    }
    
    int pathForRow = (int) indexPath.row + offset;
    
    // View results and view graph are in a different section
    int section = 0;
    if (indexPath.section == 1) {
        pathForRow = (int) indexPath.row;
        section = (int) indexPath.section;
    }
    
    indexPath = [NSIndexPath indexPathForRow:pathForRow inSection:section];
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
}

#pragma Picker View

// Number of columns
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// Number of rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return 4; // 10, 15, 20, 30
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    int item = [self getLoanTermForRow:(int)row];
    
    return [NSString stringWithFormat:@"%d", item];
    
}

-(int) getLoanTermForRow: (int) row {
    
    int item;
    
    if (row == 0) {
        item = 10;
    }
    else if (row == 1) {
        item = 15;
    }
    else if (row == 2) {
        item = 20;
    }
    else {
        item = 30;
    }
    
    return item;
    
}

@end
