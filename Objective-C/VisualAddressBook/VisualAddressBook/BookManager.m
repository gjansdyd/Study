//
//  BookManager.m
//  BookManager
//
//  Created by MunYong HEO on 2022/11/14.
//

#import "BookManager.h"
#import "Book.h" //선언부에서 import를 잘 하지 않는다
@implementation BookManager
- (id) init {
    self = [super init];
    if (self) {
        bookList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addBook:(Book *)bookObject {
    [bookList addObject: bookObject];
}
- (NSString *) showAllBook {
    NSMutableString *strTmp = [[NSMutableString alloc] init];
    for (Book *bookTemp in bookList) {
        [strTmp appendString: @"Name : "];
        [strTmp appendString: bookTemp.name];
        [strTmp appendString: @"\n"];
        [strTmp appendString: @"Genre : "];
        [strTmp appendString: bookTemp.genre];
        [strTmp appendString: @"\n"];
        [strTmp appendString: @"Author : "];
        [strTmp appendString: bookTemp.author];
        [strTmp appendString: @"\n"];
        [strTmp appendString: @"==========================="];
        [strTmp appendString: @"\n"];
    }
    
    return strTmp;
}

- (NSUInteger *) countBook {
    return [bookList count];
}

- (NSString *) findBook: (NSString *) name {
    NSMutableString *strTmp = [[NSMutableString alloc] init];
    for (Book * bookTemp in bookList) {
        if ([bookTemp.name isEqualToString: name]) {
            [strTmp appendString: @"Name : "];
            [strTmp appendString: bookTemp.name];
            [strTmp appendString: @"\n"];
            [strTmp appendString: @"Genre : "];
            [strTmp appendString: bookTemp.genre];
            [strTmp appendString: @"\n"];
            [strTmp appendString: @"Author : "];
            [strTmp appendString: bookTemp.author];
            return strTmp;
        }
    }
    
    return nil;
}

- (NSString *) removeBook: (NSString *) name {
    for (Book * bookTemp in bookList) {
        if ([bookTemp.name isEqualToString: name]) {
            [bookList removeObject: bookTemp];
            return name;
        }
    }
    return nil;
}

@end
