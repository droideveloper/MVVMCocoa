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

open class CompoundButton: Button {
	
	public let dispose = DisposeBag();
	
	var selectedObserver: UIBindingObserver<CompoundButton, Bool> {
		get {
			return rx.isSelected;
		}
	}
	
	var tapSource: ControlEvent<Void> {
		get {
			return rx.tap;
		}
	}
	
	open override func prepare() {
		super.prepare();
		pulseAnimation = .none;
		tapSource
			.map({ [unowned self] _ in !self.isSelected })
			.bindTo(selectedObserver)
			.disposed(by: dispose);
	}
	
	public func colorAccent() -> UIColor? {
		return Application.shared?.colorAccent;
	}
	
	public func icon(named: IconSet) -> UIImage? {
		return Material.icon(iconSet: named);
	}
}
