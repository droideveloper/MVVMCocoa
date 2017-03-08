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

import Material
import RxCocoa
import RxSwift

open class AbstractPageViewHolder<D>: UIViewController {
	
	open var position: Int;
	open var item: D;
	
	public init(position: Int = 0, item: D) {
		self.position = position;
		self.item = item;
		super.init(nibName: nil, bundle: nil);
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("you can not initialize this via storyboard");
	}
}
