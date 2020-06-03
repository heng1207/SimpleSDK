//
//  TemplateManger.m
//  SimpleSDK
//

#import "TemplateManger.h"
#import "TemplateViewController.h"

@interface TemplateManger()<NSCopying>

@property(nonatomic,strong)TemplateViewController *vc;

@end

@implementation TemplateManger

+(id)shareInstance{
    
    static TemplateManger *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[super allocWithZone:NULL]init];
    });
    return manger;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self shareInstance];
}
-(id)copyWithZone:(NSZone *)zone{
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma Intial Methods
#pragma Override Methods
#pragma Public Methods
-(UIViewController *)getVC{
    return self.vc;
}
#pragma Private Methods
#pragma Network Methods
#pragma Protocol Methods
#pragma Setter and Getter Methods
-(TemplateViewController *)vc{
    if (!_vc) {
        _vc  = [[TemplateViewController alloc]init];
    }
    return _vc;
}

@end
