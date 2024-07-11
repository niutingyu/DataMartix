//
//  CustomComplaintListModel.m
//  DataMatrix
//
//  Created by Andy on 2022/7/20.
//

#import "CustomComplaintListModel.h"

@implementation CustomComplaintListModel

-(void)setValue:(id)value forKey:(NSString *)key{
    
    [super setValue:value forKey:key];
    
    if(_CauseDescription.length >0){
        _rowHeigh  =[Units calculateRowHeight:_CauseDescription width:kScreenWidth-104-50-80]+20.0f;
    }else{
        _rowHeigh =50.0f;
    }
    
    
}
@end
