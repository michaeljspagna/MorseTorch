//
//  MorseCode.swift
//  MorseTorch
//
//  Created by Michael Spagna on 10/5/20.
//

import Foundation
import AVFoundation

struct MorseTime {
    let dot: UInt32 = 250000
    let dash: UInt32 = 750000
    let space: UInt32 = 250000
    let characterSpace: UInt32 = 500000
    let wordSpace: UInt32 = 1500000
}

class MorseCode{
    let morseTime = MorseTime()
    let ITU: [Character: [String]] = ["a": ["•", "–"],
                           "b": ["–", "•", "•", "•"],
                           "c": ["–", "•", "–", "•"],
                           "d": ["–", "•", "•"],
                           "e": ["•"],
                           "f": ["•", "•", "–", "•"],
                           "g": ["–", "–", "•"],
                           "h": ["•", "•", "•", "•"],
                           "i": ["•", "•"],
                           "j": ["•", "–", "–", "–"],
                           "k": ["–", "•", "–"],
                           "l": ["•", "–", "•", "•"],
                           "m": ["–", "–"],
                           "n": ["–", "•"],
                           "o": ["–", "–", "–"],
                           "p": ["•", "–", "–", "•"],
                           "q": ["–", "–", "•", "–"],
                           "r": ["•", "–", "•"],
                           "s": ["•", "•", "•"],
                           "t": ["–"],
                           "u": ["•", "•", "–"],
                           "v": ["•", "•", "•", "–"],
                           "w": ["•", "–", "–"],
                           "x": ["–", "•", "•", "–"],
                           "y": ["–", "•", "–", "–"],
                           "z": ["–", "–", "•", "•"],
                           "1": ["•", "–", "–", "–", "–"],
                           "2": ["•", "•", "–", "–", "–"],
                           "3": ["•", "•", "•", "–", "–"],
                           "4": ["•", "•", "•", "•", "–"],
                           "5": ["•", "•", "•", "•", "•"],
                           "6": ["–", "•", "•", "•", "•"],
                           "7": ["–", "–", "•", "•", "•"],
                           "8": ["–", "–", "–", "•", "•"],
                           "9": ["–", "–", "–", "–", "•"],
                           "0": ["–", "–", "–", "–", "–"],
                           " ": ["\n"],
                           "ä": ["•", "–", "•", "–"],
                           "á": ["•", "–", "–", "•", "–"],
                           "å": ["•", "–", "–", "•", "–"],
                           "é": ["•", "•", "–", "•", "•"],
                           "ñ": ["–", "–", "•", "–", "–"],
                           "ö": ["–", "–", "–", "•"],
                           "ü": ["•", "•", "–", "–"],
                           "&": ["•", "–", "•", "•", "•"],
                           "'": ["•", "–", "–", "–", "–", "•"],
                           "@": ["•", "–", "–", "•", "–", "•"],
                           ")": ["–", "•", "–", "–", "•", "–"],
                           "(": ["–", "•", "–", "–", "•"],
                           ":": ["–", "–", "–", "•", "•", "•"],
                           ",": ["–", "–", "•", "•", "–", "–"],
                           "=": ["–", "•", "•", "•", "–"],
                           "!": ["–", "•", "–", "•", "–", "–"],
                           ".": ["•", "–", "•", "–", "•", "–"],
                           "-": ["–", "•", "•", "•", "•", "–"],
                           "+": ["•", "–", "•", "–"],
                           "?": ["•", "•", "–", "–", "•", "•"],
                           "/": ["–", "•", "•", "–", "•"]]
    let SOS = ["•", "•", "•", "–", "–", "–", "•", "•", "•"]
    
    func stringToMorseArray(inputMsg: String) -> [String] {
        var morseArray : [String] = []
        for character in inputMsg.lowercased(){
            
            morseArray += ITU[character]!
            if character == " "{
                if morseArray.count >= 2{
                    morseArray.remove(at: morseArray.count - 2)
                }
            }else{
                morseArray.append("|")
            }
        }
        if morseArray.count > 0{
            morseArray.removeLast()
        }
        return morseArray
    }
    
    func morseArrayToMorseString(morseArray: [String]) -> String{
        return morseArray.joined()
    }
    
    func flashMorseString(morseString: String) -> Void{
        for character in morseString{
            switch character {
            case "•":
                toggleTorch(on: true)
                usleep(morseTime.dot)
                toggleTorch(on: false)
            case "–":
                toggleTorch(on: true)
                usleep(morseTime.dash)
                toggleTorch(on: false)
            case "|":
                usleep(morseTime.characterSpace)
            case "\n":
                usleep(morseTime.wordSpace)
            default:
                print("Invalid Morse Value")
            }
            usleep(morseTime.space)
        }
    }
    
    func toggleTorch(on: Bool) -> Void{
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}
