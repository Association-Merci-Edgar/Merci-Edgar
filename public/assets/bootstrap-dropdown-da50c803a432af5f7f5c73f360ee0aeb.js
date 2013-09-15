/* ============================================================
 * bootstrap-dropdown.js v2.3.2
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
!function(o){"use strict";function n(){o(".dropdown-backdrop").remove(),o(e).each(function(){t(o(this)).removeClass("open")})}function t(n){var t,e=n.attr("data-target");return e||(e=n.attr("href"),e=e&&/#/.test(e)&&e.replace(/.*(?=#[^\s]*$)/,"")),t=e&&o(e),t&&t.length||(t=n.parent()),t}var e="[data-toggle=dropdown]",d=function(n){var t=o(n).on("click.dropdown.data-api",this.toggle);o("html").on("click.dropdown.data-api",function(){t.parent().removeClass("open")})};d.prototype={constructor:d,toggle:function(){var e,d,r=o(this);if(!r.is(".disabled, :disabled"))return e=t(r),d=e.hasClass("open"),n(),d||("ontouchstart"in document.documentElement&&o('<div class="dropdown-backdrop"/>').insertBefore(o(this)).on("click",n),e.toggleClass("open")),r.focus(),!1},keydown:function(n){var d,r,a,i,c;if(/(38|40|27)/.test(n.keyCode)&&(d=o(this),n.preventDefault(),n.stopPropagation(),!d.is(".disabled, :disabled"))){if(a=t(d),i=a.hasClass("open"),!i||i&&27==n.keyCode)return 27==n.which&&a.find(e).focus(),d.click();r=o("[role=menu] li:not(.divider):visible a",a),r.length&&(c=r.index(r.filter(":focus")),38==n.keyCode&&c>0&&c--,40==n.keyCode&&c<r.length-1&&c++,~c||(c=0),r.eq(c).focus())}}};var r=o.fn.dropdown;o.fn.dropdown=function(n){return this.each(function(){var t=o(this),e=t.data("dropdown");e||t.data("dropdown",e=new d(this)),"string"==typeof n&&e[n].call(t)})},o.fn.dropdown.Constructor=d,o.fn.dropdown.noConflict=function(){return o.fn.dropdown=r,this},o(document).on("click.dropdown.data-api",n).on("click.dropdown.data-api",".dropdown form",function(o){o.stopPropagation()}).on("click.dropdown.data-api",e,d.prototype.toggle).on("keydown.dropdown.data-api",e+", [role=menu]",d.prototype.keydown)}(window.jQuery);