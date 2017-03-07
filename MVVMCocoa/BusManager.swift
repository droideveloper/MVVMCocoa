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

public final class BusManager {
	
	private static let rxBus = PublishSubject<EventType>();
	
	public static func register(_ onNext: @escaping (EventType) -> Void) -> Disposable {
		return rxBus.subscribe(onNext: onNext);
	}
	
	public static func unregister(dispose: Disposable?) -> Void {
		if let dispose = dispose {
			dispose.dispose();
		}
	}
	
	public static func send(event: EventType) -> Void {
		rxBus.onNext(event);
	}
}
