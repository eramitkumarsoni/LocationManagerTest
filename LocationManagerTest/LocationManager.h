//
//  LocationManager.h
//  LocationManagerTest
//
//  Created by Amit Soni on 23/08/14.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

- (void)registerLocations:(NSArray *)locations withIdentifiers:(NSArray *)identifiers andRadius:(double)radius;

@end
