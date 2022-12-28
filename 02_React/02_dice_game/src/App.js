import {useState } from 'react';
import Button from './Button';
import Dice from './Dice';

// 아래와 같이 하면 컴포넌트 만들기 완성
function App() {
  // useState 함수. 초깃값 설정 후 배열의 형태로 받음.
  const [num, setNum] = useState(1);
  // num == State값
  // setNum == setter함수
  // 보통은 State값 앞에 set을 붙여 만든다

  function random(n) {
    // Math.random()함수는 0~1사이의 난수값
    return Math.ceil(Math.random() * n);
  }
  const handleRollClick = () => {
    const nextNum = random(6);
    setNum(nextNum);
  };

  const handleClearClick = () => {
    setNum(1);
  };
  return (
    <div >
      <div>
        {/* 컴포넌트 함수에서 따로 가공하지 않고 
        단순히 보여주기만 할 모습은 이렇게 children prop을 사용할 수 있음
        */}
        <Button onClick = { handleRollClick }>"던지기"</Button>
        <Button onClick = { handleClearClick} >"처음부터"</Button> 
      </div>
        <Dice color="red" num= {num}/>
      
    </div>
  );
}
//State 변수 같은 것.

export default App; //위의 컴포넌트들을 다른 곳에서 사용할 수 있도록 선언.
