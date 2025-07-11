//
//  ContentView.swift
//  BinarySum
//
//  Created by Moddeeeeeeep on 10.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var terms: [(value: String, radix: Int)] = [
        ("", 10),
        ("", 10)
    ]
    @State private var resultRadix = 10
    @State private var result = ""
    @State private var errorMessage = ""
    
    let availableRadixes = Array(2...36)
    var body: some View {
        VStack(spacing: 12) {
            Text("BinarySum")
                .font(.headline)
                .padding(.top, 8)
            ForEach(0..<terms.count, id: \ .self) { idx in HStack(spacing: 8) {
                    TextField("Число", text: $terms[idx].value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 90)
                    Picker("Осн.", selection: $terms[idx].radix) {
                        ForEach(availableRadixes, id: \ .self) { radix in
                            Text("\(radix)")
                        }
                    }
                    .frame(maxWidth: 90)
                }
            }
            HStack(spacing: 8) {
                Button("+") {
                    terms.append(("", 10))
                }
                .frame(width: 30)
                if terms.count > 1 {
                    Button("-") {
                        terms.removeLast()
                    }
                    .frame(width: 30)
                }
            }
            
            HStack(spacing: 8) {
                Text("Результат в системе счисления:")
                Picker("Система счисления", selection: $resultRadix) {
                    ForEach(availableRadixes, id: \ .self) { radix in
                        Text("\(radix)")
                    }
                    
                }
                .frame(maxWidth: 130)
            }
            
            
            Button("Реультат") {
                calculateSumMulti()
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .clipShape(Capsule())
            .frame(maxWidth: 180)
            .padding(6)
            if !result.isEmpty {
                Text("Результат: \(result)")
                    .font(.title3)
                    .padding(4)
                
                Button("Скопировать результат"){
                    copyResult()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .clipShape(Capsule())
            }
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(4)
            }
            Spacer()
        }
        .frame(maxWidth: 260)
        .padding(8)
    }
    
    func calculateSumMulti() {
        errorMessage = ""
        result = ""
        var sum = 0
        for (value, radix) in terms {
            guard let num = Int(value, radix: radix) else {
                errorMessage = "Ошибка: некорректное число \"\(value)\" для основания \(radix)"
                return
            }
            sum += num
        }
        result = String(sum, radix: resultRadix).uppercased()
    }
    
    func copyResult()
    {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(result, forType: .string)
    }
}
