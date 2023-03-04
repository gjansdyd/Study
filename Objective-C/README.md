# Basic Syntax

## 선언부와 구현부

Objective-C는 크게 선언부와 구현부로 나누어 코드를 작성한다.

먼저 선언부는 다음과 같이 작성한다.

```objectivec
// 꺽쇠 헤더는 Apple에서 제공하는 것
// 사용자 정의 헤더는 ""(쌍따옴표) 사용
#import <Foundation/Foundation.h> 

@interface 클래스명: 상속받을_클래스 {
	// member variable 
	자료형 변수명; // 여기서 값을 바로 초기화할 수 없다
}

-(리턴타입) 함수명: (자료형)함수내_변수명;
@end
```

 구현부는 다음과 같이 작성한다.

```objectivec
// 선언부가 적힌 헤더를 추가한다
#import "선언부헤더.h"

@implementation 클래스명
-(리턴타입) 함수명: (자료형)함수내_변수명 {
	//처리할 내용 기재
}
@end 

// Command line tool로 실행해야 하므로 최종적으로는 이 함수를 통해 실행된다.
int main(int argc, const char * argv []) {
	//선언부+구현부의 클래스를 호출함
}
```

## 선언부

위의 설명에 따라 실제 코드는 다음과 같이 작성할 수 있다.

```objectivec
// Vehicle_1.h
#import <Foundation/Foundation.h>

@interface Vehicle : NSObject {
    int wheels; 
    int seats;
}

-(void) setWheels: (int)w;
-(void) setSeats: (int)s;
-(void) wheels;
-(void) seats;

@end
```

 만약 **Properties Control Access(@property)**를 사용한다면  위의 코드는 다음으로 대체될 수도 있다.

```objectivec
// Vehicle_2.h: Vehicle_1.h와 동일한 기능을 한다.
#import <Foundation/Foundation.h>

@interface Vehicle : NSObject {
}

@property int wheels;
@property int seats;
@end
```

 

 위의 @property는 자동으로 getter와 setter를 만들어준다. 이 때 만들어지는 함수의 이름은 “Vehicle_1.h”에서 선언된 함수와 같다. 만약 Properties Control Access를 사용하며 동시에 getter와 setter함수명을 재정의 하고 싶다면 다음과 같이 쓸 수도 있다.

```objectivec
// Vehicle_3.h: Vehicle_1.h, Viehicle_2와 동일한 기능을 한다.
#import <Foundation/Foundation.h>

@interface Vehicle : NSObject {
}

@property (getter=getWheelsValue, setter=setWheelsValue:) int wheels;
@property (getter=getSeatsValue, setter=setSeatsValue:) int seats;
@end
```

## 구현부

 구현부의 실제 코드는 다음과 같이 작성한다

```objectivec
// Vehicle.m 파일
#import <Foundation/Foundation.h> // Apple에서 기본 제공하는 애들은 꺽쇠
#import "Vehicle.h" // 본인이 직접 만든 건 쌍따옴표 사용. 
										// 보통 1header-1method. 둘의 이름은 같고 확장자는 다름.

@implementation Vehicle // method파일의 시작을 의미.
// setter
-(void) setWheels: (int)w {
    wheels = w;
}
-(void) setSeats: (int)s {
    seats = s;
}

// getter
-(int) wheels {
    return wheels;
}
-(int) seats {
    return seats;
}

@end
```

parameter가 2개 이상인 함수는 다음과 같이 선언하고 구현한다.

```objectivec
// Test.h
@interface Test: NSObject {
	int value1;
	int value2;
}

-(void)setWheels:(int)w Seats:(int)s; 
			// parameter 2개 받을 때에는 위와 같이 사용
			// "**:"표시? 파라미터를 구분하는 단위**
@end

// Test.m
#import <Foundation/Foundation.h> 
#import "Test.h"

@implementation Test // method파일의 시작을 의미.
-(void)setWheels:(int)w Seats:(int)s {
    wheels = w;
    seats = s;
}

@end
```

## main함수에서 호출 방법

아래 코드는 선언부&구현부에서 생성한 Vehicle 클래스를 호출하는 방법이다.

```objectivec
int main(int argc, const char * argv []) {
    @autoreleasepool {
// Obj-C에서는 [Receiver Message]형태로 코드를 작성한다.
// 가령 아래의 코드는 Vehicle 자료형에게 new 메시지를 보내는 것.
			Vehicle *hello1 = [Vehicle new]; // 자료형 Vehicle object를 동적할당하기

// 하지만 위의 코드는 관례적으로 쓰지 않는다.
// 왜냐하면 이후 배울 convenience메소드들 때문이다.
// 그래서 보통 아래와 같이 메소드 체이닝 방식으로 작성한다.
// 메모리에 동적할당(alloc)하는 작업과 초기화(init)하는 작업을 따로따로 하는 것이다.
			Vehicle *hello2 = [[Vehicle alloc] init]; 

			// setter1
			[hello1 setWheels: 4];
			[hello1 setSeats: 2];

			// setter2
			hello2.wheels = 4;
			hello2.seats = 2;

			// getter1
			NSLog(@"wheels: %i, seats: %i", [hello1 wheels], [hello1 seats]);
			// getter2
			NSLog(@"wheels: %i, seats: %i", hello2.wheels, hello2.seats);
		}
}
```

