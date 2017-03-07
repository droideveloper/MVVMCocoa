/*
 * MVVMCocoa Copyright (C) 2017 Fatih.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
import UIKit

extension UIView {
	
	public var heightConstraint: NSLayoutConstraint? {
		get {
			for constraint in constraints {
				if checkAttrFirst(constraint, matches: .height) || checkAttrSecond(constraint, matches: .height) {
					return constraint;
				}
			}
			return nil;
		}
	}
	
	public var widthConstraint: NSLayoutConstraint? {
		get {
			for constraint in constraints {
				if checkAttrFirst(constraint, matches: .width) || checkAttrSecond(constraint, matches: .width) {
					return constraint;
				}
			}
			return nil;
		}
	}
	
	public var topConstraint: NSLayoutConstraint? {
		get {
			for constraint in constraints {
				if checkAttrFirst(constraint, matches: .top) || checkAttrSecond(constraint, matches: .top) {
					return constraint;
				}
			}
			return nil;
		}
	}
	
	public var bottomConstraint: NSLayoutConstraint? {
		get {
			for constraint in constraints {
				if checkAttrFirst(constraint, matches: .bottom) || checkAttrSecond(constraint, matches: .bottom) {
					return constraint;
				}
			}
			return nil;
		}
	}
	
	public var leftConstraint: NSLayoutConstraint? {
		get {
			for constraint in constraints {
				if checkAttrFirst(constraint, matches: .left) || checkAttrSecond(constraint, matches: .left) {
					return constraint;
				}
			}
			return nil;
		}
	}
	
	public var rightConstraint: NSLayoutConstraint? {
		get {
			for constraint in constraints {
				if checkAttrFirst(constraint, matches: .right) || checkAttrSecond(constraint, matches: .right) {
					return constraint;
				}
			}
			return nil;
		}
	}
	
	public func checkAttrFirst(_ constraint: NSLayoutConstraint, matches: NSLayoutAttribute) -> Bool {
		if let itemSelf = constraint.firstItem as? UIView {
			return itemSelf == self && matches == constraint.firstAttribute;
		}
		return false;
	}
	
	public func checkAttrSecond(_ constraint: NSLayoutConstraint, matches: NSLayoutAttribute) -> Bool {
		if let itemSelf = constraint.secondItem as? UIView {
			return itemSelf == self && matches == constraint.secondAttribute;
		}
		return false;
	}
}
