# ACFancyButton
A customizable button with dynamic color transitions

![example](https://github.com/user-attachments/assets/3444ee30-e44c-4c54-be00-1c299070a8ee)


## Installing

Xcode > File > Swift Packages > Add Package Dependency

```
https://github.com/albertgh/ACFancyButton.git
```
Check out example project here:  [ACFancyButtonExample-iOS.zip](https://github.com/user-attachments/files/17878726/ACFancyButtonExample-iOS.zip)


## Usage

```swift
import ACFancyButton

// Create an ACFancy button instance
let fButton = ACFancyButton()

button.titleView.text = "ACFancyButton"
button.titleView.font = UIFont.systemFont(ofSize: 24, weight: .bold)
button.titleView.textColor = .white

/**
 // You should only set one of imageView or titleView.
button.tintColor = .white
let btnImgConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
let btnImg = UIImage(systemName: "tray.fill", withConfiguration: btnImgConfig)
button.imageView.image = btnImg
 */


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
// If the glass effect is not needed, you can replace it with another effect.
button.visualEffectView.effect = UIBlurEffect(style: .systemUltraThinMaterial)

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
