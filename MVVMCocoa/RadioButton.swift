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
 
open class RadioButton: CompoundButton {
	
	open override func prepare() {
		super.prepare();
		setImage(Material.icon(iconSet: .ic_radio_button_unchecked), for: .normal);
		setImage(tintImageColor(image: Material.icon(iconSet: .ic_radio_button_checked)), for: .selected);
	}
	
	func tintImageColor(image: UIImage?) -> UIImage? {
		if let theme = UIApplication.shared.delegate as? ApplicationType {
			setTitleColor(theme.colorAccent, for: .selected);
			return image?.tint(with: theme.colorAccent);
		}
		return image;
	}
}
