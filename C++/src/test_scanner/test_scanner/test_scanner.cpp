// http://10bun.tv/projects/tiny-calc-1/ 페이지의 상태도를 코드로 옮긴 것이다.
//

#include <string>

using namespace std;

class Input {
public:
	void setText(const string text)
	{
		text_ = text;
		index_ = 0;
	}

	char getNext()
	{
		index_++;
		if (index_ > text_.size()) return 0;
		else return text_.at(index_-1);
	}

	string getText() { return text_; }

	string getErrorMark() 
	{
		string result = "";
		for (int i=0; i<index_-1; i++) result = result + " ";
		result = result + "^";
		return result; 
	}
private:
	string text_;
	int index_ = 0;
};

Input input;

void do_etc(char ch)
{
	switch (ch) {
		case '+': printf("+ sign \n"); break;
		case '-': printf("- sign \n"); break;
		case '*': printf("* sign \n"); break;
		case '/': printf("/ sign \n"); break;
		case '(': printf("( sign \n"); break;
		case ')': printf(") sign \n"); break;

		// 화이트 스페이스 무시
		case 0: break;
		case ' ': break;
		case '\t': break;

		default: {
			printf("\nError \n");
			printf("%s\n", input.getText().c_str());
			printf("%s\n\n", input.getErrorMark().c_str());
		}
	}
}

enum State {STATE_NONE, STATE_INT, STATE_FLOAT};

int main()
{
	input.setText("123 * (3.14 + 567)");

	// 에러를 찾아내는 것을 확인하고 싶을 때 사용
//	input.setText("123 * f (3.14 + 567)");

	string buffer = "";

	State state = STATE_NONE;

	while (true) {
		char ch = input.getNext();

		switch (state) {
			case STATE_NONE: {
				switch (ch) {
					case '0':
					case '1':
					case '2':
					case '3':
					case '4':
					case '5':
					case '6':
					case '7':
					case '8':
					case '9':
					{
						buffer = buffer + ch;
						state = STATE_INT;
					} break;

					default: do_etc(ch); break;
				}
			} break;

			case STATE_INT: {
				switch (ch) {
					case '0':
					case '1':
					case '2':
					case '3':
					case '4':
					case '5':
					case '6':
					case '7':
					case '8':
					case '9':
					{
						buffer = buffer + ch;
					} break;

					case '.': {
						buffer = buffer + ch;
						state = STATE_FLOAT;
					} break;

					default: {
						printf("integer: %s \n", buffer.c_str());
						buffer = "";
						do_etc(ch); 
						state = STATE_NONE;
					} break;
				}
			} break;

			case STATE_FLOAT: {
				switch (ch) {
					case '0':
					case '1':
					case '2':
					case '3':
					case '4':
					case '5':
					case '6':
					case '7':
					case '8':
					case '9':
					{
						buffer = buffer + ch;
					} break;


					default: {
						printf("float: %s \n", buffer.c_str());
						buffer = "";
						do_etc(ch); 
						state = STATE_NONE;
					} break;
				}
			} break;
		}

		if (ch == 0) break;
	}
}