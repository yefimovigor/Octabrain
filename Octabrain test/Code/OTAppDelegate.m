//Class "OTAppDelegate" - "Octabrain test" application delegate
//Created by Igor S Yefimov
//Copyright Igor S Yefimov


#import "OTAppDelegate.h"




@interface OTAppDelegate ()
@end




@implementation OTAppDelegate

#pragma mark - UIApplicationDelegate (application lifecycle)

- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    return YES;
}




#pragma mark - UIApplicationDelegate (orientation)

- (NSUInteger) application:(UIApplication*)application supportedInterfaceOrientationsForWindow:(UIWindow*)window {
    return UIInterfaceOrientationMaskAll;
}

@end