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
 
import Material

extension Layout {

	public func leftOf(view: UIView, with constant: CGFloat = 0) -> Layout {
		let r = view.x - constant;
		return right(r);
	}
	
	public func rightOf(view: UIView, with constant: CGFloat = 0) -> Layout {
		let l = view.x + view.width + constant;
		return left(l);
	}
	
	public func aboveOf(view: UIView, with constant: CGFloat = 0) -> Layout {
		let b = view.y - constant;
		return bottom(b);
	}
	
	public func belowOf(view: UIView, with constant: CGFloat = 0) -> Layout {
		let t = view.y + view.height + constant;
		return top(t);
	}
}
