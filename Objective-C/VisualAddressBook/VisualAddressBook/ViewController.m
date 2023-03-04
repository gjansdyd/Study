//
//  ViewController.m
//  VisualAddressBook
//
//  Created by MunYong HEO on 2022/11/14.
//

#import "ViewController.h"
#import "Book.h"
#import "BookManager.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize resultTextView;
@synthesize nameTextField;
@synthesize genreTextField;
@synthesize authorTextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    Book *book1 = [[Book alloc] init];
    book1.name = @"햄릿";
    book1.genre = @"비극";
    book1.author = @"셰익스피어";
//        [book1 bookPrint];
    
    Book *book2 = [[Book alloc] init];
    book2.name = @"누구를 위하여 종을 울리나";
    book2.genre = @"전쟁소설";
    book2.author = @"헤밍웨이";
//        [book2 bookPrint];
    
    Book *book3 = [[Book alloc] init];
    book3.name = @"죄와벌";
    book3.genre = @"사실주의";
    book3.author = @"톨스토이";
//        [book3 bookPrint];
    
    myBook = [[BookManager alloc] init];
    [myBook addBook:book1];
    [myBook addBook:book2];
    [myBook addBook:book3];
    NSLog(@"%@", [myBook showAllBook]);
    NSLog(@"count: %i", [myBook countBook]);
    NSString *strTemp = [myBook findBook:@"죄와벌"];
    if (strTemp != nil) {
        NSLog(@"%@", strTemp);
    } else {
        NSLog(@"찾으시는 책이 없네요");
    }
    NSString * removeStr = [myBook removeBook:@"죄와벌"];
    if (removeStr != nil) {
        NSLog(@"%@", removeStr);
    } else {
        NSLog(@"지울 책이 없네요");
    }
    NSLog(@"count: %i", [myBook countBook]);
}

-(IBAction)showAllBookAction:(id)sender {
    NSLog(@"showAllBookAction");
    NSLog(@"%@", [myBook showAllBook]);
    resultTextView.text = [myBook showAllBook];
}
- (IBAction)addBookAction:(id)sender {
    Book *book = [[Book alloc] init];
    book.name = nameTextField.text;
    book.genre = genreTextField.text;
    book.author = authorTextField.text;
    
    [myBook addBook:book];
}
- (IBAction)searchBookAction:(id)sender {
    NSString * foundBook = [myBook findBook: nameTextField.text];
    resultTextView.text = foundBook;
}

@end
