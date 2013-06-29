/* Load this script using conditional IE comments if you need to support IE 7 and IE 6. */

window.onload = function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'icomoon\'">' + entity + '</span>' + html;
	}
	var icons = {
			'icon-ed-evenements' : '&#xe005;',
			'icon-ed-equipe' : '&#xe006;',
			'icon-ed-actualites' : '&#xe007;',
			'icon-ed-comm' : '&#xe008;',
			'icon-ed-logo' : '&#xe004;',
			'icon-twitter' : '&#xe00b;',
			'icon-ed_relations' : '&#xe000;',
			'icon-ed-tv' : '&#xe001;',
			'icon-ed-time' : '&#xe002;',
			'icon-ed-search' : '&#xe003;',
			'icon-check' : '&#xe009;',
			'icon-email' : '&#xe00a;',
			'icon-facebook' : '&#xe00c;',
			'icon-moins' : '&#xe00d;',
			'icon-plus' : '&#xe00e;',
			'icon-rss' : '&#xe00f;'
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
		c = c.match(/icon-[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
};