import SwiftUI
import CoreData

struct ToDoListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default
    ) private var tasks: FetchedResults<TaskEntity>

    @State private var showAddView = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                // Header with title and add button
                HStack {
                    Text("My Tasks")
                        .font(.largeTitle.bold())
                    Spacer()
                    Button {
                        showAddView = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.indigo)
                            .shadow(radius: 2)
                    }
                }
                .padding(.top, 40)
                .padding(.horizontal)

                // Task list
                List {
                    ForEach(tasks) { task in
                        HStack {
                            Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(task.isDone ? .green : .gray)
                            Text(task.title ?? "")
                                .strikethrough(task.isDone)
                                .foregroundColor(task.isDone ? .gray : .primary)
                            Spacer()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 1)
                        .padding(.vertical, 4)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .swipeActions(edge: .leading) {
                            Button {
                                toggleDone(task)
                            } label: {
                                Label("Done", systemImage: "checkmark")
                            }
                            .tint(.green)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                delete(task)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }
        }
        .sheet(isPresented: $showAddView) {
            AddTaskView { title in
                addTask(title)
            }
        }
    }

    // MARK: - Core Data Methods

    func addTask(_ title: String) {
        let newTask = TaskEntity(context: viewContext)
        newTask.title = title
        newTask.isDone = false
        saveContext()
    }

    func toggleDone(_ task: TaskEntity) {
        task.isDone.toggle()
        saveContext()
    }

    func delete(_ task: TaskEntity) {
        viewContext.delete(task)
        saveContext()
    }

    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("❌ Error saving context:", error.localizedDescription)
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
