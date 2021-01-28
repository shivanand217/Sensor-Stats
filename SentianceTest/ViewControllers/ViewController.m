//
//  ViewController.m
//  SentianceTest
//
//  Created by Apple on 21/12/20.
//

#import "ViewController.h"
#import "SensorStatistics.h"
#import "StatisticsCalculator.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *maxAccX;
@property (weak, nonatomic) IBOutlet UILabel *maxAccY;
@property (weak, nonatomic) IBOutlet UILabel *maxAccZ;

@property (weak, nonatomic) IBOutlet UILabel *currAccXLbl;
@property (weak, nonatomic) IBOutlet UILabel *currAccYLbl;
@property (weak, nonatomic) IBOutlet UILabel *currAccZLbl;

@property (weak, nonatomic) IBOutlet UILabel *medianAccX;
@property (weak, nonatomic) IBOutlet UILabel *medianAccY;
@property (weak, nonatomic) IBOutlet UILabel *medianAccZ;

@property (weak, nonatomic) IBOutlet UILabel *meanAccX;
@property (weak, nonatomic) IBOutlet UILabel *meanAccY;
@property (weak, nonatomic) IBOutlet UILabel *meanAccZ;

@property (weak, nonatomic) IBOutlet UILabel *minAccX;
@property (weak, nonatomic) IBOutlet UILabel *minAccY;
@property (weak, nonatomic) IBOutlet UILabel *minAccZ;

@property (weak, nonatomic) IBOutlet UILabel *stDeviationX;
@property (weak, nonatomic) IBOutlet UILabel *stDeviationY;
@property (weak, nonatomic) IBOutlet UILabel *stDeviationZ;

@property (weak, nonatomic) IBOutlet UILabel *zeroCrossingX;
@property (weak, nonatomic) IBOutlet UILabel *zeroCrossingY;
@property (weak, nonatomic) IBOutlet UILabel *zeroCrossingZ;

@property (weak, nonatomic) IBOutlet UILabel *totalValuesCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *distanceTravelledLbl;

@end

@implementation ViewController

- (IBAction)getMaxAction:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.myDoubleX = [NSNumber numberWithDouble:self.maxX];
        self.myDoubleY = [NSNumber numberWithDouble:self.maxY];
        self.myDoubleZ = [NSNumber numberWithDouble:self.maxZ];
        
        self.maxAccX.text = [self.myDoubleX stringValue];
        self.maxAccY.text = [self.myDoubleY stringValue];
        self.maxAccZ.text = [self.myDoubleZ stringValue];
    });
}

- (IBAction)getMinActino:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.myDoubleX = [NSNumber numberWithDouble:self.minX];
        self.myDoubleY = [NSNumber numberWithDouble:self.minY];
        self.myDoubleZ = [NSNumber numberWithDouble:self.minZ];
        
        self.minAccX.text = [self.myDoubleX stringValue];
        self.minAccY.text = [self.myDoubleY stringValue];
        self.minAccZ.text = [self.myDoubleZ stringValue];
    });
}

- (IBAction)getMedianAction:(id)sender {
    
    SensorStatistics *medianX = [[StatisticsCalculator shared] medianOf:self.sensorStats forType:@"X"];
    SensorStatistics *medianY = [[StatisticsCalculator shared] medianOf:self.sensorStats forType:@"Y"];
    SensorStatistics *medianZ = [[StatisticsCalculator shared] medianOf:self.sensorStats forType:@"Z"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myDoubleX = [NSNumber numberWithDouble:medianX.accX];
        self.myDoubleY = [NSNumber numberWithDouble:medianY.accY];
        self.myDoubleZ = [NSNumber numberWithDouble:medianZ.accZ];
        
        self.medianAccX.text = [self.myDoubleX stringValue];
        self.medianAccY.text = [self.myDoubleY stringValue];
        self.medianAccZ.text = [self.myDoubleZ stringValue];
    });
}

