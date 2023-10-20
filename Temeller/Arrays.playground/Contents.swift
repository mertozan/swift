import UIKit

//Array

var myFavoriteMovies = ["Pulp Fiction","Kill Bill","Reservoir Dogs",5,true] as [Any]

//as -> casting
//any -> any object = Her türlü veriyi alır. Any olan dizilerde String metotlarını kullanamayız.

//index
var myStringArray = ["Test6","Test2","Test1","Test4"]

myStringArray[0].uppercased()
myStringArray.description.lowercased()
myStringArray.count     // Eleman sayısı
myStringArray[myStringArray.count - 2]  //
myStringArray.last      // Son eleman
myStringArray.sort()    // Sırala


var myNumberArray = [1,2,3,4,5,6,7,1,2,3]
myNumberArray.append(8) // Ekle

myNumberArray[0] = 15   // Veri değiştir

//Set = İçinde aynı veriden 1 tane olur. Sırasızdır

//Unordered collection, unique elements

var mySet : Set = [1,2,3,4,5,1,2]
var myStringSet : Set = ["a","b","c","a"]

var myInternetArray = [1,2,3,1,2,5,6,2,1]
var myInternetSet = Set(myInternetArray)
print(myInternetArray)
print(myInternetSet)

var mySet1 : Set = [1,2,3]
var mySet2 : Set = [3,4,5]

var mySet3 = mySet1.union(mySet2) // 2 set birleştirip sadeleştirme
print(mySet3)

//Dictionary
//key-value pairing

var myFavoriteDirectors = ["Pulp Fiction" : "Tarantino","Lock, Stock" : "Guy Ritchie","The Dark Knight": "Christopher Nolan"]

myFavoriteDirectors["Pulp Fiction"]
myFavoriteDirectors["Pulp Fiction"] = "Quentin Tarantino"
print(myFavoriteDirectors)

var myDictionary = ["Run" : 100, "Swim" : 200, "Basketball" : 300]
myDictionary["Run"]







