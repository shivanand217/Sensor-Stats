//
//  StatisticsCalculator.h
//  SentianceTest
//
//  Created by Apple on 22/12/20.
//

#if __has_feature(objc_arc)
  #define DLog(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
  #define DLog(format, ...) CFShow([NSString stringWithFormat:format, ## __VA_ARGS__]);
#endif

#import <Foundation/Foundation.h>
#import "SensorStatistics.h"

@interface StatisticsCalculator : NSObject {}

@property (nonatomic, retain) NSString *someProperty;

+ (id)shared;

- (SensorStatistics *)medianOf:(NSMutableArray *)array forType:(NSString *)accType;
- (NSNumber *)meanOf:(NSMutableArray *)array forType:(NSString *)accType;
- (NSNumber *)standardDeviationOf:(NSMutableArray *)array forType:(NSString *)accType;

@end
