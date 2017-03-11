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
 
open class Checkbox: CompoundButton {
	
	open override func prepare() {
		super.prepare();
		prepareCheckbox();
	}
	
	func prepareCheckbox() {
		var normal = icon(named: .ic_check_box_outline_blank);
		normal = normal?.tint(with: .black);
		setImage(normal, for: .normal);
		var image = icon(named: .ic_check_box);
		if let colorAccent = colorAccent() {
			image = image?.tint(with: colorAccent);
			setTitleColor(colorAccent, for: .selected);
		}
		setImage(image, for: .selected);
	}
}
