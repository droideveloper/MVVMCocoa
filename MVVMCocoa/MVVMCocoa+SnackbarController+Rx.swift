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
	
	public var snackbarObserver: ControllerBindingObserver<Base, Snack> {
		return ControllerBindingObserver(ControllerElement: self.base) { (controller, snack, dispose) in
			let state = snack.state;
			switch state {
			case .visible:
				let snackbar = controller.snackbar;
				snackbar.text = snack.text;
				if let actionText = snack.actionText {
					let buttonAction = FlatButton(title: actionText);
					if let theme = controller.applicationType {
						buttonAction.titleColor = theme.colorAccent;
					}
					if let tapObserver = snack.tapObserver {
						let tapSource = buttonAction.rx.tap;
						tapSource.map { _ in
							self.snackbarObserver.onNext(Snack.HIDDEN);
						}.bindTo(tapObserver)
						 .disposed(by: dispose);
					}
					snackbar.rightViews = [buttonAction];
				}
				_ = controller.animate(snackbar: state);
				_ = controller.animate(snackbar: .hidden, delay: 3);
			case .hidden:
				controller.snackbar.layer.removeAllAnimations();
				_ = controller.animate(snackbar: state);
			}
		};
	}
}
