// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function search_selected_platform(slug) {
  document.getElementById('selected_platform').value=slug;
  var es = document.getElementsByClassName('platform_choice');
  for(var i=0;i<es.length;i++) {
    es[i].className = es[i].className.replace(/active/, '');
    if(es[i].id=='platform_choice_'+slug) {
      es[i].className += ' active';
    }
  }

}
