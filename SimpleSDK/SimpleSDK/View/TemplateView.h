//
//  TemplateView.h
//  SimpleSDK
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TemplateViewDelegate <NSObject>
-(void)requestData;
@end

@interface TemplateView : UIView
@property(nonatomic,weak)id<TemplateViewDelegate> delegate;

-(void)updateViewInfoWithData:(id)data;
@end

NS_ASSUME_NONNULL_END
