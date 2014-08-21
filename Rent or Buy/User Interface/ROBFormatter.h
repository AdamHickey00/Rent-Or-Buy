//
//  ROBFormatter.h
//  Rent or Buy
//
//  Created by Carly Messmer on 3/2/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ROBFormatter : NSObject

- (NSString *)stripCurrencySymbol:(UITextField *)textField;
- (NSString *)stripPercentSymbol:(UITextField *)textField;

- (double)getDoubleFromCurrency:(NSString *)text;
- (float)getFloatFromPercent:(NSString *)text;

- (NSString *)formatCurrencyFromValue:(double) currencyValue;
- (NSString *)formatCurrency:(NSString *)text;
- (NSString *)formatPercent:(NSString *)text;

@end
