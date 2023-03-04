//
//  Book.h
//  BookManager
//
//  Created by MunYong HEO on 2022/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject
    // (atomic) 동시에 값의 접근 불가능.
    // nonatomic 동시에 값 접근 가능.
    // strong: 동적할당되어 객체를 참조하고 있다.
@property (nonatomic, strong) NSString *name; //getter, setter한번에 만드는 property
@property (nonatomic, strong) NSString *genre;
@property (nonatomic, strong) NSString *author;


- (void) bookPrint;

@end

NS_ASSUME_NONNULL_END
