apex.message.alert("The book is not current available for modify");

var drawerBody = document.querySelector(".t-Drawer-body");
drawerBody.style.display = "none";

setTimeout(function () {
  apex.navigation.dialog.close(true);
}, 2000);
