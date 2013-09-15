/**
 * jQuery.LocalScroll - Animated scrolling navigation, using anchors.
 * Copyright (c) 2007-2009 Ariel Flesler - aflesler(at)gmail(dot)com | http://flesler.blogspot.com
 * Dual licensed under MIT and GPL.
 * Date: 3/11/2009
 * @author Ariel Flesler
 * @version 1.2.7
 **/
!function(e){function t(t,o,n){var a=o.hash.slice(1),i=document.getElementById(a)||document.getElementsByName(a)[0];if(i){t&&t.preventDefault();var r=e(n.target);if(!(n.lock&&r.is(":animated")||n.onBefore&&n.onBefore.call(n,t,i,r)===!1)){if(n.stop&&r.stop(!0),n.hash){var l=i.id==a?"id":"name",s=e("<a> </a>").attr(l,a).css({position:"absolute",top:e(window).scrollTop(),left:e(window).scrollLeft()});i[l]="",e("body").prepend(s),location=o.hash,s.remove(),i[l]=a}r.scrollTo(i,n).trigger("notify.serialScroll",[i])}}}var o=location.href.replace(/#.*/,""),n=e.localScroll=function(t){e("body").localScroll(t)};n.defaults={duration:1e3,axis:"y",event:"click",stop:!0,target:window,reset:!0},n.hash=function(o){if(location.hash){if(o=e.extend({},n.defaults,o),o.hash=!1,o.reset){var a=o.duration;delete o.duration,e(o.target).scrollTo(0,o),o.duration=a}t(0,location,o)}},e.fn.localScroll=function(a){function i(){return!(!this.href||!this.hash||this.href.replace(this.hash,"")!=o||a.filter&&!e(this).is(a.filter))}return a=e.extend({},n.defaults,a),a.lazy?this.bind(a.event,function(o){var n=e([o.target,o.target.parentNode]).filter(i)[0];n&&t(o,n,a)}):this.find("a,area").filter(i).bind(a.event,function(e){t(e,this,a)}).end().end()}}(jQuery);