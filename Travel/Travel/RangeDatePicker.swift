import SwiftUI

struct RangeDatePicker: View {
    
    @Binding  var startDate:Date
    @Binding  var endDate:Date
    
    var bounds: Range<Date>? {
        if startDate > endDate {
            return nil
        }
        return startDate..<endDate
        
    }
    
    var body: some View {
        VStack {
            DatePicker("Start Date", selection: $startDate, displayedComponents: [.date])
                .onChange(of:startDate){
                    if endDate < startDate{
                        endDate =  Calendar.current.date(byAdding: .day, value: 3, to: startDate) ?? startDate
                    }
                }
            DatePicker("End Date", selection: $endDate, displayedComponents: [.date])
            Spacer()
        }
        .padding()
    }
}


#Preview {
    RangeDatePicker(startDate: .constant(.now), endDate: .constant(.now))
        .navigationTitle("Results")
}
