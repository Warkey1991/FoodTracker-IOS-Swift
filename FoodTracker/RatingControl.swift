//
//  RatingControl.swift
//  FoodTracker
//
//  Created by songyuanjin on 2018/12/6.
//  Copyright © 2018 songyuanjin. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    //MARK: Properities
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var startCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    //MARK: initialzation
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupButtons()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    @objc func ratingButtontapped(button:UIButton) {
        guard let index = ratingButtons.index(of:button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedRating = index + 1
        print("selectedRating : \(selectedRating)" ,"rating: \(rating)")
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    
    }
    //MARK: Private methods
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledstar", in:bundle, compatibleWith:self.traitCollection)
        let emptyStar = UIImage(named: "emptystar", in:bundle, compatibleWith:self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in:bundle, compatibleWith:self.traitCollection)
        
        for _ in 0..<startCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            //Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            button.addTarget(self, action: #selector(ratingButtontapped(button:)), for: .touchUpInside)
            //Add the button to the stack
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
