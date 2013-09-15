/* ==========================================================
 * bootstrap-alert.js v2.3.2
 * http://twitter.github.com/bootstrap/javascript.html#alerts
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
!function(t){"use strict";var e='[data-dismiss="alert"]',r=function(r){t(r).on("click",e,this.close)};r.prototype.close=function(e){function r(){a.trigger("closed").remove()}var a,n=t(this),o=n.attr("data-target");o||(o=n.attr("href"),o=o&&o.replace(/.*(?=#[^\s]*$)/,"")),a=t(o),e&&e.preventDefault(),a.length||(a=n.hasClass("alert")?n:n.parent()),a.trigger(e=t.Event("close")),e.isDefaultPrevented()||(a.removeClass("in"),t.support.transition&&a.hasClass("fade")?a.on(t.support.transition.end,r):r())};var a=t.fn.alert;t.fn.alert=function(e){return this.each(function(){var a=t(this),n=a.data("alert");n||a.data("alert",n=new r(this)),"string"==typeof e&&n[e].call(a)})},t.fn.alert.Constructor=r,t.fn.alert.noConflict=function(){return t.fn.alert=a,this},t(document).on("click.alert.data-api",e,r.prototype.close)}(window.jQuery);