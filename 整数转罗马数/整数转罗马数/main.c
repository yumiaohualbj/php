//
//  main.c
//  整数转罗马数
//
//  Created by mac on 2017/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[]) {
    // insert code here...
   
   
    return 0;
}


char* intToRoman(int num) {
    num = 10;
    if(num <1 || num >3999) return "";
    char * digits[10] = {"","I","II","III","IV","V","VI","VII","VIII","IX"};
    char * tens[10] = {"","X","XX","XXX","XL","L","LX","LXX","LXXX","XC"};
    char * hundreds[10] = {"","C","CC","CCC","CD","D","DC","DCC","DCCC","CM"};
    char * thousands[4] = {"","M","MM","MMM"};
    
   char * result = malloc(20 * sizeof(char));
    
    result = strcpy(result,thousands[num/1000]);
    result =  strcpy(result,hundreds[(num%1000)/100]);
    result = strcpy(result,tens[(num%100)/10]);
    result =  strcpy(result,digits[num%10]);
 
  
    return result;
    //   return thousands[num/1000]+hundreds[(num%1000)/100]+tens[(num%100)/10]+digits[num%10];
}
