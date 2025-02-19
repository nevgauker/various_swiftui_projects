//
//  DetailView.swift
//  Bookworm
//
//  Created by Rotem Nevgauker on 05/11/2023.
//
import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    let book: Book

    func deleteBook() {
        moc.delete(book)
        
        // uncomment this line if you want to make the deletion permanent
        // try? moc.save()
        dismiss()
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
}

//#Preview {
//    let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
//    let book = Book(context: moc)
//    book.title = "Test book"
//    book.author = "Test author"
//    book.genre = "Fantasy"
//    book.rating = 4
//    book.review = "This was a great book; I really enjoyed it."
//    
//    return NavigationView {
//        DetailView(book: book)
//    }
//}
