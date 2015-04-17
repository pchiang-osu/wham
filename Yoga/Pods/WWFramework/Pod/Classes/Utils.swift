//
//  Utils.swift
//  CorvallisBus
//
//  Created by Rikki Gibson on 10/18/14.
//  Copyright (c) 2014 Rikki Gibson. All rights reserved.
//

import Foundation

func any<S: SequenceType>(seq: S, predicate: S.Generator.Element -> Bool = { t in true }) -> Bool {
    for element in seq {
        if predicate(element) {
            return true
        }
    }
    return false
}

/// Maps a function using the corresponding elements of two sequences.
func mapPairs<S: SequenceType, U>(seq1: S, seq2: S,
    transform: (S.Generator.Element, S.Generator.Element) -> U) -> [U] {
    var result = [U]()
    var generator1 = seq1.generate()
    var generator2 = seq2.generate()
    while let element1 = generator1.next() {
        if let element2 = generator2.next() {
            result.append(transform(element1, element2))
        } else {
            break
        }
    }
    return result
}

extension Array {
    /// Indicates whether there are any elements in self that satisfy the predicate.
    /// If no predicate is supplied, indicates whether there are any elements in self.
    func any(predicate: T -> Bool = { t in true }) -> Bool {
        for element in self {
            if predicate(element) {
                return true
            }
        }
        return false
    }
    
    /// Returns the first element in self that satisfies the given predicate,
    /// or the first element in the sequence if no predicate is provided.
    func first(predicate: T -> Bool = { t in true }) -> T? {
        for element in self {
            if predicate(element) {
                return element
            }
        }
        return nil
    }
    
    /// Takes a transform that returns an optional type and
    /// returns an array containing only the non-nil elements.
    func mapUnwrap<U>(transform: T -> U?) -> [U] {
        var result = [U]()
        
        for t in self {
            if let u = transform(t) {
                result.append(u)
            }
        }
        return result
    }
    
    /// Returns an array of function applications to all pairs of elements.
    /// The size of the resulting array is 1 less than the size of the input array.
    func mapAdjacentElements<U>(transform: (T, T) -> U) -> [U] {
        var result = [U]()
        for i in 0..<(self.count - 1) {
            result.append(transform(self[i], self[i + 1]))
        }
        return result
    }
    
    /// Takes an equality comparer and returns a new array containing all the distinct elemnts.
    func distinct(areEqual: (T, T) -> Bool) -> [T] {
        var result = [T]()
        for t in self {
            // if there are no elements in the result set equal to this element, add it
            if !result.any(predicate: { areEqual($0, t) }) {
                result.append(t)
            }
        }
        return result
    }
    
    func all(predicate: T -> Bool) -> Bool {
        for t in self {
            if !predicate(t) {
                return false
            }
        }
        return true
    }
    
    /// Maps a function using the corresponding elements of two arrays.
    func mapPairs<U>(otherArray: [T], transform: (T, T) -> U) -> [U] {
        var result = [U]()
        let size = self.count < otherArray.count ? self.count : otherArray.count
        for var i = 0; i < size; i++ {
            result.append(transform(self[i], otherArray[i]))
        }
        return result
    }
    
    func tryGet(index: Int) -> T? {
        return self.count > index ? self[index] : nil
    }
    
    func toDictionary<Key, Value>(transform: T -> (Key, Value)) -> [Key : Value] {
        var result = [Key : Value]()
        for t in self {
            let (key, value) = transform(t)
            result[key] = value
        }
        return result
    }
}

extension Dictionary {
    func map<Key2,Value2>(transform: (Key, Value) -> (Key2, Value2)) -> [Key2 : Value2] {
        var resultDictionary = [Key2 : Value2]()
        for (key, value) in self {
            let (key2, value2) = transform(key, value)
            resultDictionary[key2] = value2
        }
        return resultDictionary
    }
    
    func mapUnwrap<Key2, Value2>(transform: (Key, Value) -> (Key2, Value2)?) -> [Key2 : Value2] {
        var resultDictionary = [Key2 : Value2]()
        for (key, value) in self {
            if let (key2, value2) = transform(key, value) {
                resultDictionary[key2] = value2
            }
        }
        return resultDictionary
    }
    
    func tryGet(key: Key?) -> Value? {
        return key == nil ? nil : self[key!]
    }
}