- (IBAction)getMeanAction:(id)sender {
    
    NSNumber *meanAccx = [[StatisticsCalculator shared] meanOf:self.sensorStats forType:@"X"];
    NSNumber *meanAccy = [[StatisticsCalculator shared] meanOf:self.sensorStats forType:@"Y"];
    NSNumber *meanAccz = [[StatisticsCalculator shared] meanOf:self.sensorStats forType:@"Z"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.meanAccX.text = [meanAccx stringValue];
        self.meanAccY.text = [meanAccy stringValue];
        self.meanAccZ.text = [meanAccz stringValue];
    });
}

- (IBAction)getStDevAction:(id)sender {
    
    NSNumber *stDevx = [[StatisticsCalculator shared] standardDeviationOf:self.sensorStats forType:@"X"];
    NSNumber *stDevy = [[StatisticsCalculator shared] standardDeviationOf:self.sensorStats forType:@"Y"];
    NSNumber *stDevz = [[StatisticsCalculator shared] standardDeviationOf:self.sensorStats forType:@"Z"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.stDeviationX.text = [stDevx stringValue];
        self.stDeviationY.text = [stDevy stringValue];
        self.stDeviationZ.text = [stDevz stringValue];
    });
}

- (IBAction)getZeroCrossingAction:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.zeroCrossingX.text = [@(self.xCrossing) stringValue];
        self.zeroCrossingY.text = [@(self.yCrossing) stringValue];
        self.zeroCrossingZ.text = [@(self.zCrossing) stringValue];
    });
}

- (bool)checkSignDiffNum1:(double)num1 num2:(double)num2{
    return (num1 < 0 && num2 > 0) || (num1 > 0 && num2 < 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeValues];
    
    self.sensorFrequency = 0.05; // 50 ms
    self.locationManager = [[CLLocationManager alloc] init];
    self.motionManager = [[CMMotionManager alloc] init];
    
    [self setupGPSActivity];
    [self setupMotionActivity];
    
    [self testMethod];
}

#pragma mark Just a test method
- (void)testMethod {
    
//    NSNumber *stDev = [[StatisticsCalculator shared] standardDeviationOf:@[@1.1, @1.2, @0.3232323] forType:@"X"];
}

#pragma mark Setup initial values
- (void)initializeValues {
    self.sensorStats = [[NSMutableArray alloc] init];
    self.gpsCoordinates = [[NSMutableArray alloc] init];
    
    self.maxX = -10.0;
    self.maxY = -10.0;
    self.maxZ = -10.0;
    
    self.minX = 10.0;
    self.minY = 10.0;
    self.minZ = 10.0;
    
    self.xCrossing = 0;
    self.yCrossing = 0;
    self.zCrossing = 0;
    
    self.previousDate = [[NSDate alloc] init];
    
    DLog(@"sensor arr count %lu", (unsigned long)[self.sensorStats count]);
}

- (void)setupGPSActivity {
     self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    // we can minimize this to optimize battery performance
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)setupMotionActivity {
    
    if([self.motionManager isAccelerometerAvailable]) {
        [self.motionManager startAccelerometerUpdates];
    }
    
    if([self.motionManager isDeviceMotionAvailable]) {
        [self.motionManager startDeviceMotionUpdates];
    }
    
    [self startReadingSensorUpdates];
    [self startUpdateTimer];
}

- (void)startReadingSensorUpdates {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.sensorFrequency repeats:true block:^(NSTimer * _Nonnull timer) {
        
        CMAccelerometerData *accelerometerData = self.motionManager.accelerometerData;
        
//        DLog(@"accX value: %f", accelerometerData.acceleration.x);
//        DLog(@"accY value: %f", accelerometerData.acceleration.y);
//        DLog(@"accZ value: %f", accelerometerData.acceleration.z);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *str = @"Total count: ";
            str = [str stringByAppendingString:@(self.sensorStats.count).stringValue];
            self.totalValuesCountLbl.text = str;
        });
        
        [self updateZeroCrossingCountX:accelerometerData.acceleration.x countY:accelerometerData.acceleration.y countZ:accelerometerData.acceleration.z];
        
        self.currAccX = accelerometerData.acceleration.x;
        self.currAccY = accelerometerData.acceleration.y;
        self.currAccZ = accelerometerData.acceleration.z;
        
        SensorStatistics *newSensorReading = [[SensorStatistics alloc]initWithAccelerationX:accelerometerData.acceleration.x AccelerationY:accelerometerData.acceleration.y AccelerationZ:accelerometerData.acceleration.z];
        
        [self.sensorStats addObject:newSensorReading];
        
        printf("new data count %d", self.sensorStats.count);
        printf("\n");
    }];
}

