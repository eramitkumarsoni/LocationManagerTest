//
//  ViewController.m
//  LocationManagerTest
//
//  Created by Amit Soni on 23/08/14.
//

#import "ViewController.h"

@interface ViewController ()
{
    LocationManager *locManager;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *locationsArray = @[@"12.9285212,77.5834339",@"12.9172491,77.622693",@"12.9128118,77.6092188"];
    
    // locationsArray format should be like  ( lat,long )
    
    NSArray *identifiersArray = @[@"Jaynagar 4th block",@"Silk Board",@"BTM Layout"];
    double radius = 300.0;
    
    locManager = [[LocationManager alloc] init];
    [locManager registerLocations:locationsArray withIdentifiers:identifiersArray andRadius:radius];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
