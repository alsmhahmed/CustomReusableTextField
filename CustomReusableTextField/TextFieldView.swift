//
//  TextFieldView.swift
//  CustomReusableTextField
//
//  Created by alsmh ahmed on 14/01/2025.
//

import SwiftUI


enum TextFieldState {
    case `default`, disabled, focused, typing, filled, error
    var iconColor: Color {
        switch self {
        case .disabled:
            return .gray
        case .filled:
            return .gray
        case .error:
            return .red
        default:
            return .gray
        }
    }
    
    var textColor: Color {
        switch self {
        case .disabled:
            return .gray
        case .filled:
            return .gray
        case .error:
            return .red
        default:
            return .blue
        }
    }
    
    var labelColor: Color {
        switch self {
        case .error:
            return .gray
        case .disabled:
            return .gray
        default:
            return .gray
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .disabled:
            return Color.gray.opacity(0.1)
        case .filled:
            return Color.gray.opacity(0.1)
        case .error:
            return Color.gray.opacity(0.1)
        default: return
                   Color.gray.opacity(0.1)
        }
    }
    
    var borderColor: Color {
        switch self {
        case .focused, .typing:
            return .blue
        case .error:
            return .blue
        default:
            return .clear
        }
    }
    
}
struct TextFeildViewDatsource {
    var placeholder: String = "Value"
    var state: TextFieldState = .default
    var errorLabel: String? = nil
    var label: String? = ""
    var leadingIcon: Image? = nil
    var trailingIcon: Image? = nil
    var leadingIconAction: (() -> Void)? = nil
    var trailingIconAction: (() -> Void)? = nil
}
struct TextFieldView: View {
    @Binding var text: String
    var datasource: TextFeildViewDatsource
    @FocusState private var isFocused: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Label
            if let label = datasource.label, !label.isEmpty {
                Text(label)
                    .font(.caption)
                    .foregroundColor(datasource.state.labelColor)
            }
            
            // TextField Container
            HStack {
                // Leading Icon
                if let leadingIcon = datasource.leadingIcon {
                    Button(action: {
                        datasource.leadingIconAction?()
                    }) {
                        leadingIcon
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(datasource.state.iconColor)
                    }
                }
                
                // TextField
                TextField(datasource.placeholder, text: $text)
                    .disabled(datasource.state == .disabled)
                    .focused($isFocused)
                    .foregroundColor(datasource.state.textColor)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 4)
                
                // Trailing Icon
                if let trailingIcon = datasource.trailingIcon {
                    Button(action: {
                        datasource.trailingIconAction?()
                    }) {
                        trailingIcon
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(datasource.state.iconColor)
                    }
                }
            }
            .padding(.horizontal, 8)
            .background(datasource.state.backgroundColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(datasource.state.borderColor, lineWidth: 1)
            )
            
            // Hint or Error Text
            if let hintText = datasource.errorLabel, datasource.state == .error {
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                    Text(hintText)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
        }
        .animation(.easeInOut, value: datasource.state)
    }
}

#Preview {
    VStack(spacing: 16) {
        // Default State
        TextFieldView(
            text: .constant(""),
            datasource: TextFeildViewDatsource(
                placeholder: "Enter value",
                state: .default,
                label: "Default Label",
                leadingIcon: Image(systemName: "square.fill"),
                trailingIcon: Image(systemName: "square.fill"),
                leadingIconAction: { print("Leading icon tapped - Default") },
                trailingIconAction: { print("Trailing icon tapped - Default") }
            )
        )

        // Disabled State
        TextFieldView(
            text: .constant(""),
            datasource: TextFeildViewDatsource(
                placeholder: "Enter value",
                state: .disabled,
                label: "Disabled Label",
                leadingIcon: Image(systemName: "square.fill"),
                trailingIcon: Image(systemName: "square.fill"),
                leadingIconAction: { print("Leading icon tapped - Disabled") },
                trailingIconAction: { print("Trailing icon tapped - Disabled") }
            )
        )

        // Error State
        TextFieldView(
            text: .constant("Invalid input"),
            datasource: TextFeildViewDatsource(
                placeholder: "Enter value",
                state: .error,
                errorLabel: "Invalid input. Please try again.", label: "Error Label",
                leadingIcon: Image(systemName: "square.fill"),
                trailingIcon: Image(systemName: "square.fill"),
                leadingIconAction: { print("Leading icon tapped - Error") },
                trailingIconAction: { print("Trailing icon tapped - Error") }
            )
        )

        // Focused State
        TextFieldView(
            text: .constant("Focused input"),
            datasource: TextFeildViewDatsource(
                placeholder: "Enter value",
                state: .focused,
                label: "Focused Label",
                leadingIcon: Image(systemName: "square.fill"),
                trailingIcon: Image(systemName: "square.fill"),
                leadingIconAction: { print("Leading icon tapped - Focused") },
                trailingIconAction: { print("Trailing icon tapped - Focused") }
            )
        )

        // Typing State
        TextFieldView(
            text: .constant("Typing..."),
            datasource: TextFeildViewDatsource(
                placeholder: "Enter value",
                state: .typing,
                label: "Typing Label",
                leadingIcon: Image(systemName: "square.fill"),
                trailingIcon: Image(systemName: "square.fill"),
                leadingIconAction: { print("Leading icon tapped - Typing") },
                trailingIconAction: { print("Trailing icon tapped - Typing") }
            )
        )

        // Filled State
        TextFieldView(
            text: .constant("Filled input"),
            datasource: TextFeildViewDatsource(
                placeholder: "Enter value",
                state: .filled,
                label: "Filled Label",
                leadingIcon: Image(systemName: "square.fill"),
                trailingIcon: Image(systemName: "square.fill"),
                leadingIconAction: { print("Leading icon tapped - Filled") },
                trailingIconAction: { print("Trailing icon tapped - Filled") }
            )
        )
    }
    .padding()
    .previewLayout(.sizeThatFits)
}
