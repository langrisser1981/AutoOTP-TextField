//
//  ContentView.swift
//  AutoOTP-TextField
//
//  Created by 程信傑 on 2022/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var otpText = ""
    @FocusState private var isKeyboardShowing: Bool
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack {
            Text("OTP verification")
                .hLeading()

            HStack {
                ForEach(0 ..< 6) { index in
                    otpTextField(index)
                }
            }
            .background {
//                TextField("", text: $otpText.limit(6))
                TextField("", text: $otpText)
                    .focused($isKeyboardShowing)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .frame(width: 1, height: 1)
                    .opacity(0)
//                    .blendMode(.screen)
                    .onChange(of: otpText) { newValue in
                        if newValue.count > 6 {
                            otpText = String(newValue.prefix(6))
                        }
                    }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
            .padding([.top, .bottom])

            Button {} label: {
                Text("VERIFY")
                    .fontWeight(.bold)
                    .hCenter()
                    .padding(.vertical, 5)
            }
            .padding(.horizontal)
            .disableWithOpacity(otpText.count < 6)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.all)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

//    @ViewBuilder
    func otpTextField(_ index: Int)->some View {
        ZStack {
            if otpText.count > index {
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let char = String(otpText[charIndex])
                Text(char)
            } else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .padding(3)
        .background {
            let isActive = isKeyboardShowing && otpText.count == index
            RoundedRectangle(cornerRadius: 3)
                .stroke(isActive ? (colorScheme == .dark ? .white : .black) : .gray, lineWidth: 0.5)
                .animation(.easeInOut(duration: 0.3), value: isActive)
        }
    }
}

extension View {
    func hLeading()->some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }

    func hCenter()->some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }

    func hTrailing()->some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }

    func disableWithOpacity(_ condition: Bool)->some View {
        self.disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension Binding where Value == String {
    func limit(_ length: Int)->Self {
        if self.wrappedValue.count > length {
            Task { @MainActor in
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
