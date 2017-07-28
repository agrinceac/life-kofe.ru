window.addEventListener("load", function(){
    document.body.innerHTML =
        document.body.innerHTML.replace(/textareajsincluderalias/g, "textarea");
});