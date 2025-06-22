import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @State private var taskTitle = ""
    var onAdd: (String) -> Void

    var body: some View {
        ZStack {
            // Fullscreen gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                // Top back button
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                            Text("Back")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.indigo)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)

                // Title
                Text("Add New Task")
                    .font(.largeTitle.bold())
                    .padding(.top, 10)

                // Task input field
                HStack {
                    Image(systemName: "pencil")
                        .foregroundColor(.gray)
                    TextField("Enter task title", text: $taskTitle)
                        .autocapitalization(.sentences)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                .padding(.horizontal)

                // Add button
                Button(action: {
                    if !taskTitle.trimmingCharacters(in: .whitespaces).isEmpty {
                        onAdd(taskTitle)
                        dismiss()
                    }
                }) {
                    Text("Add Task")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.indigo)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(radius: 3)
                }
                .padding(.horizontal)

                Spacer()
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(onAdd: { _ in })
    }
}
