//
//  SensorStatistics.h
//  SentianceTest
//
//  Created by Apple on 22/12/20.
//

#ifndef SensorStatistics_h
#define SensorStatistics_h


#endif /* SensorStatistics_h */

@interface SensorStatistics : NSObject

@property (nonatomic) double accX;
@property (nonatomic) double accY;
@property (nonatomic) double accZ;

- (instancetype)initWithAccelerationX:(double)accX
                            AccelerationY:(double)accY
                            AccelerationZ:(double)accZ;

@end
