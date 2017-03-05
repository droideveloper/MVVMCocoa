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

open class AbstractAdapter<D, V>: NSObject, UITableViewDataSource where V: AbstractViewHolder<D> {
	
	public var dispose = DisposeBag();
	public let dataSource = BehaviorSubject<[D]>(value: []);
	
	var dataSize: Int;
	var dataSet: [D];
	
	public init(dataSet: [D] = [], dataSize: Int = 0) {
		self.dataSet = dataSet;
		self.dataSize = dataSize;
	}
	
	public func bindDataSource(observable: Observable<[D]>) {
		// register for change
		self.dataSource.bindNext { array in
			self.dataSize = array.size();
			self.dataSet = array;
		}.disposed(by: dispose);
		// this observer binded with threads since it will be coming through network
		observable
			.subscribeOn(RxSchedulers.io)
			.observeOn(RxSchedulers.mainThread)
			.bindTo(dataSource)
			.disposed(by: dispose);
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.dataSize;
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let key = identifierAt(index: indexPath.row);
		let view = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath);
		if let viewHolder = view as? V {
			let item = itemAt(index: indexPath.row);
			bind(viewHolder: viewHolder, item: item);
		}
		return view;
	}
	
	open func itemAt(index: Int) -> D {
		return dataSet[index];
	}
	
	open func identifierAt(index: Int) -> String {
		return "kUnknownIdentifier";
	}
	
	open func bind(viewHolder: V, item: D) {
		viewHolder.bindItemDataSource(observable: Observable.of(item));
	}
}
