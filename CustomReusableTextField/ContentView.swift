//
//  ContentView.swift
//  CustomReusableTextField
//
//  Created by alsmh ahmed on 14/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    @State private var fieldState: TextFieldState = .default
    @State var errorLabel: String = ""
    var body: some View {
        VStack {
            TextFieldView(
                text: .constant(""),
                datasource: TextFeildViewDatsource(
                    placeholder: "Enter value",
                    state: fieldState,
                    errorLabel: errorLabel, label: "Default Label",
                    leadingIcon: Image(systemName: "magnifyingglass"),
                    trailingIcon: Image(systemName: "square"),
                    leadingIconAction: { print("Leading icon tapped - Default") },
                    trailingIconAction: { print("Trailing icon tapped - Default") }
                )
            )
            .onTapGesture {
                fieldState = .focused
            }
            Button {
                // run api
                // to error
                fieldState = .error
                errorLabel = "Error"
            } label: {
                Text("Error")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
