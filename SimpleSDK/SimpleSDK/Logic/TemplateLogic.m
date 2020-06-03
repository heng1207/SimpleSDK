//
//  TemplateLogic.m
//  SimpleSDK
//

#import "TemplateLogic.h"

@implementation TemplateLogic


-(void)sengGetDataRequestWithComplete:(void(^)(BOOL isOK)) complete{
    if (complete) {
        complete(YES);
    }
}


@end
