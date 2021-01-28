//
//  ViewController.h
//  SentianceTest
//
//  Created by Apple on 21/12/20.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>
#import "SensorStatistics.h"

#if __has_feature(objc_arc)
  #define DLog(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
  #define DLog(format, ...) CFShow([NSString stringWithFormat:format, ## __VA_ARGS__]);
#endif

@interface ViewController : UIViewController

@property (strong, nonatomic, nullable) CMMotionManager * motionManager;
@property (strong, nonatomic, nullable) CLLocationManager * locationManager;

@property(weak, nonatomic, nullable) id<CLLocationManagerDelegate> delegate;

@property(weak, nonatomic, nullable) NSTimer *timer;
@property(weak, nonatomic, nullable) NSTimer *valueUpdateTimer;

@property(nonatomic) NSTimeInterval sensorFrequency;

@property(nonatomic, nullable) SensorStatistics * sensorTempValue;

//max, median, mean, stdev, min, count

@property(nonatomic) NSMutableArray<SensorStatistics *> * _Nullable sensorStats;
@property(nonatomic) NSMutableArray<CLLocation *> * _Nullable gpsCoordinates;

@property(nonatomic) double currAccX;
@property(nonatomic) double currAccY;
@property(nonatomic) double currAccZ;

@property(atomic) double maxX;
@property(atomic) double maxY;
@property(atomic) double maxZ;

@property(atomic) double minX;
@property(atomic) double minY;
@property(atomic) double minZ;

@property(atomic) double medianX;
@property(atomic) double medianY;
@property(atomic) double medianZ;

@property(atomic) double meanX;
@property(atomic) double meanY;
@property(atomic) double meanZ;

@property(atomic) double standardDevX;
@property(atomic) double standardDevY;
@property(atomic) double standardDevZ;

@property(atomic) double countX;
@property(atomic) double countY;
@property(atomic) double countZ;

@property(atomic) int xCrossing;
@property(atomic) int yCrossing;
@property(atomic) int zCrossing;

@property(atomic) NSNumber * _Nullable num1;
@property(atomic) NSNumber * _Nullable num2;
@property(atomic) NSNumber * _Nullable num3;

@property(nonatomic) NSNumber * _Nullable myDoubleX;
@property(nonatomic) NSNumber * _Nullable myDoubleY;
@property(nonatomic) NSNumber * _Nullable myDoubleZ;

@property(nonatomic) NSDate * _Nonnull previousDate;

@end
