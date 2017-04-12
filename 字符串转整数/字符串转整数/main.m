//
//  main.m
//  字符串转整数
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


int main(int argc, char * argv[]) {
   
    char * str = "2147483648";

    
    int result = 0;
    int flag= 1;
    
    int count  = (int)strlen(str);
    
    //字符串为空直接返回0
    if (count <= 0) {
        return 0;
    }
    
    int i = 0;
    
    //过滤掉字符串前面的空格
    while (i < count && str[i] == ' ') {
        i++;
    }
    
    //判断符号位
    if (str[i] =='+' ) {
        flag = 1;
        i++;
    }else if (str[i] == '-'){
        
        flag = -1;
        i++;
    }
    
    
    while (i < count && str[i] >= '0' && str[i] <= '9') {
        
        //判断数组越界
        if (result > INT_MAX / 10 || (result == INT_MAX / 10 && str[i] - '0' > 7)) {
            return (flag == 1) ? INT_MAX : INT_MIN;
        }
       
        result  = result * 10 + (str[i++] - '0');
    }
    
    
    
    
    result = result * flag;
 
    
    return 0 ;
}


