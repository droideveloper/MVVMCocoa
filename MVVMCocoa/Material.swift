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
 
public final class Material: NSObject {
	
	fileprivate static let bundle: Bundle = {
		let bundle = Bundle(for: Material.self);
		if let url = bundle.resourceURL {
			if let xBundle =  Bundle(url: url.appendingPathComponent("org.fs.MVVMCocoa.icons.bundle")) {
				return xBundle;
			}
		}
		fatalError("can not find resources")
	}();
	
	fileprivate static func icon(named: String) -> UIImage? {
		if let image = UIImage(named: named, in: bundle, compatibleWith: nil) {
			return image.withRenderingMode(.alwaysTemplate);
		}
		return nil;
	}
	
	public static func icon(iconSet: IconSet) -> UIImage? {
		return icon(named: "\(iconSet)");
	}
}
