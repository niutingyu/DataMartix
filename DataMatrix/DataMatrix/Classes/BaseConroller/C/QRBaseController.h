//
//  QRBaseController.h
//  DataMatrixCode
//
//  Created by Andy on 2021/10/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRBaseController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *listDatasource;

@end

NS_ASSUME_NONNULL_END
