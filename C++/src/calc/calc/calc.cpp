#include <iostream>
#include "calculator.hpp"

int main()
{
	Calculator calculator;

	//string text = "1 + 3 * 2";
	string text = "1 + 3 * 2 - 1 + 5";
	//string text = "2 * (1.5 + 3)";
	printf("%s = %g", text.c_str(), calculator.execute(text));
}