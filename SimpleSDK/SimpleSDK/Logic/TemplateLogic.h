//
//  TemplateLogic.h
//  SimpleSDK
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TemplateLogic : NSObject

-(void)sengGetDataRequestWithComplete:(void(^)(BOOL isOK)) complete;

@end

NS_ASSUME_NONNULL_END
