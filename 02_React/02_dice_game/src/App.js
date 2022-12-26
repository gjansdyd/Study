import Dice from './Dice';

// 아래와 같이 하면 컴포넌트 만들기 완성
function App() {
  return (
    <div>
      <Dice color="red" num= {1}/>
    </div>
  );
}

export default App; //위의 컴포넌트들을 다른 곳에서 사용할 수 있도록 선언.
