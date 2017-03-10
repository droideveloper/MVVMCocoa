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

open class AbstractTableAdapter<D>: NSObject, UITableViewDataSource {
	
	public var dispose = DisposeBag();
	public let dataSource = BehaviorSubject<[D]>(value: []);
	
	public var dataSet: [D];
	
	public init(dataSet: [D] = []) {
		self.dataSet = dataSet;
	}
	
	open func bindDataSource(observable: Observable<[D]>, callback: (() ->Void)?) {
		// register for change
		dataSource
			.bindNext({ data in
				self.dataSet = data;
				if let callback = callback {
					callback();
				}
			}).disposed(by: dispose);
		// this observer binded with threads since it will be coming through network
		observable
			.bindTo(dataSource)
			.disposed(by: dispose);
	}
	
	open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataCount();
	}
	
	open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let key = identifierAt(index: indexPath.row);
		let item = itemAt(index: indexPath.row);
		let view = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath);
		if let viewHolder = view as? AbstractTableViewHolder<D> {
			bind(viewHolder: viewHolder, item: item);
		}
		return view;
	}
	
	open func dataCount() -> Int {
		return dataSet.count;
	}
	
	open func itemAt(index: Int) -> Observable<D> {
		return Observable.of(dataSet[index]);
	}
	
	open func identifierAt(index: Int) -> String {
		return "kUnknownIdentifier";
	}
	
	open func bind(viewHolder: AbstractTableViewHolder<D>, item: Observable<D>) {
		viewHolder.bindItemDataSource(observable: item);
	}
}
