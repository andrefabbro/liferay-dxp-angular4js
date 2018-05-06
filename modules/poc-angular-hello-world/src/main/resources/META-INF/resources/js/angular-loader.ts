// Import needed polyfills before application is launched

import 'reflect-metadata';
import 'zone.js';

// Declare Liferay AMD loader

declare var Liferay: any;

// Launch application

export default function(rootId: any) {
	Liferay.Loader.require('poc-angular-hello-world@1.0.0/js/main', (main: any) => {
		main.default(rootId);
	});
}