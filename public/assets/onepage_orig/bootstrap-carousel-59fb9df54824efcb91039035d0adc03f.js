/* ==========================================================
 * bootstrap-carousel.js v2.1.1
 * http://twitter.github.com/bootstrap/javascript.html#carousel
 * ==========================================================
 * Copyright 2012 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================== */
!function(t){"use strict";var e=function(e,i){this.$element=t(e),this.options=i,this.options.slide&&this.slide(this.options.slide),"hover"==this.options.pause&&this.$element.on("mouseenter",t.proxy(this.pause,this)).on("mouseleave",t.proxy(this.cycle,this))};e.prototype={cycle:function(e){return e||(this.paused=!1),this.options.interval&&!this.paused&&(this.interval=setInterval(t.proxy(this.next,this),this.options.interval)),this},to:function(e){var i=this.$element.find(".item.active"),s=i.parent().children(),n=s.index(i),a=this;if(!(e>s.length-1||0>e))return this.sliding?this.$element.one("slid",function(){a.to(e)}):n==e?this.pause().cycle():this.slide(e>n?"next":"prev",t(s[e]))},pause:function(e){return e||(this.paused=!0),this.$element.find(".next, .prev").length&&t.support.transition.end&&(this.$element.trigger(t.support.transition.end),this.cycle()),clearInterval(this.interval),this.interval=null,this},next:function(){return this.sliding?void 0:this.slide("next")},prev:function(){return this.sliding?void 0:this.slide("prev")},slide:function(e,i){var s=this.$element.find(".item.active"),n=i||s[e](),a=this.interval,r="next"==e?"left":"right",l="next"==e?"first":"last",o=this,h=t.Event("slide",{relatedTarget:n[0]});if(this.sliding=!0,a&&this.pause(),n=n.length?n:this.$element.find(".item")[l](),!n.hasClass("active")){if(t.support.transition&&this.$element.hasClass("slide")){if(this.$element.trigger(h),h.isDefaultPrevented())return;n.addClass(e),n[0].offsetWidth,s.addClass(r),n.addClass(r),this.$element.one(t.support.transition.end,function(){n.removeClass([e,r].join(" ")).addClass("active"),s.removeClass(["active",r].join(" ")),o.sliding=!1,setTimeout(function(){o.$element.trigger("slid")},0)})}else{if(this.$element.trigger(h),h.isDefaultPrevented())return;s.removeClass("active"),n.addClass("active"),this.sliding=!1,this.$element.trigger("slid")}return a&&this.cycle(),this}}},t.fn.carousel=function(i){return this.each(function(){var s=t(this),n=s.data("carousel"),a=t.extend({},t.fn.carousel.defaults,"object"==typeof i&&i),r="string"==typeof i?i:a.slide;n||s.data("carousel",n=new e(this,a)),"number"==typeof i?n.to(i):r?n[r]():a.interval&&n.cycle()})},t.fn.carousel.defaults={interval:5e3,pause:"hover"},t.fn.carousel.Constructor=e,t(function(){t("body").on("click.carousel.data-api","[data-slide]",function(e){var i,s=t(this),n=t(s.attr("data-target")||(i=s.attr("href"))&&i.replace(/.*(?=#[^\s]+$)/,"")),a=!n.data("modal")&&t.extend({},n.data(),s.data());n.carousel(a),e.preventDefault()})})}(window.jQuery);