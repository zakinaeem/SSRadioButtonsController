//
//  RadioGroupView.swift
//  SampleProject
//
//  Created by Zaki Naeem on 14/4/20.
//

import UIKit


struct RadioOptionStyle {
    var titleColorActive: UIColor
    var titleColorInactive: UIColor
    var circleInactive: UIColor
    var circleActive: UIColor
}

struct RadioOption {
    var label: String
    var optionValue: String
}

protocol RadioGroupDelegate {
    func didSelectOption(option: RadioOption, groupId: String)
}

class RadioGroupView: UIView, SSRadioButtonControllerDelegate {

    var groupId = ""
    var options = [RadioOption]()
    var delegate: RadioGroupDelegate?
    var radioStyle = RadioOptionStyle(titleColorActive: .black, titleColorInactive: .lightGray, circleInactive: .lightGray, circleActive: .blue)
    private var buttons = [UIButton]()
    
    
    var groupController = SSRadioButtonsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(withGroupId groupId: String, andOptions options: [RadioOption]) {
        self.init()
        self.groupId = groupId
        self.options = options
        setupRadioButtons()
    }
    
    private func setupRadioButtons() {
        groupController.delegate = self
        groupController.shouldLetDeSelect = false
        
        buttons = options.map { option -> SSRadioButton in
            let button = SSRadioButton(type: .custom)
            button.setTitle(option.label, for: .normal)
            button.titleLabel?.textAlignment = .left
            button.setTitleColor(radioStyle.titleColorInactive, for: .normal)
            button.setTitleColor(radioStyle.titleColorActive, for: .selected)
            button.strokeColor = radioStyle.circleInactive
            button.circleColor = radioStyle.circleActive
            button.translatesAutoresizingMaskIntoConstraints = false
            button.contentHorizontalAlignment = .left
            return button
        }

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        buttons.forEach {
            stackView.addArrangedSubview($0)
            groupController.addButton($0)
        }
        
        let leadingConstraint = NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        addConstraints(constraints)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    func didSelectButton(selectedButton: UIButton?) {
        guard let button = selectedButton, let selectedIndex = buttons.index(of: button), selectedIndex < options.count else {
            return
        }
        
        let selectedOption = options[selectedIndex]
        delegate?.didSelectOption(option: selectedOption, groupId: groupId)
    }
}
