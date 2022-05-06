//
//  HomeCard.swift
//  LearningApp
//
//  Created by Brent on 6/5/2022.
//

import SwiftUI

struct HomeCard: View {
    
    private struct Constants {
        
        static let idealCardHeight:CGFloat = 175
        static let idealCardWidth:CGFloat = 335
        static let imageSize = CGSize(width: 116, height: 116)
        
        static let cornerRadius:CGFloat = 10.0
        static let shadowRadius:CGFloat = 5.0
        static let contentItemsSystemImage = "text.book.closed"
        static let durationSystemImage = "clock"
        static let cardColour = Color.white
    }
    
    let title:String
    let description:String
    let contentItemsDescription:String
    let duration:String
    let image:String
    
    
    var body: some View {
        
        
        ZStack {
            backgroundCard()
            // card content
            HStack {
                // image
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: Constants.imageSize.width,
                           height: Constants.imageSize.height)
                Spacer()
                informationContent()
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func backgroundCard() -> some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .shadow(radius: Constants.shadowRadius)
            .foregroundColor(Constants.cardColour)
            .aspectRatio(CGSize(width: Constants.idealCardWidth,
                                height: Constants.idealCardHeight), contentMode: .fit)
    }
    
    @ViewBuilder
    private func informationContent() -> some View {
        
        VStack (alignment: .leading) {
            // title
            // header
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom, 1)
            // description
            Text(description)
                .font(.caption)
                .multilineTextAlignment(.leading)
                .padding(.bottom)
            contentLengthInformation()
        }
        .padding(.leading)
        
    }
    
    @ViewBuilder
    private func contentLengthInformation() -> some View {
        HStack (alignment: .top) {
            // lessons
            Label(contentItemsDescription, systemImage: Constants.contentItemsSystemImage)
                .font(.caption2)
            Spacer()
            // duration
            Label(duration, systemImage: Constants.durationSystemImage)
                .font(.caption2)
        }
        .foregroundColor(.gray)
    }
    
}

struct HomeCard_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = ContentModel()
        let module = (model.modules.first!)
        let content = module.content
        
        HomeCard(title: "Learn \(module.category)",
                 description: content.description,
                 contentItemsDescription: "\(content.lessons.count) Lessons",
                 duration: "\(content.time)",
                 image: content.image)
        .environmentObject(model)
        .previewInterfaceOrientation(.portrait)
    }
}
