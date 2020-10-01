var coll = document.getElementsByClassName("collapsible");
var i;
    
for (i = 0; i < coll.length; i++) {
	var link = coll[i].nextElementSibling;
	coll[i].style.lineHeight = link.offsetHeight + "px";
}

for (i = 0; i < coll.length; i++) {
	var is_active = coll[i].classList.contains("active") || coll[i].parentElement.classList.contains("parent");
	toggle_state(is_active, coll[i]);
	
	coll[i].addEventListener("click", function() {
		this.classList.toggle("active");
		var is_active = this.classList.contains("active")
		toggle_state(is_active, this);
	});
}

function toggle_state(is_active, element){
	if (is_active){
		element.innerHTML = "-";
	} else {
		element.innerHTML = "+";
	}
	

	var parent = element.parentElement;
	var content = parent.getElementsByTagName("UL")[0];
	if (is_active) {
		content.style.display = "block";
	} else {
		content.style.display = "none";
	}
}
