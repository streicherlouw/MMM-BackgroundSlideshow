/* Magic Mirror Config Sample
 *
 * By Michael Teeuw https://michaelteeuw.nl
 * MIT Licensed.
 *
 * For more information on how you can configure this file
 * See https://github.com/MichMich/MagicMirror#configuration
 *
 */

var config = {
	address: "localhost", 	// Address to listen on, can be:
							// - "localhost", "127.0.0.1", "::1" to listen on loopback interface
							// - another specific IPv4/6 to listen on a specific interface
							// - "0.0.0.0", "::" to listen on any interface
							// Default, when address config is left out or empty, is "localhost"
	port: 8080,
	basePath: "/", 	// The URL path where MagicMirror is hosted. If you are using a Reverse proxy
					// you must set the sub path here. basePath must end with a /
	ipWhitelist: ["127.0.0.1", "::ffff:127.0.0.1", "::1"], 	// Set [] to allow all IP addresses															// or add a specific IPv4 of 192.168.1.5 :
								// ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.1.5"],
								// or IPv4 range of 192.168.3.0 --> 192.168.3.15 use CIDR format :
								// ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.3.0/28"],
	useHttps: false, 		// Support HTTPS or not, default "false" will use HTTP
	httpsPrivateKey: "", 	// HTTPS private key path, only require when useHttps is true
	httpsCertificate: "", 	// HTTPS Certificate path, only require when useHttps is true

	language: "en",
	logLevel: ["INFO", "LOG", "WARN", "ERROR"],
	timeFormat: 24,
	units: "metric",
	// serverOnly:  true/false/"local" ,
	// local for armv6l processors, default
	//   starts serveronly and then starts chrome browser
	// false, default for all NON-armv6l devices
	// true, force serveronly mode, because you want to.. no UI on this device

	modules: [
		{
			module: "alert",
		},
		/*{
			module: "updatenotification",
			position: "top_bar",
		},*/
		{
				module: "weather",
				position: "top_right",
				config: {
						weatherProvider: "openmeteo",
						type: "current",
						lat: -37.7813,
						lon: 144.8327
				}
		},
		{
				module: "weather",
				position: "top_right",
				header: "Weather Forecast",
				config: {
						weatherProvider: "openmeteo",
						type: "forecast",
						lat: -37.7813,
						lon: 144.8327
				}
		},
		{
			module: 'MMM-BackgroundSlideshow',
			position: 'fullscreen_below',
			config: {
			  //imagePaths: ['modules/MMM-BackgroundSlideshow/Photos/2018-06 Hawaii'],
			imagePaths: ['modules/MMM-BackgroundSlideshow/Art/'],
              		randomizeImageOrder: true,
			slideshowSpeed: 60000,
              		showProgressBar:false,
              		transitionSpeed: '20s',
			 recursiveSubDirectories:true,
			 showImageInfo: true,
              		imageInfo: 'name',
			imageInfoNoFileExt: true,
			  //backgroundSize: 'cover',
			 backgroundSize: 'contain', 
			 transitions:['opacity'],
             		 transitionTimingFunction: 'ease-in-out'
			}
		  },/*
		{
			module: 'MMM-PIR-Sensor',
			config: {
				sensorPin: 22,
				sensorState: 1,
				powerSaving: true,
				powerSavingDelay: 1440,
		                }
		},*/
	]
};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
