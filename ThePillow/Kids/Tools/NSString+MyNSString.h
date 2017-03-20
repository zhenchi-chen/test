

#import <Foundation/Foundation.h>

@interface NSString (MyNSString)

/**
 *  根据时间 格式字符串获取时间字符串
 *
 *  @param date   <#date description#>
 *  @param format <#format description#>
 *
 *  @return <#return value description#>
 */
-(id)initWithDate:(NSDate *)date format:(NSString *)format;


//时间戳转时间
-(id)initWithTimesp:(NSTimeInterval)timesp format:(NSString *)format;
-(id)initWithTimespStr:(NSString *)timespStr format:(NSString *)format;



@end
