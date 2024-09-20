//
//  Misc.swift
//  Playground
//
//  Created by Takahiro Toya on 21/6/2024.
//

import Foundation
import UIKit

public protocol ViewConfigurable: AnyObject {}
extension UIView: ViewConfigurable {}

extension ViewConfigurable where Self: UIView {
    @discardableResult
    public func apply(_ builder: (Self) -> Void) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        builder(self)
        return self
    }
}



public extension UIStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0,
        @ArrayBuilder<UIView> builder: () -> [UIView]
    ) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        builder().forEach {
            self.addArrangedSubview($0)
        }
    }
    
    convenience init(
        axis: NSLayoutConstraint.Axis = .vertical,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0
    ) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
    
    @discardableResult
    func buildArrangedSubviews(@ArrayBuilder<UIView> builder: () -> [UIView]) -> Self {
        builder().forEach {
            self.addArrangedSubview($0)
        }
        return self
    }
    
    class Spacer: UIView {
        
        public
        convenience
        init(width: CGFloat? = nil, height: CGFloat? = nil) {
            self.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            if let width {
                self.widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            if let height {
                self.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
    }
}



@resultBuilder
public struct ArrayBuilder<T> {
    public static func buildBlock(_ items: T...) -> [T] {
        items
    }
    
    public static func buildBlock(_ items: [T]...) -> [T] {
        items.flatMap { $0 }
    }
    
    public static func buildArray(_ items: [[T]]) -> [T] {
        items.flatMap { $0 }
    }
    
    public static func buildExpression(_ expression: T) -> [T] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [T]) -> [T] {
        return expression
    }
    
    public static func buildEither(first items: [T]) -> [T] {
        return items
    }
    public static func buildEither(second items: [T]) -> [T] {
        return items
    }
    public static func buildOptional(_ items: [T]?) -> [T] {
        return items ?? []
    }
}
