import javax.swing.JOptionPane;

// 화면에 보여줄 결과를 저장할 변수들
String inputInfix = "";
String postfixResult = "";
String evalResult = "";

void setup() {
  size(600, 300);
  background(240);
  
  // 1. 실행하자마자 입력 창(Popup) 띄우기
  inputInfix = JOptionPane.showInputDialog(null, "중위 표기법 수식을 입력하세요 (예: 3+4*2 또는 A+B*C):", "후위 표기법 변환기", JOptionPane.QUESTION_MESSAGE);
  
  // 취소를 누르거나 빈 값이면 종료 처리
  if (inputInfix == null || inputInfix.trim().isEmpty()) {
    inputInfix = "Input cancelled.";
    postfixResult = "";
    evalResult = "";
    return;
  }
  
  // 공백 제거
  inputInfix = inputInfix.replaceAll("\\s+", "");
  
  // 2. 후위 표기법으로 변환
  postfixResult = infixToPostfix(inputInfix);
  
  // 3. 만약 모두 숫자와 연산자로 이루어진 식이라면 계산도 수행
  if (isNumericExpression(inputInfix)) {
    float result = evaluatePostfix(postfixResult);
    evalResult = str(result);
  } else {
    evalResult = "Skipped (contains letters)";
  }
}

void draw() {
  background(255);
  
  // 타이틀 (영어)
  fill(40);
  textSize(20);
  text("Infix to Postfix Conversion Result", 30, 40);
  
  stroke(200);
  line(30, 55, 570, 55);
  
  // 결과 출력
  textSize(16);
  fill(0);
  
  text("• Input (Infix):", 30, 95);
  fill(0, 102, 204);
  text(inputInfix, 220, 95);
  
  fill(0);
  text("• Postfix Expression:", 30, 145);
  fill(204, 102, 0);
  text(postfixResult, 220, 145);
  
  fill(0);
  text("• Evaluation Result:", 30, 195);
  fill(0, 153, 76);
  text(evalResult, 220, 195);
  
  // 하단 안내
  fill(120);
  textSize(12);
  text("To enter a new expression, close the window and press Run (Ctrl + R).", 30, 260);
}

// 중위 표기법 -> 후위 표기법 변환 함수 (Shunting-yard Algorithm)
String infixToPostfix(String infix) {
  StringBuilder output = new StringBuilder();
  ArrayList<Character> stack = new ArrayList<Character>();
  
  for (int i = 0; i < infix.length(); i++) {
    char c = infix.charAt(i);
    
    if (Character.isLetterOrDigit(c)) {
      output.append(c).append(" ");
    }
    else if (c == '(') {
      stack.add(c);
    }
    else if (c == ')') {
      while (!stack.isEmpty() && stack.get(stack.size() - 1) != '(') {
        output.append(stack.remove(stack.size() - 1)).append(" ");
      }
      if (!stack.isEmpty() && stack.get(stack.size() - 1) == '(') {
        stack.remove(stack.size() - 1);
      }
    }
    else if (isOperator(c)) {
      while (!stack.isEmpty() && precedence(stack.get(stack.size() - 1)) >= precedence(c)) {
        output.append(stack.remove(stack.size() - 1)).append(" ");
      }
      stack.add(c);
    }
  }
  
  while (!stack.isEmpty()) {
    output.append(stack.remove(stack.size() - 1)).append(" ");
  }
  
  return output.toString().trim();
}

// 후위 표기법 계산 함수
float evaluatePostfix(String postfix) {
  ArrayList<Float> stack = new ArrayList<Float>();
  String[] tokens = postfix.split(" ");
  
  for (String token : tokens) {
    if (token.length() == 0) continue;
    
    if (Character.isDigit(token.charAt(0))) {
      stack.add(Float.parseFloat(token));
    } 
    else if (isOperator(token.charAt(0))) {
      float b = stack.remove(stack.size() - 1);
      float a = stack.remove(stack.size() - 1);
      float res = 0;
      
      char op = token.charAt(0);
      if (op == '+') res = a + b;
      else if (op == '-') res = a - b;
      else if (op == '*') res = a * b;
      else if (op == '/') res = a / b;
      
      stack.add(res);
    }
  }
  
  return stack.isEmpty() ? 0 : stack.get(0);
}

boolean isOperator(char c) {
  return c == '+' || c == '-' || c == '*' || c == '/';
}

int precedence(char c) {
  if (c == '+' || c == '-') return 1;
  if (c == '*' || c == '/') return 2;
  return 0;
}

boolean isNumericExpression(String s) {
  for (int i = 0; i < s.length(); i++) {
    char c = s.charAt(i);
    if (Character.isLetter(c)) return false;
  }
  return true;
}
