//
//  SensorStatistics.m
//  SentianceTest
//
//  Created by Apple on 22/12/20.
//

#import <Foundation/Foundation.h>
#import "SensorStatistics.h"
#import "StatisticsCalculator.h"

@interface SensorStatistics ()

@end

@implementation SensorStatistics

- (instancetype)initWithAccelerationX:(double)accX AccelerationY:(double)accY AccelerationZ:(double)accZ {
    self = [super init];
    
    if(self) {
        self.accX = accX;
        self.accY = accY;
        self.accZ = accZ;
    }
    
    return self;
}

@end
