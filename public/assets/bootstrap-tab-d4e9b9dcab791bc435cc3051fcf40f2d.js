/* ========================================================
 * bootstrap-tab.js v2.3.2
 * http://twitter.github.com/bootstrap/javascript.html#tabs
 * ========================================================
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
 * ======================================================== */
!function(t){"use strict";var a=function(a){this.element=t(a)};a.prototype={constructor:a,show:function(){var a,e,n,i=this.element,s=i.closest("ul:not(.dropdown-menu)"),o=i.attr("data-target");o||(o=i.attr("href"),o=o&&o.replace(/.*(?=#[^\s]*$)/,"")),i.parent("li").hasClass("active")||(a=s.find(".active:last a")[0],n=t.Event("show",{relatedTarget:a}),i.trigger(n),n.isDefaultPrevented()||(e=t(o),this.activate(i.parent("li"),s),this.activate(e,e.parent(),function(){i.trigger({type:"shown",relatedTarget:a})})))},activate:function(a,e,n){function i(){s.removeClass("active").find("> .dropdown-menu > .active").removeClass("active"),a.addClass("active"),o?(a[0].offsetWidth,a.addClass("in")):a.removeClass("fade"),a.parent(".dropdown-menu")&&a.closest("li.dropdown").addClass("active"),n&&n()}var s=e.find("> .active"),o=n&&t.support.transition&&s.hasClass("fade");o?s.one(t.support.transition.end,i):i(),s.removeClass("in")}};var e=t.fn.tab;t.fn.tab=function(e){return this.each(function(){var n=t(this),i=n.data("tab");i||n.data("tab",i=new a(this)),"string"==typeof e&&i[e]()})},t.fn.tab.Constructor=a,t.fn.tab.noConflict=function(){return t.fn.tab=e,this},t(document).on("click.tab.data-api",'[data-toggle="tab"], [data-toggle="pill"]',function(a){a.preventDefault(),t(this).tab("show")})}(window.jQuery);