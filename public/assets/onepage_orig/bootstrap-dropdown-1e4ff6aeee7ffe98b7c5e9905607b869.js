/* ============================================================
 * bootstrap-dropdown.js v2.1.1
 * http://twitter.github.com/bootstrap/javascript.html#dropdowns
 * ============================================================
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
 * ============================================================ */
!function(o){"use strict";function t(){n(o(a)).removeClass("open")}function n(t){var n,a=t.attr("data-target");return a||(a=t.attr("href"),a=a&&/#/.test(a)&&a.replace(/.*(?=#[^\s]*$)/,"")),n=o(a),n.length||(n=t.parent()),n}var a="[data-toggle=dropdown]",d=function(t){var n=o(t).on("click.dropdown.data-api",this.toggle);o("html").on("click.dropdown.data-api",function(){n.parent().removeClass("open")})};d.prototype={constructor:d,toggle:function(){var a,d,e=o(this);if(!e.is(".disabled, :disabled"))return a=n(e),d=a.hasClass("open"),t(),d||(a.toggleClass("open"),e.focus()),!1},keydown:function(t){var a,d,e,r,i;if(/(38|40|27)/.test(t.keyCode)&&(a=o(this),t.preventDefault(),t.stopPropagation(),!a.is(".disabled, :disabled"))){if(e=n(a),r=e.hasClass("open"),!r||r&&27==t.keyCode)return a.click();d=o("[role=menu] li:not(.divider) a",e),d.length&&(i=d.index(d.filter(":focus")),38==t.keyCode&&i>0&&i--,40==t.keyCode&&i<d.length-1&&i++,~i||(i=0),d.eq(i).focus())}}},o.fn.dropdown=function(t){return this.each(function(){var n=o(this),a=n.data("dropdown");a||n.data("dropdown",a=new d(this)),"string"==typeof t&&a[t].call(n)})},o.fn.dropdown.Constructor=d,o(function(){o("html").on("click.dropdown.data-api touchstart.dropdown.data-api",t),o("body").on("click.dropdown touchstart.dropdown.data-api",".dropdown form",function(o){o.stopPropagation()}).on("click.dropdown.data-api touchstart.dropdown.data-api",a,d.prototype.toggle).on("keydown.dropdown.data-api touchstart.dropdown.data-api",a+", [role=menu]",d.prototype.keydown)})}(window.jQuery);