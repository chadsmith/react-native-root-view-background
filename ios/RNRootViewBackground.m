
#import "RNRootViewBackground.h"

@implementation RNRootViewBackground

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(setBackground:(float)red green:(float)green blue:(float)blue alpha:(float)alpha)
{
    dispatch_async( dispatch_get_main_queue(), ^{
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        rootViewController.view.backgroundColor = [[UIColor alloc] initWithRed:red/255 green:green/255 blue:blue/255 alpha:alpha];
    });
}

RCT_EXPORT_MODULE()

- (UIViewController *)currentViewController {
  UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
  UIViewController *currentViewController = [self currentViewControllerFromViewController:rootViewController];
  return currentViewController;
}

- (UIViewController *)currentViewControllerFromViewController:(UIViewController *)viewController {
  if ([viewController isKindOfClass:UINavigationController.class]) {
    return [self currentViewControllerFromViewController:((UINavigationController *)viewController).visibleViewController];
  }
  else if ([viewController isKindOfClass:UITabBarController.class]) {
    return [self currentViewControllerFromViewController:((UITabBarController *)viewController).selectedViewController];
  }
  else {
    if (viewController.presentedViewController) {
      return [self currentViewControllerFromViewController:viewController.presentedViewController];
    }
    else {
      return viewController;
    }
  }
}

@end
