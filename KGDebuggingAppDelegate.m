
@implementation KGDebuggingAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
  if ( localNotification )
  {
       UIAlertView *debugAlert = [[UIAlertView alloc] initWithTitle:@"Debug" message:localNotification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [debugAlert show];
  }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif {
    DNSLog(@"Notification logged is %@",notif);
}

@end
