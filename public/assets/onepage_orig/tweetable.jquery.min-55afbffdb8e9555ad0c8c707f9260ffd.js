/*
 * tweetable 1.7.0 - jQuery twitter feed plugin
 *
 * Copyright (c) 2009 Philip Beel (http://www.theodin.co.uk/)
 * Dual licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
 * and GPL (http://www.opensource.org/licenses/gpl-license.php) licenses.
 *
 * With modifications from Philipp Robbel (http://www.robbel.com/) and Patrick DW (stackoverflow)
 * for IE compatibility.
 *
 * Revision: $Id: jquery.tweetable.js 2012-07-08 $ 
 *
 */
!function(){jQuery.fn.tweetable=function(e){var t={limit:5,username:"philipbeel",time:!1,rotate:!1,speed:5e3,replies:!1,position:"append",failed:"No tweets available",html5:!1,retweets:!1,onComplete:function(){}},e=jQuery.extend(t,e);return this.each(function(){var e,s,a,i,r=jQuery(this),l=jQuery('<ul class="tweetList">')[t.position.toLowerCase()+"To"](r),n=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],u="https://api.twitter.com/1/statuses/user_timeline.json?include_entities=false&suppress_response_codes=true&screen_name=",c="&count=",p="&exclude_replies=",o="&include_rts=";jQuery.getJSON(u+t.username+c+(t.limit+5)+p+t.replies+o+t.retweets+"&callback=?",r,function(r){function u(){c.eq(o++).fadeOut(400,function(){o=o===p?0:o,c.eq(o).fadeIn(400)})}if(e=r&&r.error||null)return l.append('<li class="tweet_content"><p class="tweet_link">'+t.failed+"</p></li>"),void 0;if(jQuery.each(r,function(e,r){if(!(e>=t.limit)&&(l.append('<li class="tweet_content_'+e+'"><p class="tweet_link_'+e+'">'+r.text.replace(/#(.*?)(\s|$)/g,'<span class="hash">#$1 </span>').replace(/(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/gi,'<a href="$&">$&</a> ').replace(/@(.*?)(\s|\(|\)|$)/g,'<a href="http://twitter.com/$1">@$1 </a>$2')+"</p></li>"),t.time===!0)){for(i=0;12>=i;i++)n[i]===r.created_at.substr(4,3)&&(a=i+1,s=10>a?"0"+a:a);var u=r.created_at.substr(26,4)+"-"+s+"-"+r.created_at.substr(8,2)+"T"+r.created_at.substr(11,8)+"Z";jQuery(".tweet_link_"+e).append('<p class="timestamp"><'+(t.html5?'time datetime="'+u+'"':"small")+"> "+r.created_at.substr(8,2)+"/"+s+"/"+r.created_at.substr(26,4)+", "+r.created_at.substr(11,5)+"</"+(t.html5?"time":"small")+"></p>")}}),t.rotate===!0){var c=l.find("li"),p=c.length||null,o=0,d=t.speed;if(!p)return;c.slice(1).hide(),setInterval(u,d)}t.onComplete(l)})})}}(jQuery);