#include <cstring>
#include <iostream>
using std::cin;
using std::cout;

void reverse(char string[], int n) {
  for (int i = n - 1; i >= 0; i--) {
    cout << string[i];
  }
}

int main() {
  char text[100];
  cout << "Enter some sentence: ";
  cin.getline(text, 100);
  int n = strlen(text);
  cout << "\n";
  reverse(text, n);
  return 0;
}
