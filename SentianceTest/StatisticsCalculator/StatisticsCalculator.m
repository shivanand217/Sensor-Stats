//
//  StatisticsCalculator.m
//  SentianceTest
//
//  Created by Apple on 22/12/20.
//

#import "StatisticsCalculator.h"
#import "SensorStatistics.h"
#import <Foundation/Foundation.h>

@implementation StatisticsCalculator : NSObject

@synthesize someProperty;

#pragma mark Singleton Methods

+ (id)shared {
    static StatisticsCalculator *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        someProperty = @"Default Property Value";
    }
    return self;
}

- (SensorStatistics *)medianOf:(NSMutableArray *)array forType:(NSString *)accType {
    if(![array count]) return nil;
    
    NSArray *sortedArray;
    if([accType isEqual:@"X"]){
        sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            double first = [(SensorStatistics*)a accX];
            double second = [(SensorStatistics*)b accX];
            return first > second;
        }];
    } else if([accType isEqual:@"Y"]){
        sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            double first = [(SensorStatistics*)a accY];
            double second = [(SensorStatistics*)b accY];
            return first > second;
        }];
    } else {
        sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            double first = [(SensorStatistics*)a accZ];
            double second = [(SensorStatistics*)b accZ];
            return first > second;
        }];
    }
    
    NSUInteger middle = [sortedArray count] / 2; // index of middle element
    SensorStatistics *median = [sortedArray objectAtIndex:middle];
    
    if([accType isEqual:@"X"]) {
        for(SensorStatistics *item in sortedArray){
            printf("accX is %f\n", item.accX);
        }
        DLog(@"median is %f\n\n\n", [median accX]);
    } else if ([accType isEqual:@"Y"]){
        for(SensorStatistics *item in sortedArray){
            printf("accY is %f\n", item.accY);
        }
        DLog(@"median is %f\n\n\n", [median accY]);
    } else{
        for(SensorStatistics *item in sortedArray){
            printf("accZ is %f\n", item.accZ);
        }
        DLog(@"median is %f\n\n\n", [median accZ]);
    }
    
    return median;
}

- (NSNumber *)meanOf:(NSMutableArray *)array forType:(NSString *)accType {
    if(![array count]) return nil;
    
    double runningTotal = 0.0;
    
    for(SensorStatistics *number in array) {
        if([accType isEqual:@"X"]){
            runningTotal += [number accX];
        } else if([accType isEqual:@"Y"]){
            runningTotal += [number accY];
        } else{
            runningTotal += [number accZ];
        }
    }
    
    return [NSNumber numberWithDouble:(runningTotal / [array count])];
}

- (NSNumber *)standardDeviationOf:(NSMutableArray *)array forType:(NSString *)accType {
    if(![array count]) return nil;
    
    NSNumber *mean;
    
    double meanDouble;
    double valueOfNumber;
    double difference;

    if([accType isEqual:@"X"]){
        mean = [self meanOf:array forType:@"X"];
    } else if([accType isEqual:@"Y"]){
        mean = [self meanOf:array forType:@"Y"];
    } else {
        mean = [self meanOf:array forType:@"Z"];
    }
    
    meanDouble = [mean doubleValue];
    double sumOfSquaredDifferences = 0.0;

    for(SensorStatistics *item in array) {
        if([accType isEqual:@"X"]){
            valueOfNumber = [item accX];
        } else if([accType isEqual:@"Y"]){
            valueOfNumber = [item accY];
        } else {
            valueOfNumber = [item accZ];
        }
        
        difference = valueOfNumber - meanDouble;
        sumOfSquaredDifferences += difference * difference;
    }

    return [NSNumber numberWithDouble:sqrt(sumOfSquaredDifferences / [array count])];
}

@end

