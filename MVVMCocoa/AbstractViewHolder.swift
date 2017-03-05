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

import RxSwift
import RxCocoa

open class AbstractViewHolder<T>: TableViewCell {
	
	public var dispose = DisposeBag();
	public let itemDataSource = PublishSubject<T>();
	
	open func bindItemDataSource(observable: Observable<T>) {
		observable.bindTo(itemDataSource)
			.disposed(by: dispose);
	}
		
	open override func prepareForReuse() {
		super.prepareForReuse();
		self.dispose = DisposeBag();
	}
}
