# SSCD_Function_Parser
# SS&CD Project

## Steps to run
Make sure LEX and YACC is installed

To install on Ubuntu using apt package manager:
```sh
sudo apt-get install bison flex
```

To run the program:
```sh
./run.sh
```

## Example
### Input file
```c
#include <stdio.h>
int a = 10;
int b = 20;

int add(int, int);

void main()
{
    int sum = add(a, b);
    printf("The sum is %d", sum);
}

int add(int a, int b)
{
    return (a + b);
}
```
### Execution
![Execution Terminal](https://github.com/rottiakash/SSCD_Function_Parser/raw/master/markdown/Screen%20Shot%202020-04-09%20at%2012.48.47.png "Execution Terminal")
### Output
```
Function Declaration Parsed
Function Name: add
Function Return Type: int
Number of Parameter:2
Parameter of type int
Parameter of type int



Function Defination Parsed
Function Name: main
Function Return Type: void
Number of Parameter:0

Function Body:{
    int sum = add(a, b);
    printf("The sum is %d", sum);
}


Function Defination Parsed
Function Name: add
Function Return Type: int
Number of Parameter:2
Parameter b of type int
Parameter a of type int

Function Body:{
    return (a + b);
}
```
