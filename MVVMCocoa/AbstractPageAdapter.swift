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

import RxSwift
import RxCocoa

open class AbstractPageAdapter<D>: NSObject, UIPageViewControllerDataSource {

	public var dispose = DisposeBag();
	public let dataSource = BehaviorSubject<[D]>(value: []);
	
	public var dataSet: [D];
	
	public init(dataSet: [D] = []) {
		self.dataSet = dataSet;
	}
	
	open func bindDataSource(observable: Observable<[D]>, callback: (() -> Void)?) {
		dataSource
			.bindNext({ data in
				self.dataSet = data;
				if let callback = callback {
					callback();
				}
			}).disposed(by: dispose);
		
		observable
			.bindTo(dataSource)
			.disposed(by: dispose);
	}
	
	public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if let contentView = viewController as? AbstractPageViewHolder<D> {
			let index = contentView.position;
			if index > 0 {
				return viewControllerAt(index: (index - 1));
			}
		}
		return nil;
	}
	
	public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if let contentView = viewController as? AbstractPageViewHolder<D> {
			let index = contentView.position;
			if index < (dataCount() - 1) {
				return viewControllerAt(index: (index + 1));
			}
		}
		return nil;
	}
	
	open func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return dataCount();
	}
	
	open func dataCount() -> Int {
		return dataSet.count;
	}
	
	open func itemAt(index: Int) -> D {
		return dataSet[index];
	}
	
	open func viewControllerAt(index: Int) -> AbstractPageViewHolder<D> {
		let item = itemAt(index: index);
		return AbstractPageViewHolder<D>(position: index, item: item);
	}
}
