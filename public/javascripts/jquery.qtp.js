/*
 * QTP - jQuery Plugin
 * simple wrapper for QuickTime player
 *
 * Copyright (c) 2010 Scholars' Lab
 * 
 * Version: 0.0.5 (3/2/2010)
 * Requires: jQuery v1.3+
 * 
 * Licensed under the Apache2 License:
 *   http://www.apache.org/licenses/LICENSE-2.0.html
 */
jQuery.fn.qtp = function(filename, starttime, endtime, options){
	
	settings = jQuery.extend({
		base_url: 'http://qss.itc.virginia.edu/medialab/faulkner_audio/',
		width: 300,
		height: 16,
		active_x: '',
		autoplay: false,
		scale: 'tofit'
	}, options);
	
	this.each(function(){
		var s = settings;
		
		var fpath = s.base_url + filename;
		
		var player = QT_GenerateOBJECTText(fpath, s.width, s.height, s.active_x, 
			'autoplay', s.autoplay,
			'scale', s.scale,
			'starttime', starttime,
			'endtime', endtime);
		
		$(this).append(player);
	});
	
	return this;
}