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

import ObjectMapper

extension UserDefaults {
	
	/*INTERNAL START*/
	internal func integer(_ key: String) -> Int? {
		let value = self.integer(forKey: key);
		return value == 0 ? nil : value;
	}
	
	internal func float(_ key: String) -> Float? {
		let value = self.float(forKey: key);
		return value == 0 ? nil : value;
	}
	
	internal func double(_ key: String) -> Double? {
		let value = self.double(forKey: key);
		return value == 0 ? nil : value;
	}
	
	internal func bool(_ key: String) -> Bool? {
		if let _ = object(forKey: key) {
			return bool(forKey: key);
		}
		return nil;
	}
	/*INTERNAL END*/
	
	private var `defaults`: UserDefaults {
		get {
			return UserDefaults.standard;
		}
	}
	
	/*PUBLIC START*/
	public func string(for key: String, defaultValue: String = "") -> Observable<String> {
		return Observable.create { [weak weakSelf = self] observer in
			let value = (weakSelf?.defaults.string(forKey: key)) ?? defaultValue;
			observer.on(.next(value));
			observer.on(.completed);
			return Disposables.create();
		};
	}
	
	public func integer(for key: String, defaultValue: Int = 0) -> Observable<Int> {
		return Observable.create { [weak weakSelf = self] observer in
			let value = (weakSelf?.defaults.integer(forKey: key)) ?? defaultValue;
			observer.on(.next(value));
			observer.on(.completed);
			return Disposables.create();
		};
	}
	
	public func float(for key: String, defaultValue: Float = 0) -> Observable<Float> {
		return Observable.create { [weak weakSelf = self] observer in
			let value = (weakSelf?.defaults.float(key)) ?? defaultValue;
			observer.on(.next(value));
			observer.on(.completed);
			return Disposables.create();
		};
	}
	
	public func double(for key: String, defaultValue: Double = 0) -> Observable<Double> {
		return Observable.create { [weak weakSelf = self] observer in
			let value = (weakSelf?.defaults.double(key)) ?? defaultValue;
			observer.on(.next(value));
			observer.on(.completed);
			return Disposables.create();
		};
	}
	
	public func bool(for key: String, defaultValue: Bool = false) -> Observable<Bool> {
		return Observable.create { [weak weakSelf = self] observer in
			let value = (weakSelf?.defaults.bool(key)) ?? defaultValue;
			observer.on(.next(value));
			observer.on(.completed);
			return Disposables.create();
		};
	}
	
	public func dictionary(for key: String, defaultValue: [String: Any] = [:]) -> Observable<[String: Any]> {
		return Observable.create { [weak weakSelf = self] observer in
			let value = (weakSelf?.defaults.dictionary(forKey: key)) ?? defaultValue;
			observer.on(.next(value));
			observer.on(.completed);
			return Disposables.create();
		};
	}
	
	public func array(for key: String, defaultValue: [Any] = []) -> Observable<[Any]> {
		return Observable.create { [weak weakSelf = self] observer in
			let value = (weakSelf?.defaults.array(forKey: key)) ?? defaultValue;
			observer.on(.next(value));
			observer.on(.completed);
			return Disposables.create();
		};
	}
	
	public func object(for key: String, defaultValue: Any) -> Observable<Any> {
		return Observable.create { [weak weakSelf = self] observer in
			let value = (weakSelf?.defaults.object(forKey: key)) ?? defaultValue;
			observer.on(.next(value));
			observer.on(.completed);
			return Disposables.create();
		};
	}
	
	public func object<T: Mappable>(for key: String, defaultValue: T) -> Observable<T> {
		return dictionary(for: key).map { json in
			return Mapper<T>().map(JSON: json) ?? defaultValue
		};
	}
	
	public func array<T: Mappable>(for key: String, defaultValue: [T] = []) -> Observable<[T]> {
		return Observable.create { [weak weakSelf = self] observer in
			let array = (weakSelf?.array(forKey: key)) ?? [];
			if let array = array as? [[String: Any]] {
				let first = defaultValue[0];
				let data = array.map({ json in Mapper<T>().map(JSON: json) ?? first });
				observer.on(.next(data));
				observer.on(.completed);
			} else {
				observer.on(.next(defaultValue));
				observer.on(.completed);
			}
			return Disposables.create();
		};
	}
}