- (void)updateZeroCrossingCountX:(double)accX countY:(double)accY countZ:(double)accZ{
    
    if([self checkSignDiffNum1:accX num2:self.currAccX]){
        self.xCrossing++;
    }
    if([self checkSignDiffNum1:accY num2:self.currAccY]){
        self.yCrossing++;
    }
    if([self checkSignDiffNum1:accZ num2:self.currAccZ]){
        self.zCrossing++;
    }
}

- (void)updateAccValues {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.myDoubleX = [NSNumber numberWithDouble:self.currAccX];
        self.myDoubleY = [NSNumber numberWithDouble:self.currAccY];
        self.myDoubleZ = [NSNumber numberWithDouble:self.currAccZ];
        
        self.currAccXLbl.text = [self.myDoubleX stringValue];
        self.currAccYLbl.text = [self.myDoubleY stringValue];
        self.currAccZLbl.text = [self.myDoubleZ stringValue];
    });
}

- (void)startUpdateTimer {
    
    self.valueUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 repeats:true block:^(NSTimer * _Nonnull timer) {
        
        // max min update
        [self updateMaxX:self.currAccX updateMinX:self.currAccX updateMaxY:self.currAccY updateMinY:self.currAccY updateMaxZ:self.currAccZ updateMinZ:self.currAccZ];
        
        [self updateAccValues];
    }];
}

- (void)startMotionAndGPSUpdates {
    
    [self startMotionActivity];
    [self startGPSUpdates];
}

- (void)startMotionActivity {
    
    NSLog(@"Motion updates started..");
    [_motionManager startAccelerometerUpdates];
}

- (void)startGPSUpdates {
    NSLog(@"GPS updates started..");
}

- (void) updateMaxX:(double)maxXValue updateMinX:(double)minXValue
         updateMaxY:(double)maxYValue updateMinY:(double)minYValue
         updateMaxZ:(double)maxZValue updateMinZ:(double)minZValue{
    
    self.maxX = MAX(self.maxX, maxXValue);
    self.minX = MIN(self.minX, minXValue);
    
    self.maxY = MAX(self.maxY, maxYValue);
    self.minY = MIN(self.minY, minYValue);
    
    self.maxZ = MAX(self.maxZ, maxZValue);
    self.minZ = MIN(self.minZ, minZValue);
}

#pragma mark Location Manager Delegate Methods

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if(status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    } else {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [self.gpsCoordinates addObjectsFromArray:locations];
    
    NSTimeInterval secondsBetween = [[[NSDate alloc] init] timeIntervalSinceDate:self.previousDate];
    
    #pragma mark The distance travelled in within duration can be updated by decreasing the duration here.
    
    if(secondsBetween >= 180){ // seconds
        
        self.previousDate = [[NSDate alloc] init];
        [self calculateAndUpdateDistance];
        [[self gpsCoordinates] removeAllObjects];
    }
}

- (void)calculateAndUpdateDistance{
    double distance = 0.0;
    
    for(int i=1; i<self.gpsCoordinates.count; i++){
        CLLocation *loc1 = [self.gpsCoordinates objectAtIndex:i-1];
        CLLocation *loc2 = [self.gpsCoordinates objectAtIndex:i];
        
        distance += [loc1 distanceFromLocation:loc2];
    }
    
    self.myDoubleX = [NSNumber numberWithDouble:distance];
    
    NSString *str = @"Distance travelled in last 3mins in (m): ";
    str = [str stringByAppendingString:@([[self myDoubleX] doubleValue]).stringValue];
    str = [str stringByAppendingString:@" m"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.distanceTravelledLbl.text = str;
    });
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
    NSLog(@"Failed to get new Location..");
}

@end
