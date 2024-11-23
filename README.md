# ACFancyButton
A customizable button with dynamic color transitions

![2024-11-23 18-59-25 2024-11-23 19_01_04](https://github.com/user-attachments/assets/8ed1bcf6-8de0-4f85-a629-5b40a2aae4da)


## Installing

Xcode > File > Swift Packages > Add Package Dependency

`https://github.com/albertgh/ACFancyButton.git`


## Usage

```swift
import ACFancyButton

// Create an ACFancy button instance
let fButton = ACFancyButton()
fButton.tintColor = .white
let btnImgConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
let btnImg = UIImage(systemName: "tray.fill", withConfiguration: btnImgConfig)
fButton.imageView.image = btnImg

// Add the button to your view and set up its layout
self.view.addSubview(fButton)
fButton.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    fButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
    fButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
    fButton.widthAnchor.constraint(equalToConstant: 150),
    fButton.heightAnchor.constraint(equalToConstant: 100)
])

// Start the button's animation when needed
fButton.startAnimation()

```

## Customization

```swift
// Customize the button's corner radius
fButton.buttonCornerRadius = 5.0

// Set the duration for each animation loop
fButton.animationDuration = 2.0

// Customize your own color schemes 
// (Note: UIColor.hexStringCGColor(hex:) is a custom utility method 
// and is not included in this package)
let bakedColors: [[CGColor]] = [
    [UIColor.hexStringCGColor(hex: "fc1414"),
     UIColor.hexStringCGColor(hex: "142bfc")],
    [UIColor.hexStringCGColor(hex: "d514fc"),
     UIColor.hexStringCGColor(hex: "fc5614")],
    [UIColor.hexStringCGColor(hex: "99f714"),
     UIColor.hexStringCGColor(hex: "edfc14")],
    [UIColor.hexStringCGColor(hex: "369c9e"),
     UIColor.hexStringCGColor(hex: "6e2d6b")]
]
fButton.bakedColors = bakedColors

```
