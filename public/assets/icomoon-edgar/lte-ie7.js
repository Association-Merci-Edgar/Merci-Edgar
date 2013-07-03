/* Load this script using conditional IE comments if you need to support IE 7 and IE 6. */

window.onload = function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icomoon\'">' + entity + '</span>' + html;
	}
	var icons = {
			'ed-icon-ed-evenements' : '&#xe005;',
			'ed-icon-ed-equipe' : '&#xe006;',
			'ed-icon-ed-actualites' : '&#xe007;',
			'ed-icon-ed-comm' : '&#xe008;',
			'ed-icon-ed-logo' : '&#xe004;',
			'ed-icon-twitter' : '&#xe00b;',
			'ed-icon-ed_relations' : '&#xe000;',
			'ed-icon-ed-tv' : '&#xe001;',
			'ed-icon-ed-time' : '&#xe002;',
			'ed-icon-ed-search' : '&#xe003;',
			'ed-icon-check' : '&#xe009;',
			'ed-icon-email' : '&#xe00a;',
			'ed-icon-facebook' : '&#xe00c;',
			'ed-icon-moins' : '&#xe00d;',
			'ed-icon-plus' : '&#xe00e;',
			'ed-icon-rss' : '&#xe00f;',
			'ed-icon-ed-logo-bkg' : '&#xe011;',
			'ed-icon-flech-sml' : '&#xe010;',
			'ed-icon-share' : '&#xe012;',
			'ed-icon-vimeo' : '&#xe013;',
			'ed-icon-home' : '&#xe014;'
		},
		els = document.getElementsByTagName('*'),
		i, attr, html, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
		attr = el.getAttribute('data-icon');
		if (attr) {
			addIcon(el, attr);
		}
		c = el.className;
		c = c.match(/ed-icon-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
};