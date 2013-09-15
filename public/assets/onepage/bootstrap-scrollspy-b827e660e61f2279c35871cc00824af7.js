/* =============================================================
 * bootstrap-scrollspy.js v2.1.1
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
!function(t){"use strict";function s(s,e){var o,i=t.proxy(this.process,this),r=t(s).is("body")?t(window):t(s);this.options=t.extend({},t.fn.scrollspy.defaults,e),this.$scrollElement=r.on("scroll.scroll-spy.data-api",i),this.selector=(this.options.target||(o=t(s).attr("href"))&&o.replace(/.*(?=#[^\s]+$)/,"")||"")+" .nav li > a",this.$body=t("body"),this.refresh(),this.process()}s.prototype={constructor:s,refresh:function(){var s,e=this;this.offsets=t([]),this.targets=t([]),s=this.$body.find(this.selector).map(function(){var s=t(this),e=s.data("target")||s.attr("href"),o=/^#\w/.test(e)&&t(e);return o&&o.length&&[[o.position().top,e]]||null}).sort(function(t,s){return t[0]-s[0]}).each(function(){e.offsets.push(this[0]),e.targets.push(this[1])})},process:function(){var t,s=this.$scrollElement.scrollTop()+this.options.offset,e=this.$scrollElement[0].scrollHeight||this.$body[0].scrollHeight,o=e-this.$scrollElement.height(),i=this.offsets,r=this.targets,a=this.activeTarget;if(s>=o)return a!=(t=r.last()[0])&&this.activate(t);for(t=i.length;t--;)a!=r[t]&&s>=i[t]&&(!i[t+1]||s<=i[t+1])&&this.activate(r[t])},activate:function(s){var e,o;this.activeTarget=s,t(this.selector).parent(".active").removeClass("active"),o=this.selector+'[data-target="'+s+'"],'+this.selector+'[href="'+s+'"]',e=t(o).parent("li").addClass("active"),e.parent(".dropdown-menu").length&&(e=e.closest("li.dropdown").addClass("active")),e.trigger("activate")}},t.fn.scrollspy=function(e){return this.each(function(){var o=t(this),i=o.data("scrollspy"),r="object"==typeof e&&e;i||o.data("scrollspy",i=new s(this,r)),"string"==typeof e&&i[e]()})},t.fn.scrollspy.Constructor=s,t.fn.scrollspy.defaults={offset:10},t(window).on("load",function(){t('[data-spy="scroll"]').each(function(){var s=t(this);s.scrollspy(s.data())})})}(window.jQuery);