#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    FlutterViewController *vc = self.window.rootViewController;
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:@"mine_page/method" binaryMessenger:vc];
    UIImagePickerController *imageVC = [UIImagePickerController new];
    imageVC.delegate = self;
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        //接收flutter消息
        if ([call.method isEqualToString:@"picture"]) {
            [vc presentViewController:imageVC animated:YES completion:nil];
        }
            
    }];
    self.methodChannel = methodChannel;
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"iOS选好照片了");
         NSString * imagePath = [NSString stringWithFormat:@"%@",info[@"UIImagePickerControllerImageURL"]];
        [self.methodChannel invokeMethod:@"imagePath" arguments:imagePath];
    }];
}
@end
