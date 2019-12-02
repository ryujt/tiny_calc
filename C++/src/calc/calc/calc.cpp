#include <iostream>
#include <string>
#include "calculator.hpp"

using namespace std;

int main()
{
	Calculator calculator;

	string text;
	//text = "1 + 3 * 2";
	//text = "1 + 3 * 2 - 1 + 5";
	//text = "2 * (1.5 + 0.5)";
	//text = "(1 + 2) * (1.5 + 0.5)";

	while (true) {
		getline(cin, text);
		if (text == "q") break;
		printf("%s = %g \n", text.c_str(), calculator.execute(text));
	}
}