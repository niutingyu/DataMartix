//
//  CustomComplaintAlertView.m
//  DataMatrix
//
//  Created by Andy on 2022/7/21.
//

#import "CustomComplaintAlertView.h"
#import "CustomComplaintHeadView.h"
#import "ESBComplaintHistoryListTableCell.h"
#import "CustomComplaintListModel.h"
/** 屏幕高度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define DEFAULT_MAX_HEIGHT SCREEN_HEIGHT/3*1.5



//屏幕适配
/**当前设备对应375的比例*/
#define Ratio_375 (SCREEN_WIDTH/375.0)
/**转换成当前比例的数*/
#define Ratio(x) ((int)((x) * Ratio_375))

@interface CustomComplaintAlertView ()<UITableViewDelegate,UITableViewDataSource>
/**tableview*/

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *historyList;

@end
@implementation CustomComplaintAlertView

+(void)showassetAlertViewWithHistoryList:(NSMutableArray*)historyList{
    CustomComplaintAlertView *assetView =[[CustomComplaintAlertView alloc]initHistoryList:historyList];
    [[UIApplication sharedApplication].delegate.window addSubview:assetView];
    
}


-(instancetype)initHistoryList:(NSMutableArray*)historyList{
    if (self = [super init]) {
        self.historyList = historyList;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    //bgView最大高度
    CGFloat maxHeight = DEFAULT_MAX_HEIGHT;
    
    
    //backgroundView
    
    UIView *bgView = [[UIView alloc]init];
    bgView.center = self.center;
    bgView.bounds = CGRectMake(0, 0, self.frame.size.width - Ratio(5), maxHeight+Ratio(18));
    [self addSubview:bgView];
   
    
    //添加更新提示
    UIView *updateView = [[UIView alloc]init];
    updateView.frame = CGRectMake(Ratio(2.5), Ratio(5), bgView.frame.size.width -Ratio(5), maxHeight);
    updateView.backgroundColor = [UIColor whiteColor];
    updateView.layer.masksToBounds = YES;
   // updateView.layer.cornerRadius = 4.0f;
    [bgView addSubview:updateView];
   
    
   
    [self showWithAlert:bgView];
    
    //tableview
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 2, updateView.frame.size.width, updateView.frame.size.height+Ratio(18)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 50;
        _tableView.separatorStyle  =UITableViewCellSeparatorStyleNone;
        [updateView addSubview:_tableView];
        [_tableView registerNib:[UINib nibWithNibName:@"ESBComplaintHistoryListTableCell" bundle:nil] forCellReuseIdentifier:@"hCellId"];
        
        
    }
    
//    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancelButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
//
//    cancelButton.center = CGPointMake(updateView.frame.size.width/2, updateView.frame.size.height+60);
//    cancelButton.bounds = CGRectMake(0, 0, Ratio(36), 36);
//    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:cancelButton];
    //
//    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(updateView.frame)-60, updateView.frame.size.width, 50)];
//    buttonView.backgroundColor = [UIColor whiteColor];
//    [updateView addSubview:buttonView];
//
//
//
//    NSArray * titles = @[@"取消",@"确定"];
//    for (NSInteger i = 0; i <2; i++) {
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(buttonView.frame.size.width/2*i, 0, buttonView.frame.size.width*0.5, 50);
//        button.backgroundColor = RGBA(242, 242, 242, 1);
//        [button setTitle:titles[i] forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
//        button.tag = 100+i;
//        [buttonView addSubview:button];
//    }
//    //加一条线
//    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(buttonView.frame.size.width*0.5, 15, 2, 20)];
//    line.backgroundColor = [UIColor lightGrayColor];
//    line.layer.cornerRadius = 3.f;
//    line.clipsToBounds = YES;
//    [buttonView addSubview:line];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historyList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ESBComplaintHistoryListTableCell *cell =[tableView dequeueReusableCellWithIdentifier:@"hCellId"];
    CustomComplaintListModel *model = self.historyList[indexPath.row];
    cell.model =model;
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CustomComplaintHeadView *headView  =[[NSBundle mainBundle]loadNibNamed:@"CustomComplaintHeadView" owner:self options:nil].firstObject;
    
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomComplaintListModel *model  = self.historyList[indexPath.row];
    return model.rowHeigh;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0f;
}

-(void)cancel{
    [self dismissAlert];
}
- (void)showWithAlert:(UIView*)alert{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.6f;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
  //  [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissAlert];
}

/** 添加Alert出场动画 */
- (void)dismissAlert{
    
    [UIView animateWithDuration:0.6f animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

-(NSMutableArray*)historyList{
    if (!_historyList) {
        _historyList =[NSMutableArray array];
    }
    return _historyList;
}

@end
