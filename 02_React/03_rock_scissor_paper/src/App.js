import Button from './Button';
import HandButton from './HandButton';
import HandIcon from './HandIcon';
import { compareHand, generateRandomHand } from './utils';
import { useState } from 'react'

function getResult(me, other) {
  const comparison = compareHand(me, other);
  if (comparison > 0) return '승리';
  if (comparison < 0) return '패배';
  return '무승부';
}

function App() {
  // hand와 otherHand를 state로 바꿔 주세요
  const hand = 'rock';
  const otherHand = 'scissor';
  const [num, setNum] = useState(1);
  
  const handleButtonClick = (nextHand) => {
    hand = nextHand;
    otherHand = generateRandomHand();
  };

  const handleClearClick = () => {
    // hand와 otherHand의 값을 'rock' 으로 바꿔주세요
    hand = "rock";
    otherHand = "rock";
  };

  return (
    <div>
      <Button onClick={handleClearClick}>처음부터</Button>
      <p>{getResult(hand, otherHand)}</p>
      <div>
        <HandIcon value={hand} />
        VS
        <HandIcon value={otherHand} />
      </div>
      <div>
        <HandButton value="rock" onClick={handleButtonClick} />
        <HandButton value="scissor" onClick={handleButtonClick} />
        <HandButton value="paper" onClick={handleButtonClick} />
      </div>
    </div>
  );
}

export default App;