## NSString & NSMutableString

NSString과 NSMutableString은 Obj-C에서 문자열을 다룰 때 쓰는 자료형이다. 

## NSString

NSString의 자료형을 가진 변수는 int type과 마찬가지로 다음과 같이 메소드 체이닝을 이용해 동적할당 및 초기화를 할 수 있다.

```objectivec
NSString *str = [[NSString alloc] init];
str = @"This is NSString"; //문자열 앞에는 반드시 @를 적어야 한다.
NSLog(@"str: %@", str); // 문자열 안에 문자열을 삽입할 때에는 %@문자를 쓴다.
												// 참고: int type의 경우 "%i"를 썼었다.
```

하지만 NSString의 경우 다음과 같은 함수를 사용하여 바로 할당 및 초기화가 가능하다.

```objectivec

//initWith메소드? Convenience method 만들면서 초기화.
NSString *str2 = [[NSString alloc]initWithString:@"This is NSString"]; 
NSLog(@"str2: %@", str2); 
```

 NSString은 immutable한 자료형이다. immutable이란 말 그대로 수정 불가능하다는 뜻이다. 따라서 NSString type의 변수 중 특정 범위의 문자열에 대한 접근을 하는 함수들은 return값으로 새로운 NSString을 반환한다.

```objectivec
- (NSString *)substringFromIndex:(NSUInteger)from; // from부터 문자열 끝까지 값을 반환
- (NSString *)substringToIndex:(NSUInteger)to; // 문자열의 시작부터 to전까지 값을 반환
- (NSString *)substringWithRange:(NSRange)range; // 문자열 중 range에 해당하는 범위의 값을 반환
```

용례는 다음과 같다

```objectivec
NSString *str = [[NSString alloc] initWithString: @"ABCDEFG"];
NSString *result1 = [str substringFromIndex: 3];
NSString *result2 = [str substringToIndex: 3];
NSString *result3 = [str substringWithRange: NSMakeRange(3, 3)];
NSLog(@"result1: %@", result1); // result1: DEFG
NSLog(@"result2: %@", result2); // result2: ABC
NSLog(@"result3: %@", result3); // result3: DEF
```

## NSMutableString

 NSMutableString은 다음과 같이 초기화할 수 있다.

```objectivec
// + (instancetype)stringWithString:(NSString *)string;
NSMutableString *mstr = [NSMutableString stringWithString: @"ABCDEFG"];
```

 NSMutableString은 mutable한 자료형 즉, 자기 자신이 현재 갖고 있는 value가 변경될 수 있는 자료형이다. NSString의 함수들이 새로운 NSString type의 value를 return하는 것과 달리 NSMutableString내 함수들은 자신의 값을 변화 시킬 수 있다. 가령, 위의 mstr의 특정 index에 있는 문자를 더하거나 빼기 위해서는 다음 메시지(메소드)를 보낸다.

```objectivec
- (void)appendString:(NSString *)aString; // 현재 mutableString 맨 뒤에 aString을 덧붙인다
- (void)insertString:(NSString *)aString
             atIndex:(NSUInteger)loc;     // 현재 mutableString의 loc에 해당하는 index에 aString을 삽입한다
- (void)deleteCharactersInRange:(NSRange)range; // 현재 mutableString 중 range범위에 해당하는 character들을 삭제한다
```

 위 함수들의 용례는 다음과 같다.

```objectivec
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableString *mstr = [NSMutableString stringWithString: @"ABCDEFG"];
        NSLog(@"mstr: %@", mstr); 
//mstr: ABCDEFG
        [mstr appendString:@"KLM"];
        NSLog(@"mstr: %@", mstr); 
// mstr: ABCDEFGKLM
        [mstr insertString: @"HIJ" atIndex:7];
        NSLog(@"mstr: %@", mstr); 
// mstr: ABCDEFGHIJKLM
        [mstr deleteCharactersInRange:NSMakeRange(1, 5)];
        NSLog(@"mstr: %@", mstr); 
// mstr: AGHIJKLM
    }
}
```

## NSArray & NSMutableArray

NSArray, 그리고 NSArray의 subclass인 NSMutableArray는 정렬된 collection이다. NSArray는 static이어서 immutable하지만 NSMutableArray는 dynamic하다. 둘 중 필요에 따라 쓰면 된다 .

### NSArray

