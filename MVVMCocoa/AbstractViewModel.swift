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
 
import RxSwift
import RxCocoa

import Material

open class AbstractViewModel<V>: NSObject where V: ViewType {
	
	public let dispose = DisposeBag();
	public let indicatorSource = BehaviorSubject<Bool>(value: false);
	public let snackbarSource = BehaviorSubject<Snack>(value: Snack.HIDDEN);
	
	open weak var view: V?;
	
	public init(view: V?) {
		self.view = view;
	}
	
	open func viewWillAppear(_ animated: Bool) -> Void {
		if let view = view {
			if let snackbarObserver = view.snackbarObserver as? ControllerBindingObserver<SnackbarController, Snack> {
				bindSnackDataSource(observer: snackbarObserver);
			}
			if let indicatorObserver = view.indicatorObserver as? UIBindingObserver<UIActivityIndicatorView, Bool> {
				bindProgressVisibilityDataSource(observer: indicatorObserver);
			}
		}
	}
	
	open func viewDidLoad() -> Void {
		// no-op
	}
	
	open func viewWillDisappear(_ animated: Bool) -> Void {
		// no-op
	}
	
	open func didReceiveMemoryWarning() -> Void {
		// no-op
	}
	
	func bindProgressVisibilityDataSource(observer: UIBindingObserver<UIActivityIndicatorView, Bool>) -> Void {
		indicatorSource.bindTo(observer)
			.disposed(by: dispose);
	}
	
	func bindSnackDataSource(observer: ControllerBindingObserver<SnackbarController, Snack>) -> Void {
		snackbarSource.bindTo(observer)
			.disposed(by: dispose);
	}
}
