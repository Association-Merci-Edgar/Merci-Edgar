/* ==========================================================
 * bootstrap-alert.js v2.1.1
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
!function(t){"use strict";var e='[data-dismiss="alert"]',a=function(a){t(a).on("click",e,this.close)};a.prototype.close=function(e){function a(){r.trigger("closed").remove()}var r,n=t(this),s=n.attr("data-target");s||(s=n.attr("href"),s=s&&s.replace(/.*(?=#[^\s]*$)/,"")),r=t(s),e&&e.preventDefault(),r.length||(r=n.hasClass("alert")?n:n.parent()),r.trigger(e=t.Event("close")),e.isDefaultPrevented()||(r.removeClass("in"),t.support.transition&&r.hasClass("fade")?r.on(t.support.transition.end,a):a())},t.fn.alert=function(e){return this.each(function(){var r=t(this),n=r.data("alert");n||r.data("alert",n=new a(this)),"string"==typeof e&&n[e].call(r)})},t.fn.alert.Constructor=a,t(function(){t("body").on("click.alert.data-api",e,a.prototype.close)})}(window.jQuery);