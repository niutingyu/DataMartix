//
//  ESBWFParmModel.m
//  DataMatrixCode
//
//  Created by Andy on 2021/10/30.
//

#import "ESBWFParmModel.h"


@implementation ESBWFParmModel
-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    NSMutableString * string =[[NSMutableString alloc]init];
    for (int i =0; i<_list.count; i++) {
        NSDictionary *dict = _list[i];
        if (![dict isKindOfClass:[NSNull class]]) {
            NSString *totalStr  = [dict objectForKey:@"param"];
            if (i == _list.count-1) {
                [string appendString:[NSString stringWithFormat:@"%@",totalStr]];
            }else{
                [string appendString:[NSString stringWithFormat:@"%@\n",totalStr]];
            }
        }
       
    }
   
    _totalParmString  =string;
    if (_totalParmString.length >0) {
        _rowHeight  = [Units calculateRowHeight:string width:kScreenWidth-40-110-32]+20.0f;
    }else{
        _rowHeight  =40.0f;
    }
    
   
    
}
@end
