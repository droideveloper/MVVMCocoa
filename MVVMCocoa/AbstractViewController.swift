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

open class AbstractViewController<V>: UIViewController where V: ViewModelType {
	
	open var viewModel: V?;
	
	public var indicatorObserver: Any? {
		get {
			return self.activityIndicator.rx.isAnimating;
		}
	}
	
	public var snackbarObserver: Any? {
		get {
			return self.snackbarController?.rx.snackbarObserver;
		}
	}
	
	internal let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white);
	
	open override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated);
		self.viewModel?.viewWillAppear(animated);
	}
	
	open override func viewDidLoad() {
		super.viewDidLoad();
		self.prepare();
		if let theme = applicationType {
			self.activityIndicator.color = theme.colorAccent;
		}
		self.view.layout(activityIndicator)
			.center();
		self.viewModel?.viewDidLoad();
	}
	
	open override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated);
		self.viewModel?.viewWillDisappear(animated)
	}
	
	open override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning();
		self.viewModel?.didReceiveMemoryWarning();
	}
	
	open func prepare() {
		self.view.clipsToBounds = true
		self.view.backgroundColor = .white
		self.view.contentScaleFactor = Screen.scale
	}
}
