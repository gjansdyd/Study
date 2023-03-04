//
//  BookManager.h
//  BookManager
//
//  Created by MunYong HEO on 2022/11/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Book;    //Book이란 클래스 있으니까 컴파일 에러내지 마라
//좋은점? a<-b<-c<-a 등등... *찾아볼것
@interface BookManager : NSObject {
    NSMutableArray *bookList;
    
}
- (void) addBook: (Book *)bookObject;
- (NSString *) showAllBook;
- (NSUInteger *) countBook;
- (NSString *) findBook: (NSString *) name;
- (NSString *) removeBook: (NSString *) name;
@end

NS_ASSUME_NONNULL_END
