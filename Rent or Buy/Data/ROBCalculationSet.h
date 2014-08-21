//
//  ROBCalculationSet.h
//  Rent or Buy
//
//  Created by Carly Messmer on 3/8/14.
//  Copyright (c) 2014 Adam Hickey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ROBCalculationInput.h"
#import "ROBCalculation.h"

@interface ROBCalculationSet : NSObject

- (id)initWithCalculation:(ROBCalculationInput *)calculationInput;
@property (nonatomic, retain) NSMutableDictionary *calculations;

- (ROBCalculation *) GetCalculationForRentingYear:(int) yearRenting;

@end
