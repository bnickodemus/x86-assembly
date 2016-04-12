//
//  main.cpp
//  int to binary
//
//  Created by Broc Nickodemus on 10/19/15.
//  Copyright © 2015 Broc Nickodemus. All rights reserved.
//

#include <iostream>
#include <cstdio>

using namespace std;

int main(int argc, const char * argv[]) {
    
    int userNum = 0;
    cout << "Please enter a number between 0 and 65535" << endl;
    cin >> userNum;
    if ((userNum < 0) || (userNum > 65535)) {
        cout << "Range Error, you did not enter a number between 0 and 65535" << endl;
    }
    else {
            for (int i = 1 << 15; i > 0; i = i/2) {
                (userNum & i)? printf("1"): printf("0");
            }
        }
    cout << endl << "Success!\n";
    }


