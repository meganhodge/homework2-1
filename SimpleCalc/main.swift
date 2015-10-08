//
//  main.swift
//  SimpleCalc
//
//  Created by Megan Hodge on 10/7/15.
//  Copyright © 2015 Megan Hodge. All rights reserved.
//

import Foundation
import Darwin

// gets the input from the user
func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let result = NSString(data: inputData, encoding:NSUTF8StringEncoding) as! String
    return result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

// converts the string into a double
func convert(incoming:String) -> Double {
    return NSNumberFormatter().numberFromString(incoming)!.doubleValue
}

// calculates the average
func average(numbers: [Double]) -> Double {
    var average: Double?
    for number in numbers {
        average = average! + number
    }
    average = average! / Double(numbers.count)
    return average!
}

// calculates the factorial
func factorial(number: Double) -> Double {
    if number == 0 {
        return 1.0
    } else {
        return number * factorial(number - 1)
    }
}

// calculates basic math operations (add, subtract, multiply, divide, mod, factorial)
func basicMath(numbers: [Double], operation: String) -> Double{
    let firstNumber = numbers[0]
    if operation == "fact" {
        if firstNumber >= 0 {
            return factorial(firstNumber)
        } else {
            return DBL_MAX
        }
    } else {
        let secondNumber = convert(input())
        switch operation {
            case "+":
                return firstNumber + secondNumber
            case "-":
                return firstNumber - secondNumber
            case "*":
                return firstNumber * secondNumber
            case "/":
                return firstNumber / secondNumber
            case "%":
                return firstNumber % secondNumber
            default:
                return DBL_MAX
        }
    }
}

func main() {
    print("Enter an expression separated by returns:")
    
    // gets the numbers inputted and splits them by spaces into an array
    let splitDigits = input().componentsSeparatedByString(" ")
    let operation = input()
    
    // array holds the numbers gathered from the input
    var arrayOfDoubles: [Double] = []
    for number in splitDigits {
        arrayOfDoubles.append(convert(number))
    }
    
    // if there are several numbers in the first line then check the operation
    // if there is one number then complete a basic math operation
    // cannot take the factorial of a negative number
    if arrayOfDoubles.count > 1 {
        if operation == "avg" {
            print(average(arrayOfDoubles))
        } else if operation == "count" {
            print(arrayOfDoubles.count)
        } else {
            print("Cannot complete calculation. Please try again")
        }
    } else {
        let result = basicMath(arrayOfDoubles, operation: operation)
        if result != DBL_MAX {
            print(result)
        } else {
            print("Error!! Try again :)")
        }
        
    }
}

main()

