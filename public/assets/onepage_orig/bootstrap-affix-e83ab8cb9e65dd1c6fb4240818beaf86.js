/* ==========================================================
 * bootstrap-affix.js v2.1.1
 * http://twitter.github.com/bootstrap/javascript.html#affix
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
!function(t){"use strict";var o=function(o,f){this.options=t.extend({},t.fn.affix.defaults,f),this.$window=t(window).on("scroll.affix.data-api",t.proxy(this.checkPosition,this)),this.$element=t(o),this.checkPosition()};o.prototype.checkPosition=function(){if(this.$element.is(":visible")){var o,f=t(document).height(),i=this.$window.scrollTop(),e=this.$element.offset(),n=this.options.offset,s=n.bottom,a=n.top,h="affix affix-top affix-bottom";"object"!=typeof n&&(s=a=n),"function"==typeof a&&(a=n.top()),"function"==typeof s&&(s=n.bottom()),o=null!=this.unpin&&i+this.unpin<=e.top?!1:null!=s&&e.top+this.$element.height()>=f-s?"bottom":null!=a&&a>=i?"top":!1,this.affixed!==o&&(this.affixed=o,this.unpin="bottom"==o?e.top-i:null,this.$element.removeClass(h).addClass("affix"+(o?"-"+o:"")))}},t.fn.affix=function(f){return this.each(function(){var i=t(this),e=i.data("affix"),n="object"==typeof f&&f;e||i.data("affix",e=new o(this,n)),"string"==typeof f&&e[f]()})},t.fn.affix.Constructor=o,t.fn.affix.defaults={offset:0},t(window).on("load",function(){t('[data-spy="affix"]').each(function(){var o=t(this),f=o.data();f.offset=f.offset||{},f.offsetBottom&&(f.offset.bottom=f.offsetBottom),f.offsetTop&&(f.offset.top=f.offsetTop),o.affix(f)})})}(window.jQuery);