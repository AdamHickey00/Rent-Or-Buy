//
//  ROBFormatter.m
//  Rent or Buy
//
//  Created by Carly Messmer on 3/2/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import "ROBFormatter.h"

@interface ROBFormatter ()

@property (nonatomic, strong) NSNumberFormatter *currencyFormatter;
@property (nonatomic, strong) NSNumberFormatter *percentFormatter;

-(void) initializeCurrencyFormatter;
-(void) initializePercentFormatter;

@end

@implementation ROBFormatter

-(id) init {
    
    [self initializeCurrencyFormatter];
    [self initializePercentFormatter];
    
    return self;
    
}

-(void) initializeCurrencyFormatter {
    
    _currencyFormatter = [[NSNumberFormatter alloc] init];
    
    [_currencyFormatter setLocale:[NSLocale currentLocale]];
    [_currencyFormatter setMaximumFractionDigits:0];
    [_currencyFormatter setMinimumFractionDigits:0];
    [_currencyFormatter setAlwaysShowsDecimalSeparator:NO];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
}

-(void) initializePercentFormatter {
    
    _percentFormatter = [[NSNumberFormatter alloc] init];
    
    [_percentFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    [_percentFormatter setMinimumFractionDigits:3];
    [_percentFormatter setMaximumFractionDigits:3];
    
}

-(NSString *)stripCurrencySymbol:(UITextField *)textField {
    
    // Get the double value from the currency
    double textFieldDouble = [self getDoubleFromCurrency:textField.text];
    
    // Convert double back to string
    NSString *numberString = [NSString stringWithFormat:@"%g", textFieldDouble];
    
    return numberString;
    
}

-(NSString *)formatCurrencyFromValue:(double) currencyValue {
    
    NSString *text = [NSString stringWithFormat:@"%f", currencyValue];
    
    return [self formatCurrency:text];
    
}

-(NSString *)formatCurrency:(NSString *)text {
    
    // Get the number from the text field
    double textFieldDouble = [text doubleValue];
    NSNumber *price = [NSNumber numberWithDouble:textFieldDouble];
    
    // Format to string as currency
    NSString *formattedValue = [_currencyFormatter stringFromNumber:price];
    
    return formattedValue;
    
}

-(NSString *)stripPercentSymbol:(UITextField *)textField {
    
    // Get the float value from the percent
    double textFieldFloat = [self getFloatFromPercent:textField.text];
    
    // Multiply by 100 because the formatter divides by 100 for percents when going from percent to number
    textFieldFloat = textFieldFloat * 100;
    
    // Convert float back to string
    NSString *numberString = [NSString stringWithFormat:@"%g", textFieldFloat];
    
    return numberString;
    
}

-(NSString *)formatPercent:(NSString *)text {
    
    NSNumber *number = [NSNumber numberWithFloat:[text floatValue]];
    
    // Divide by 100 because the formatter multiplies by 100 for percents
    number = [NSNumber numberWithFloat:[number floatValue] / 100];
    
    // Format to decimal
    NSString *formattedValue = [_percentFormatter stringFromNumber:number];
    
    return formattedValue;
    
}

-(float)getFloatFromPercent:(NSString *)text {
    return [[_percentFormatter numberFromString:text] floatValue];
}

-(double)getDoubleFromCurrency:(NSString *)text {
    return [[_currencyFormatter numberFromString:text] doubleValue];
}

@end
