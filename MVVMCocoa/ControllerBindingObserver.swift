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

public final class ControllerBindingObserver<ControllerType, Value>: ObserverType where ControllerType: UIViewController {
	
	public typealias E = Value;
	
	public let dispose = DisposeBag();
	
	weak var ControllerElement: ControllerType?;
	
	let binding: (ControllerType, Value, DisposeBag) -> Void;
	
	public init(ControllerElement: ControllerType, binding: @escaping (ControllerType, Value, DisposeBag) -> Void) {
		self.ControllerElement = ControllerElement;
		self.binding = binding;
	}
	
	public func on(_ event: Event<Value>) {
		if !DispatchQueue.isMain {
			DispatchQueue.main.async {
				self.on(event);
			};
			return;
		}
		
		switch event {
			case .next(let element):
				if let controller = self.ControllerElement {
					binding(controller, element, dispose);
				}
			case .error(let error):
				#if DEBUG
					print("\(error.localizedDescription)");
				#else
					throw error;
				#endif
			case .completed:
				break;
			}
	}
	
	public func asObserver() -> AnyObserver<Value> {
		return AnyObserver(eventHandler: on)
	}
}
