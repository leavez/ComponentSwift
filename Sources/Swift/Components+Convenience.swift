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

extension CenterLayoutComponent {

    public convenience init?(centering: CenterLayoutComponentCenteringOptions = .XY,
                             sizing: CenterLayoutComponentSizingOptions = .minimumXY,
                             child: Component?, size: LayoutSize? = nil) {
      self.init(__centeringOptions: centering, sizingOptions: sizing, child: child, size: size)
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
    public convenience init(_ string: String?, attrs: [String : Any], numberOfLines:Int = 0) {
        self.init()
        self.attributedString = string.map{ NSAttributedString(string: $0, attributes: attrs) }
        self.maximumNumberOfLines = numberOfLines
    }
    public convenience init(_ string: String?, font: UIFont = UIFont.systemFont(ofSize: 14)) {
        self.init()
        self.attributedString = string.map{ NSAttributedString(string: $0, attributes: [NSFontAttributeName: font]) }
    }
}



extension StackLayoutComponent {

    public convenience init(view: ViewConfiguration? = nil,
                            size: LayoutSize? = nil,
                            style: StackLayoutStyle? = nil,
                            children: [StackLayoutChild?] )
    {
        self.init(__view:view, size:size, style:style, children:children.flatMap{ $0 })
    }
    public convenience init(view: ViewConfiguration? = nil,
                            size: LayoutSize? = nil,
                            style: StackLayoutStyle? = nil,
                            childrenComponents: [Component?] )
    {
        self.init(__view:view, size:size, style:style, children:childrenComponents.flatMap{ ComponentSwift.StackLayoutChild($0) })
    }
}


extension StackLayoutChild {

    public convenience init?(_ component: Component?,
                            spacingAfter: CGFloat = 0,
                            spacingBefore: CGFloat = 0,
                            flexGrow: Bool = false,
                            flexShrink: Bool = false,
                            flexBasis: LayoutDimension? = nil,
                            alignSelf: ComponentSwift.StackLayoutAlignSelf = .auto) {
        guard let component = component else {
            return nil
        }
        self.init()
        self.component = component
        self.spacingAfter = spacingAfter
        self.spacingBefore = spacingBefore
        self.flexGrow = flexGrow
        self.flexShrink = flexShrink
        self.flexBasis = flexBasis
        self.alignSelf = alignSelf
    }
}

extension UIControlState: Hashable {
    public var hashValue: Int {
        return Int(self.rawValue)
    }
}

extension ButtonComponnet {

    public struct ButtonAttribute: Builder {
        var titles: [UIControlState: String?]?
        var titleColors: [UIControlState: UIColor?]?
        var images: [UIControlState: UIImage?]?
        var backgroundImages:[UIControlState: UIImage?]?
        var titleFont: UIFont = .systemFont(ofSize: 15)
        var selected: Bool = false
        var enabled: Bool = true
        var accessibilityLabel: String?
    }


    public convenience init(title: (String, UIColor, UIFont)? = nil,
                            image: UIImage? = nil,
                            action: Selector?,
                            size: LayoutSize?,
                            viewAttributes: ViewAttributeMap? = nil,
                            accessibilityLabel: String? = nil) {
        let attr = ButtonAttribute().build {
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

    public convenience init(attributes: ButtonAttribute,
                            action: Selector?,
                            size: LayoutSize?,
                            viewAttributes: ViewAttributeMap? = nil) {

        let list: [[UIControlState: Any?]?] = [attributes.titles, attributes.titleColors, attributes.images, attributes.backgroundImages]
        let states: [UIControlState] = list.flatMap{ $0 }.map{ Array($0.keys) }.reduce([], { $0 + $1 })
        let buttonAttrs = Set(states).map{ (state) -> ButtonAttributes in
            let a = ButtonAttributes()
            a.state = state
            return a
        }

        for attr in buttonAttrs {
            if let t = attributes.titles?[attr.state] {
                attr.title = t
            }
            if let color = attributes.titleColors?[attr.state] {
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


extension ImageComponnet {
}

extension NetworkImageComponnet {
    
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


