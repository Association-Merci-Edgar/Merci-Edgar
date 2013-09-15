/*
  Client Side Validations - SimpleForm - v2.1.0
  https://github.com/dockyard/client_side_validations-simple_form

  Copyright (c) 2013 DockYard, LLC
  Licensed under the MIT license
  http://www.opensource.org/licenses/mit-license.php
*/
!function(){ClientSideValidations.formBuilders["SimpleForm::FormBuilder"]={add:function(r,e,a){return this.wrappers[e.wrapper].add.call(this,r,e,a)},remove:function(r,e){return this.wrappers[e.wrapper].remove.call(this,r,e)},wrappers:{"default":{add:function(r,e,a){var s,t;return s=r.parent().find(""+e.error_tag+"."+e.error_class),t=r.closest(e.wrapper_tag),null==s[0]&&(s=$("<"+e.error_tag+"/>",{"class":e.error_class,text:a}),t.append(s)),t.addClass(e.wrapper_error_class),s.text(a)},remove:function(r,e){var a,s;return s=r.closest(""+e.wrapper_tag+"."+e.wrapper_error_class),s.removeClass(e.wrapper_error_class),a=s.find(""+e.error_tag+"."+e.error_class),a.remove()}},bootstrap:{add:function(r,e,a){var s,t,o;return s=r.parent().find(""+e.error_tag+"."+e.error_class),null==s[0]&&(o=r.closest(e.wrapper_tag),s=$("<"+e.error_tag+"/>",{"class":e.error_class,text:a}),o.append(s)),t=r.closest("."+e.wrapper_class),t.addClass(e.wrapper_error_class),s.text(a)},remove:function(r,e){var a,s,t;return s=r.closest("."+e.wrapper_class+"."+e.wrapper_error_class),t=r.closest(e.wrapper_tag),s.removeClass(e.wrapper_error_class),a=t.find(""+e.error_tag+"."+e.error_class),a.remove()}}}}}.call(this);