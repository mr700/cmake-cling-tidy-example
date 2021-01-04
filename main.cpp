#include <iostream>

using namespace std;

int main()
{
    cout << "Hello World!" << endl;
    cout << "\ncompiler version " << __VERSION__;
#ifndef NDEBUG
    cout << ", with debug info/stl checks (no NDEBUG defined).";
#endif
    cout << endl;
    return 0;
}
