/* =============================================================
 * bootstrap-scrollspy.js v2.3.2
 * http://twitter.github.com/bootstrap/javascript.html#scrollspy
 * =============================================================
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
 * ============================================================== */
!function(t){"use strict";function s(s,e){var o,r=t.proxy(this.process,this),i=t(s).is("body")?t(window):t(s);this.options=t.extend({},t.fn.scrollspy.defaults,e),this.$scrollElement=i.on("scroll.scroll-spy.data-api",r),this.selector=(this.options.target||(o=t(s).attr("href"))&&o.replace(/.*(?=#[^\s]+$)/,"")||"")+" .nav li > a",this.$body=t("body"),this.refresh(),this.process()}s.prototype={constructor:s,refresh:function(){var s,e=this;this.offsets=t([]),this.targets=t([]),s=this.$body.find(this.selector).map(function(){var s=t(this),o=s.data("target")||s.attr("href"),r=/^#\w/.test(o)&&t(o);return r&&r.length&&[[r.position().top+(!t.isWindow(e.$scrollElement.get(0))&&e.$scrollElement.scrollTop()),o]]||null}).sort(function(t,s){return t[0]-s[0]}).each(function(){e.offsets.push(this[0]),e.targets.push(this[1])})},process:function(){var t,s=this.$scrollElement.scrollTop()+this.options.offset,e=this.$scrollElement[0].scrollHeight||this.$body[0].scrollHeight,o=e-this.$scrollElement.height(),r=this.offsets,i=this.targets,l=this.activeTarget;if(s>=o)return l!=(t=i.last()[0])&&this.activate(t);for(t=r.length;t--;)l!=i[t]&&s>=r[t]&&(!r[t+1]||s<=r[t+1])&&this.activate(i[t])},activate:function(s){var e,o;this.activeTarget=s,t(this.selector).parent(".active").removeClass("active"),o=this.selector+'[data-target="'+s+'"],'+this.selector+'[href="'+s+'"]',e=t(o).parent("li").addClass("active"),e.parent(".dropdown-menu").length&&(e=e.closest("li.dropdown").addClass("active")),e.trigger("activate")}};var e=t.fn.scrollspy;t.fn.scrollspy=function(e){return this.each(function(){var o=t(this),r=o.data("scrollspy"),i="object"==typeof e&&e;r||o.data("scrollspy",r=new s(this,i)),"string"==typeof e&&r[e]()})},t.fn.scrollspy.Constructor=s,t.fn.scrollspy.defaults={offset:10},t.fn.scrollspy.noConflict=function(){return t.fn.scrollspy=e,this},t(window).on("load",function(){t('[data-spy="scroll"]').each(function(){var s=t(this);s.scrollspy(s.data())})})}(window.jQuery);