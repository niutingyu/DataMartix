//
//  CustomComplaintListController.m
//  DataMatrix
//
//  Created by Andy on 2022/7/20.
//

#import "CustomComplaintListController.h"
#import "CustomComplaintListModel.h"
#import "ESBComplaintHistoryListTableCell.h"
@interface CustomComplaintListController ()

@end

@implementation CustomComplaintListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"客诉历史查询";
    self.view.backgroundColor  =[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ESBComplaintHistoryListTableCell" bundle:nil] forCellReuseIdentifier:@"hCellId"];
    
    [self getCustomComplaintHistoryList];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listDatasource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ESBComplaintHistoryListTableCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"hCellId"];
    
    CustomComplaintListModel *model =self.listDatasource [indexPath.row];
    cell.model =model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128.0f;
}

-(void)getCustomComplaintHistoryList{
    NSMutableDictionary * parms  =[NSMutableDictionary dictionary];
    [parms setObject:_pnNumber?:@"" forKey:@"pnNumber"];
    NSString *url =@"http://192.168.1.21:8001/rt/customercomplaintssubject/getCcsHistoryByPnNumber";
    
    KWeakSelf
    [NetWorkManage ErpPostWithUrl:url parms:parms sucess:^(id  _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"]intValue]==0) {
            NSString *jsonStr  = [responseObject objectForKey:@"data"];
            NSArray *jsonList  = [Units jsonToArray:jsonStr];
            NSMutableArray *modelList  = [CustomComplaintListModel mj_objectArrayWithKeyValuesArray:jsonList];
            [weakSelf.listDatasource removeAllObjects];
            [weakSelf.listDatasource addObjectsFromArray:modelList];
        }
        [weakSelf.tableView reloadData];
        debugLog(@"sucess %@",responseObject);
    } error:^(NSError * _Nonnull error) {
        debugLog(@"error%@",error);
    }];
}

@end
