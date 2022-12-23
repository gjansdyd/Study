import { render } from '@testing-library/react';
import { Fragment } from 'react';
import ReactDOM from 'react-dom/client';
import App from './App'

const root = ReactDOM.createRoot(document.getElementById('root'));

root.render(
  <App />
);


// 리액트 컴포넌트
// 1. 함수 이름의 첫 글자가 꼭 대문자여야 함.
// 2. JSX문법으로 만든 리액트 엘리먼트를 리턴해주어야 함.
// function Hello() {
//   return <h1>안녕 리액트</h1>;
// }

// const element = (
//   <>
//     <Hello/>
//     <Hello/>
//     <Hello/>
//   </>
// );
// root.render(
//   element
// );

//실습2
// const WINS = {
//   rock: 'scissor',
//   scissor: 'paper',
//   paper: 'rock',
// };

// function getResult(left, right) {
//   if (WINS[left] === right) return '승리';
//   else if (left === WINS[right]) return '패배';
//   return '무승부';
// }

// function handleClick() {
//   console.log('가위바위보!');
// }

// const me = 'rock';
// const other = 'scissor';

// root.render(
//   <>
//     <h1>가위바위보</h1>
//     <h2>{getResult(me, other)}</h2>
//     <button onClick={handleClick}>가위</button>
//     <button onClick={handleClick}>바위</button>
//     <button onClick={handleClick}>보</button>
//   </>
// );


// DOM요소들 중에서 root라는 id속성을 가진 요소를 가지고 온다는 것.
// index.html파일에 작성된 div태그
// const root = ReactDOM.createRoot(document.getElementById('root')); 

// const product = "MacBook";
// const imageUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHWRDSm8QPyIXA9vF-1LtQC6tF65FrU3ZjI1VZJFMGJQ&s"
// function handleClick() {
//   alert("곧 도착합니다");
// }
// root.render(
//   <>
//   <h1>나만의 {product.toUpperCase()} 주문하기</h1>
//   <img src={imageUrl} alt="제품 사진"/>
//   <button onClick={handleClick}>확인</button>
//   </>
// );


//실습
// root.render(
//   <Fragment>
//   <h1 id="title">가위바위보</h1>
//   <button className="hand">가위</button>
// <button className="hand">바위</button>
// <button className="hand">보</button>
//   </Fragment>
// );








//render: 화면을 그린다
//react에서는 이 render함수로 html태그를 만들어 준다.
//render argument == html코드. JSX문법.
// root.render(
//   <h1>안녕, 리액트!</h1>
// );

// 원래 html의 class가 className
// js에서 class가 있기 때문
// root.render(
//   <p className='hello'>안녕 리액트2</p>
// );

// 마찬가지로 for속성 못 쓴다
// root.render(
//   <form>
//     {/* <label for="name">이름</label> 이렇게 쓰지 못한다 */} 
//     <label htmlFor='name'>이름</label>
//     <input id="name" type="text" onBlur="" onFocus="" onMouseDown=""></input>
//   </form>
// ); 

// root.render(
  // 여기 div태그 사용하고 싶지 않으면? 
  // <div> 
  //   <p>안녕 </p>
  //   <p>리액트야안녕 </p>
  // </div>
// 프래그먼트를 사용한다
  // <Fragment>
  //     <p>안녕 </p>
  //     <p>리액트야안녕 </p>
  // </Fragment>
// );