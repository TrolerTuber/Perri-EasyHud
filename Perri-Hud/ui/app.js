$(() => {
    window.addEventListener("message", (event) => {
        let e = event.data;

        if (e.action === "HUD") {
            $("#vida").css({"width": Math.round(e.vidaa)});
            $("#comida").css({"width": Math.round(e.comidaa)});
            $("#agua").css({"width": Math.round(e.bebidaa)});
            $("#escudo").css({"width": Math.round(e.armaduraa)});

        }
    });
});
