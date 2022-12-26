import Button from './Button';
import Dice from './Dice';

// 아래와 같이 하면 컴포넌트 만들기 완성
function App() {
  return (
    <div >
      <div>
        {/* 컴포넌트 함수에서 따로 가공하지 않고 
        단순히 보여주기만 할 모습은 이렇게 children prop을 사용할 수 있음
        */}
        <Button>"던지기"</Button>
        <Button>"처음부터"</Button>
      </div>
        <Dice color="red" num= {1}/>
      
    </div>
  );
}

export default App; //위의 컴포넌트들을 다른 곳에서 사용할 수 있도록 선언.
