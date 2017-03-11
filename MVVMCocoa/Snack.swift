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
import RxCocoa
import RxSwift

public final class Snack {
	
	public static let HIDDEN = Snack(state: .hidden);
	
	public var text: String?;
	public var actionText: String?
	public var tapObserver: PublishSubject<Void>?;
	
	public var state: SnackbarStatus;
	
	public init(state: SnackbarStatus, text: String? = nil, actionText: String? = nil, tapObserver: PublishSubject<Void>? = nil) {
		self.state = state;
		self.text = text;
		self.actionText = actionText;
		self.tapObserver = tapObserver;
	}
	
	public static func show(text: String? = nil, actionText: String? = nil, tapObserver: PublishSubject<Void>? = nil) -> Snack {
		return Snack(state: .visible, text: text, actionText: actionText, tapObserver: tapObserver);
	}
}
