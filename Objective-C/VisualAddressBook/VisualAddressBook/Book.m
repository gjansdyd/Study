//
//  Book.m
//  BookManager
//
//  Created by MunYong HEO on 2022/11/14.
//

#import "Book.h"

@implementation Book
@synthesize name, genre, author; //안해도 된다.

- (void) bookPrint {
    NSLog(@"Name: %@", name);
    NSLog(@"Genre: %@", genre);
    NSLog(@"Author: %@", author);
}
@end
