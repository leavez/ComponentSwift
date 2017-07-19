//
//  CenterLayoutComponent+Convenience.swift
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

import UIKit

extension InsetComponent {
}

public class CenterLayoutComponent: __CenterLayoutComponent {

    @nonobjc
    public init?(centering: CenterLayoutComponentCenteringOptions = .XY,
                 sizing: CenterLayoutComponentSizingOptions = .minimumXY,
                 child: Component?, size: LayoutSize? = nil) {
      super.init(__centeringOptions: centering, sizingOptions: sizing, child: child, size: size)
    }
}

extension TextComponent {

    public convenience init(_ textAttributes: TextAttributes,
                            viewAttributes: ViewAttributeMap? = nil,
                            options: TextComponentOptions? = nil,
                            size: LayoutSize? = nil) {
        self.init(__textAttributes: textAttributes, viewAttributes: viewAttributes, options: options, size: size)
    }
}

extension TextAttributes {

    public convenience init(_ attributedString: NSAttributedString?) {
        self.init()
        self.attributedString = attributedString
    }
    public convenience init(_ string: String?, attrs: [NSAttributedStringKey : Any], numberOfLines:Int = 0) {
        self.init()
        self.attributedString = string.map{ NSAttributedString(string: $0, attributes: attrs) }
        self.maximumNumberOfLines = numberOfLines
    }
    public convenience init(_ string: String?, font: UIFont = UIFont.systemFont(ofSize: 14), color: UIColor = .black) {
        self.init()
        self.attributedString = string.map{ NSAttributedString(string: $0, attributes: [.font: font, .foregroundColor: color]) }
    }
}




extension UIControlState: Hashable {
    public var hashValue: Int {
        return Int(self.rawValue)
    }
}

extension ButtonComponent {

    public struct Attribute: Builder {
        public var titles: [UIControlState: String?]?
        public var titleColors: [UIControlState: UIColor?] = [.normal:.black]
        public var images: [UIControlState: UIImage?]?
        public var backgroundImages:[UIControlState: UIImage?]?
        public var titleFont: UIFont = .systemFont(ofSize: 15)
        public var selected: Bool = false
        public var enabled: Bool = true
        public var accessibilityLabel: String?
        public init() {}
    }


    public convenience init(title: (String, UIColor, UIFont)? = nil,
                            image: UIImage? = nil,
                            action: Selector?,
                            size: LayoutSize?,
                            viewAttributes: ViewAttributeMap? = nil,
                            accessibilityLabel: String? = nil) {
        let attr = Attribute().build {
            if let title = title {
                $0.titles = [.normal : title.0]
                $0.titleColors = [.normal : title.1]
                $0.titleFont = title.2
            }
            $0.images = [.normal : image]
            $0.accessibilityLabel = accessibilityLabel
        }
        self.init(attributes: attr, action: action, size: size, viewAttributes: viewAttributes)
    }

    public convenience init(attributes: Attribute,
                            action: Selector?,
                            size: LayoutSize?,
                            viewAttributes: ViewAttributeMap? = nil) {

        let list: [[UIControlState: Any?]?] = [attributes.titles, attributes.titleColors, attributes.images, attributes.backgroundImages]
        let states: [UIControlState] = list.flatMap{ $0 }.map{ Array($0.keys) }.reduce([], { $0 + $1 })
        let buttonAttrs = Set(states).map{ (state) -> __ButtonAttributes in
            let a = __ButtonAttributes()
            a.state = state
            return a
        }

        for attr in buttonAttrs {
            if let t = attributes.titles?[attr.state] {
                attr.title = t
            }
            if let color = attributes.titleColors[attr.state] {
                attr.titleColor = color
            }
            if let image = attributes.images?[attr.state] {
                attr.image = image
            }
            if let image = attributes.backgroundImages?[attr.state] {
                attr.backgroundImage = image
            }
        }

        self.init(__buttonAttribute: buttonAttrs, titleFont: attributes.titleFont, selected: attributes.selected, enabled: attributes.enabled, action: action, size: size, attributes: viewAttributes, accessibilityLabel: attributes.accessibilityLabel)
    }
}


extension ImageComponent {
}

extension NetworkImageComponent {
    
    public convenience init(url: URL?,
                            imageDownloader: NetworkImageDownloading,
                            scenePath: Any?,
                            size: LayoutSize?,
                            placeholderImage: UIImage?,
                            cropRect: CGRect?,
                            attributes: ViewAttributeMap?) {
        self.init(__url: url, imageDownloader: imageDownloader, scenePath: scenePath, size: size, placeholderImage: placeholderImage, cropRect: cropRect ?? .zero, attributes: attributes)
    }

    public convenience init(url: URL?,
                            imageDownloader: NetworkImageDownloading,
                            size: LayoutSize? = nil,
                            placeholderImage: UIImage? = nil,
                            attributes: ViewAttributeMap? = nil) {
        self.init(__url: url, imageDownloader: imageDownloader, scenePath: nil, size: size, placeholderImage: placeholderImage, cropRect: .zero, attributes: attributes)
    }
}



extension StaticLayoutComponent {

    @nonobjc
    public convenience init(view: ViewConfiguration? = nil, size: LayoutSize? = nil, children: [StaticLayoutChild]) {
        self.init(__view: view, size: size, children: children)
    }
    
}

extension RatioLayoutComponent {
    @nonobjc
    public convenience init(ratio h_w_ratio: CGFloat = 1, size: LayoutSize? = nil, component: Component) {
        self.init(__ratio: h_w_ratio, size: size, component: component)
    }

}


