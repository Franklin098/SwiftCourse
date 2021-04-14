import UIKit

var str = "Hello, playground"

let arrayOfNumbers = [1,5,3,6,2,7,23,34]

var sum = 0

for number in arrayOfNumbers {
    sum += number
}

print(sum)

// Inclusive        for number in 1...10
// Exclusive        for number in 1..<10
// Diferent step    for number in 1..<10 where number % 3 == 0

for number in 1...10 where number % 3 == 0{
    print(number)
}

// Autside Parameter name   Outside Parameter name
// func beerSong(withThisMayBottles totalNumberOfBottles : Int) ->String{
// func beerSong(_ totalNumberOfBottles : Int) ->String{
// _  no necesito nombre de parametro

func beerSong(withThisMayBottles totalNumberOfBottles : Int) ->String{
    var lyrics:String = ""
    
    for i in (1...totalNumberOfBottles).reversed(){
        let line = "\(i) bottles of beer on the wall, \(i) bottles of beer. \n"
        + "Take one down and pass it around, \(i-1) bottles of beer on the wall. \n\n"
        
        lyrics += line
    }
    
    lyrics += "No more bottles of beer on the wall, no more bottles of beer. \n"
    + "Go to the store and boy some  more, \(totalNumberOfBottles) bottles of beer on the wall. \n"
    return lyrics
}


print(beerSong(withThisMayBottles:  35))
