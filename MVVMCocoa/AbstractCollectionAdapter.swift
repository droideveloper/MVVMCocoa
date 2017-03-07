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

open class AbstractCollectionAdapter<D>: NSObject, UICollectionViewDataSource {

	public var dispose = DisposeBag();
	public let dataSource = BehaviorSubject<[D]>(value: []);
	
	var dataSize: Int;
	var dataSet: [D];
	
	public init(dataSize: Int = 0, dataSet: [D] = []) {
		self.dataSize = dataSize;
		self.dataSet = dataSet;
	}
	
	open func bindDataSource(observable: Observable<[D]>, callback: (() ->Void)?) {
		// register for change
		dataSource
			.bindNext({ data in
				if data.count != self.dataSize {
					self.dataSize = data.count;
					self.dataSet = data;
					if let callback = callback {
						callback();
					}
				}
			}).disposed(by: dispose);
		// this observer binded with threads since it will be coming through network
		observable
			.bindTo(dataSource)
			.disposed(by: dispose);
	}
	
	open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataSize;
	}
	
	open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let identifier = identifierAt(index: indexPath.row);
		let view = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath);
		if let viewHolder = view as? AbstractCollectionViewHolder<D> {
			let item = itemAt(index: indexPath.row);
			bind(viewHolder: viewHolder, item: item);
		}
		return view;
	}
	
	open func itemAt(index: Int) -> Observable<D> {
		return Observable.of(dataSet[index]);
	}
	
	open func identifierAt(index: Int) -> String {
		return "kUnknownIdentifier";
	}
	
	open func bind(viewHolder: AbstractCollectionViewHolder<D>, item: Observable<D>) {
		viewHolder.bindItemDataSource(observable: item);
	}
}
