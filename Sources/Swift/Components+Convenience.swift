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

    public convenience init?(centering: CKWCenterLayoutComponentCenteringOptions = .XY,
                             sizing: CKWCenterLayoutComponentSizingOptions = .minimumXY,
                             child: Component?, size: CKWSize? = nil) {
      self.init(__centeringOptions: centering, sizingOptions: sizing, child: child, size: size)
    }
}

extension TextComponent {

    public convenience init(_ textAttributes: CKWTextAttributes,
                            viewAttributes: CKWViewAttributeMap? = nil,
                            options: CKWTextComponentOptions? = nil,
                            size: CKWSize? = nil) {
        self.init(__textAttributes: textAttributes, viewAttributes: viewAttributes, options: options, size: size)
    }
}

extension CKWTextAttributes {

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

    public convenience init(view: CKWViewConfiguration? = nil,
                            size: CKWSize? = nil,
                            style: CKWStackLayoutStyle? = nil,
                            children: [CKWStackLayoutChild?] )
    {
        self.init(__view:view, size:size, style:style, children:children.flatMap{ $0 })
    }
    public convenience init(view: CKWViewConfiguration? = nil,
                            size: CKWSize? = nil,
                            style: CKWStackLayoutStyle? = nil,
                            childrenComponents: [Component?] )
    {
        self.init(__view:view, size:size, style:style, children:childrenComponents.flatMap{ CKWStackLayoutChild($0) })
    }
}


extension CKWStackLayoutChild {

    public convenience init?(_ component: Component?,
                            spacingAfter: CGFloat = 0,
                            spacingBefore: CGFloat = 0,
                            flexGrow: Bool = false,
                            flexShrink: Bool = false,
                            flexBasis: CKWDimension? = nil,
                            alignSelf: CKWStackLayoutAlignSelf = .auto) {
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

extension UIControlState :Hashable {
    public var hashValue: Int {
        return Int(self.rawValue)
    }
}

extension ButtonComponnet {


    public convenience init(titles:[UIControlState: String?]? = nil,
                            titleColors:[UIControlState: UIColor?]? = nil,
                            images:[UIControlState: UIImage?]? = nil,
                            backgroundImages:[UIControlState: UIImage?]? = nil,
                            titleFont: UIFont,
                            selected: Bool = false,
                            enabled: Bool = false,
                            action: Selector?,
                            size: CKWSize? = nil,
                            attributes: CKWViewAttributeMap? = nil,
                            accessibilityLabel: String? = nil) {

        let list: [[UIControlState: Any?]?] = [titles, titleColors, images, backgroundImages]
        let states: [UIControlState] = list.flatMap{ $0 }.map{ Array($0.keys) }.reduce([], { $0 + $1 })
        let buttonAttrs = Set(states).map{ (state) -> CKWButtonAttributes in
            let a = CKWButtonAttributes()
            a.state = state
            return a
        }

        for attr in buttonAttrs {
            if let t = titles?[attr.state] {
                attr.title = t
            }
            if let color = titleColors?[attr.state] {
                attr.titleColor = color
            }
            if let image = images?[attr.state] {
                attr.image = image
            }
            if let image = backgroundImages?[attr.state] {
                attr.backgroundImage = image
            }
        }

        self.init(__buttonAttribute: buttonAttrs, titleFont: titleFont, selected: selected, enabled: enabled, action: action, size: size, attributes: attributes, accessibilityLabel: accessibilityLabel)

    }
}


extension ImageComponnet {
}

extension NetworkImageComponnet {
    
    public convenience init(url: URL?,
                            imageDownloader: CKWNetworkImageDownloading,
                            scenePath: Any?,
                            size: CKWSize?,
                            placeholderImage: UIImage?,
                            cropRect: CGRect?,
                            attributes: CKWViewAttributeMap?) {
        self.init(__url: url, imageDownloader: imageDownloader, scenePath: scenePath, size: size, placeholderImage: placeholderImage, cropRect: cropRect ?? .zero, attributes: attributes)
    }

    public convenience init(url: URL?,
                            imageDownloader: CKWNetworkImageDownloading,
                            size: CKWSize? = nil,
                            placeholderImage: UIImage? = nil,
                            attributes: CKWViewAttributeMap? = nil) {
        self.init(__url: url, imageDownloader: imageDownloader, scenePath: nil, size: size, placeholderImage: placeholderImage, cropRect: .zero, attributes: attributes)
    }
}


