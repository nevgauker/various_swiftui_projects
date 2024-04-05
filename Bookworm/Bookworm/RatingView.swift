//
//  RatingView.swift
//  Bookworm
//
//  Created by Rotem Nevgauker on 04/11/2023.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating:Int
    
    var label = ""
    var maximumRating = 5
    
    var offImage:Image?
    var onImage = Image(systemName:"star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    func image(for number:Int) -> Image{
        if number>rating {
            return offImage ?? onImage
        }else{
            return onImage
        }
    }
    
    var body: some View {
        HStack{
            if label.isEmpty == false{
                Text(label)
            }
            ForEach(1..<maximumRating+1,id: \.self){ number in
                image(for: number)
                    .foregroundColor(number>rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
