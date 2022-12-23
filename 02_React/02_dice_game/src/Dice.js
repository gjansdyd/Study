import diceBlue01 from "./assets/dice-blue-1.svg"

function Dice() {
  return <img src={diceBlue01} alt="주사위"/>  //만약 src속성에 바로 파일 경로를 입력하면 안 되니까 주의
}

export default Dice;