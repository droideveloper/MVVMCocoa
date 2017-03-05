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

extension Reactive where Base: SnackbarController {
	
	public var notifySnackbar: UIBindingObserver<Base, Snack> {
		return UIBindingObserver(UIElement: self.base) { (controller, value) in
			switch value.state {
				case .visible:
					controller.snackbar.text = value.text;
					if let actionText = value.actionText {
						let flat = FlatButton(title: actionText);
						flat.titleColor = controller.applicationType?.colorAccent;
						if let tapObserver = value.tapObserver {
							let dispose = DisposeBag();
							flat.rx.tap.bindNext { _ in
								self.notifySnackbar.on(.next(Snack.HIDDEN));
								tapObserver.on(.next());
							}.disposed(by: dispose);
						}
					}
					_ = controller.animate(snackbar: .visible);
					_ = controller.animate(snackbar: .hidden, delay: 5);
				case .hidden:
					controller.snackbar.layer.removeAllAnimations();
					_ = controller.animate(snackbar: .hidden);
			}
		};
	}
}