NSArray는 동적할당 및 초기화를 하고 나면 이후 값의 변경을 할 수 없다. 동적할당과 초기화를 같이 하고자 할 때에는 다음의 함수를 쓴다.

```objectivec
- (instancetype)initWithObjects:(ObjectType)firstObj, ...;
```

용례는 다음과 같다.

```objectivec
NSArray *month = [[NSArray alloc] initWithObjects:
                  @"January", @"Feburary", @"March",
                  @"April", @"May", @"June", nil]; //배열의 초기화
```

이 때 마지막에 nil을 넣어 배열의 마지막을 표시해주어야 한다.

배열의 값에 접근할 떄에는 다음의 함수를 쓴다.

```objectivec
- (ObjectType)objectAtIndex:(NSUInteger)index;
```

 이 함수는 NSArray object들 중 parameter로 주어진 index에 접근하여 해당 object를 반환할 때 쓴다. 용례는 다음과 같다.

```objectivec
// 배열의 값을 빼서 쓰기
for(int i=0; i< [month count]; i++) {
	NSLog(@"month: %@", month[i]); //이것은 C언어 스타일이다.
  NSLog(@"month: %@", [month objectAtIndex:i]); //이것이 obj-c 스타일
}
```

 하지만 이 보다 objective-c스러운 for문도 있다. 

```objectivec
// 하지만 더 obj-c스러운 코드는 for-in문 사용
for (NSString *tmp in month) {
	NSLog(@"month: %@", tmp); //obj-c에서 제공하는 for문. 
}
```

for-in문은 객체 배열에 index로 접근하여 발생할 수 있는 index out of range오류의 발생가능성을 원천 차단한다.

### NSMutableArray

 NSArray의 subclass인 NSMutableArray는 해당 배열의 값을 변경할 수 있다(mutable). 우선 이 배열의 초기화 및 동적할당을 해보자. 이번에는 특정 배열을 복사하여 배열을 만드는 함수를 소개한다.

```objectivec
+ (instancetype)arrayWithArray:(NSArray<ObjectType> *)array;
```

 용례는 다음과 같다.

```objectivec
NSMutableArray *mmonth = [NSMutableArray arrayWithArray:month];
	// 여기서 month는 위의 month배열이다. 
```

 subclass이기 때문에 배열 내 객체에 접근할 때에는 NSArray에서 쓰던 함수 거의 모든 것을 다 쓸 수 있다.

이 때 mmonth뒤에 @“july”를 붙이고 싶다면 다음의 함수를 호출한다. NSMutableArray 객체 마지막 index에 anObject가 추가된다. 

```objectivec
- (void)addObject:(ObjectType)anObject;
```

 용례는 다음과 같다.

```objectivec
[mmonth addObject:@"end"];
```

 삭제함수 소개와 용례는 다음과 같다. 

```objectivec
- (void)removeObject:(ObjectType)anObject;
// [mmonth removeObject:@"end"]; 
// mmonth배열에 removeObject메시지를 보낸다. 
// 이 때 parameter는 @"end"이.
```

## NSDictionary & NSMutableDictionary

NSDictionary는 key-value로 이루어진 associtaitons이다. 역시 immutable하여 추가적으로 key와 Value를 업데이트할 수 없고, 정렬되어 있지 않으며 최초 초기화했던 key를 통해 value에 접근할 수 있다. 값이 없는 경우 nil이 반환된다.

### NSDictionary

 선언 함수는 다음과 같다. 

```objectivec
- (instancetype)initWithObjectsAndKeys:(id)firstObject, ...;
```

 ~~여기서 자료형 id는 제네릭 타입으로 어떠한 type도 가능하다는 의미이다.~~

 용례는 다음과 같다.

```objectivec
NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
											@"문용", @"이름", @"1991", @"생년", nil]; //동적할당 및 초기화
```

위 정의된 dictionary에 key값을 통해 접근하는 함수와 용례는 다음과 같다.

```objectivec
- (ObjectType)objectForKey:(KeyType)aKey;
NSLog(@"name: %@", [dic objectForKey:@"이름"]); // name: 문용
```

### NSMutableDictionary

 NSDictionary와 기본적으로 유사하지만 mutable하기 때문에 key-value를 추가하거나 value를 업데이트 할 수 있다. 값이 없는 경우 nil이 반환된다. 
 다음은 선언함수와 용례, 업데이트하는 방법 등이 적힌 코드이다.

```objectivec
// NSDictionary를 통해 NSMutableDictionary를 할당 및 초기화
// + (instancetype)dictionaryWithDictionary:(NSDictionary<KeyType, ObjectType>
NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
[mdic setObject:@"한국" forKey:@"사는곳"]; //key-value추가
NSLog(@"location: %@", [mdic objectForKey:@"사는곳"]); // location: 한국
[mdic setObject: @"분당"] forKey: @"사는곳"];
NSLog(@"location: %@", [mdic objectForKey:@"사는곳"]); // location: 분당
```
