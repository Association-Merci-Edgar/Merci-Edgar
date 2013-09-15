/**
 * Timeago is a jQuery plugin that makes it easy to support automatically
 * updating fuzzy timestamps (e.g. "4 minutes ago" or "about 1 day ago").
 *
 * @name timeago
 * @version 1.1.0
 * @requires jQuery v1.2.3+
 * @author Ryan McGeary
 * @license MIT License - http://www.opensource.org/licenses/mit-license.php
 *
 * For usage and examples, visit:
 * http://timeago.yarp.com/
 *
 * Copyright (c) 2008-2013, Ryan McGeary (ryan -[at]- mcgeary [*dot*] org)
 */
!function(t){"function"==typeof define&&define.amd?define(["jquery"],t):t(jQuery)}(function(t){function e(){var e=r(this);return isNaN(e.datetime)||t(this).text(a(e.datetime)),this}function r(e){if(e=t(e),!e.data("timeago")){e.data("timeago",{datetime:i.datetime(e)});var r=t.trim(e.text());!(r.length>0)||i.isTime(e)&&e.attr("title")||e.attr("title",r)}return e.data("timeago")}function a(t){return i.inWords(n(t))}function n(t){return(new Date).getTime()-t.getTime()}t.timeago=function(e){return e instanceof Date?a(e):"string"==typeof e?a(t.timeago.parse(e)):"number"==typeof e?a(new Date(e)):a(t.timeago.datetime(e))};var i=t.timeago;t.extend(t.timeago,{settings:{refreshMillis:6e4,allowFuture:!1,strings:{prefixAgo:null,prefixFromNow:null,suffixAgo:"ago",suffixFromNow:"from now",seconds:"less than a minute",minute:"about a minute",minutes:"%d minutes",hour:"about an hour",hours:"about %d hours",day:"a day",days:"%d days",month:"about a month",months:"%d months",year:"about a year",years:"%d years",wordSeparator:" ",numbers:[]}},inWords:function(e){function r(r,n){var i=t.isFunction(r)?r(n,e):r,o=a.numbers&&a.numbers[n]||n;return i.replace(/%d/i,o)}var a=this.settings.strings,n=a.prefixAgo,i=a.suffixAgo;this.settings.allowFuture&&0>e&&(n=a.prefixFromNow,i=a.suffixFromNow);var o=Math.abs(e)/1e3,s=o/60,u=s/60,m=u/24,d=m/365,f=45>o&&r(a.seconds,Math.round(o))||90>o&&r(a.minute,1)||45>s&&r(a.minutes,Math.round(s))||90>s&&r(a.hour,1)||24>u&&r(a.hours,Math.round(u))||42>u&&r(a.day,1)||30>m&&r(a.days,Math.round(m))||45>m&&r(a.month,1)||365>m&&r(a.months,Math.round(m/30))||1.5>d&&r(a.year,1)||r(a.years,Math.round(d)),h=a.wordSeparator||"";return void 0===a.wordSeparator&&(h=" "),t.trim([n,f,i].join(h))},parse:function(e){var r=t.trim(e);return r=r.replace(/\.\d+/,""),r=r.replace(/-/,"/").replace(/-/,"/"),r=r.replace(/T/," ").replace(/Z/," UTC"),r=r.replace(/([\+\-]\d\d)\:?(\d\d)/," $1$2"),new Date(r)},datetime:function(e){var r=i.isTime(e)?t(e).attr("datetime"):t(e).attr("title");return i.parse(r)},isTime:function(e){return"time"===t(e).get(0).tagName.toLowerCase()}});var o={init:function(){var r=t.proxy(e,this);r();var a=i.settings;a.refreshMillis>0&&setInterval(r,a.refreshMillis)},update:function(r){t(this).data("timeago",{datetime:i.parse(r)}),e.apply(this)}};t.fn.timeago=function(t,e){var r=t?o[t]:o.init;if(!r)throw new Error("Unknown function name '"+t+"' for timeago");return this.each(function(){r.call(this,e)}),this},document.createElement("abbr"),document.createElement("time")});