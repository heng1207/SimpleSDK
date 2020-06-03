//
//  TemplateManger.h
//  SimpleSDK
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TemplateManger : NSObject

+(id)shareInstance;
-(UIViewController *)getVC;

@end

NS_ASSUME_NONNULL_END
