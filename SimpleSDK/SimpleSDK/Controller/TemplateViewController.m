//
//  TemplateViewController.m
//  SimpleSDK
//

#import "TemplateViewController.h"
#import "TemplateView.h"
#import "TemplateLogic.h"

//Frameworks

//Models

//Views

//Logic


@interface TemplateViewController ()<TemplateViewDelegate>
@property(nonatomic,strong)TemplateView *templateView;
@property(nonatomic,strong)TemplateLogic *templateLogic;

@end

@implementation TemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    self.templateLogic = [[TemplateLogic alloc]init];
    
    [self.view addSubview:self.templateView];
  
    

    
    // Do any additional setup after loading the view.
}
#pragma mark TemplateViewDelegate
-(void)requestData{
    if (self.templateLogic) {
        [self.templateLogic sengGetDataRequestWithComplete:^(BOOL isOK) {
            if (isOK) {
                NSLog(@"请求成功");
                [self.templateView updateViewInfoWithData:@"OK"];
            }
            else{
                NSLog(@"请求失败");
                [self.templateView updateViewInfoWithData:@"error"];
            }
        }];
    }
}
-(TemplateView *)templateView{
    if (!_templateView) {
        _templateView = [[TemplateView alloc]initWithFrame:CGRectMake(50, 100, 300, 100)];
        _templateView.delegate = self;
    }
    return _templateView;
}

-(void)dealloc{
    NSLog(@"%@",self);
}

@end
