//
//  QRBaseController.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/29.
//

#import "QRBaseController.h"
#import "UITableView+AddForPlaceholder.h"
@interface QRBaseController ()

@end

@implementation QRBaseController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [self setStatusBarBackgroundColor:RGBA(44, 64, 155, 1)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =[UIColor whiteColor];
    self.tableView.defaultNoDataText =@"暂无更多数据";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listDatasource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell  =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView  =[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _tableView.delegate =self;
        _tableView.dataSource  =self;
        _tableView.tableFooterView =[[UIView alloc]init];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray*)listDatasource{
    if (!_listDatasource) {
        _listDatasource  =[NSMutableArray array];
    }
    return _listDatasource;
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

@end
