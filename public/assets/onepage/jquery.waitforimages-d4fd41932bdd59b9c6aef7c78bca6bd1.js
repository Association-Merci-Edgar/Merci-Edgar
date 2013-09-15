/*
 * waitForImages 1.4
 * -----------------
 * Provides a callback when all images have loaded in your given selector.
 * http://www.alexanderdickson.com/
 *
 *
 * Copyright (c) 2011 Alex Dickson
 * Licensed under the MIT licenses.
 * See website for more info.
 *
 */
!function(e){var r="waitForImages";e.waitForImages={hasImageProperties:["backgroundImage","listStyleImage","borderImage","borderCornerImage"]},e.expr[":"].uncached=function(r){if(!e(r).is('img[src!=""]'))return!1;var n=document.createElement("img");return n.src=r.src,!n.complete},e.fn.waitForImages=function(n,a,i){if(e.isPlainObject(arguments[0])&&(a=n.each,i=n.waitForAll,n=n.finished),n=n||e.noop,a=a||e.noop,i=!!i,!e.isFunction(n)||!e.isFunction(a))throw new TypeError("An invalid callback was supplied.");return this.each(function(){var c=e(this),t=[];if(i){var s=e.waitForImages.hasImageProperties||[],o=/url\((['"]?)(.*?)\1\)/g;c.find("*").each(function(){var r=e(this);r.is("img:uncached")&&t.push({src:r.attr("src"),element:r[0]}),e.each(s,function(e,n){var a=r.css(n);if(!a)return!0;for(var i;i=o.exec(a);)t.push({src:i[2],element:r[0]})})})}else c.find("img:uncached").each(function(){t.push({src:this.src,element:this})});var u=t.length,l=0;0==u&&n.call(c[0]),e.each(t,function(i,t){var s=new Image;e(s).bind("load."+r+" error."+r,function(e){return l++,a.call(t.element,l,u,"load"==e.type),l==u?(n.call(c[0]),!1):void 0}),s.src=t.src})})}}(jQuery);