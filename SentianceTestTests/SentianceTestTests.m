//
//  SentianceTestTests.m
//  SentianceTestTests
//
//  Created by Apple on 21/12/20.
//

#import <XCTest/XCTest.h>
#import "SensorStatistics.h"
#import "StatisticsCalculator.h"

@interface SentianceTestTests : XCTestCase

@end

@implementation SentianceTestTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testMedian {
    
    NSMutableArray *testArr = [NSMutableArray array];
    
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.12 AccelerationY:0.4124 AccelerationZ:1.234]];
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.1212783712 AccelerationY:1.5453 AccelerationZ:1.91237912]];
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.0132124 AccelerationY:1.414124124 AccelerationZ:0.12312]];
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.8998 AccelerationY:0.671623 AccelerationZ:0.00012124124]];
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.999 AccelerationY:0.819293 AccelerationZ:0.13123]];
    
    SensorStatistics *median1 = [[StatisticsCalculator shared] medianOf:testArr forType:@"X"];
    SensorStatistics *median2 = [[StatisticsCalculator shared] medianOf:testArr forType:@"Y"];
    SensorStatistics *median3 = [[StatisticsCalculator shared] medianOf:testArr forType:@"Z"];
    
    XCTAssertEqual(median1.accX, 0.1212783712);
    XCTAssertEqual(median2.accY, 0.819293);
    XCTAssertEqual(median3.accZ, 0.13123);
}

- (void)testMean {
    
    NSMutableArray *testArr = [NSMutableArray array];
    
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.12 AccelerationY:0.4124 AccelerationZ:1.234]];
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.1212783712 AccelerationY:1.5453 AccelerationZ:1.91237912]];
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.0132124 AccelerationY:1.414124124 AccelerationZ:0.12312]];
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.8998 AccelerationY:0.671623 AccelerationZ:0.00012124124]];
    [testArr addObject:[[SensorStatistics alloc] initWithAccelerationX:0.999 AccelerationY:0.819293 AccelerationZ:0.13123]];
    
    NSNumber *meanX = [[StatisticsCalculator shared] meanOf:testArr forType:@"X"];
    NSNumber *meanY = [[StatisticsCalculator shared] meanOf:testArr forType:@"Y"];
    NSNumber *meanZ = [[StatisticsCalculator shared] meanOf:testArr forType:@"Z"];
    
    XCTAssertEqual([meanX doubleValue], 0.43065815424);
    XCTAssertEqual([meanY doubleValue], 0.9725480248);
    XCTAssertEqual([meanZ doubleValue], 0.680170072248);
}

- (void)testStandardDeviation{
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
