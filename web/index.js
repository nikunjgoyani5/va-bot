/// THIS METHOD IS FULLY WORKING = DON'T REMOVE IN ANY HOW
/*
window.loadPSPDFKit = function(pdfUrl) {
    if (!window.PSPDFKit) {
        console.error("PSPDFKit is not loaded!");
        return;
    }

    PSPDFKit.load({
        document: pdfUrl,
        container: "#pspdfkit-container",
        enableToolbar: true,
        enableAnnotations: true,
        enableForms: true,
    }).then(instance => {
        console.log("✅ PSPDFKit successfully loaded!", instance);
        instance.setViewState(instance.viewState.set("interactionMode", PSPDFKit.InteractionMode.EDIT));
    }).catch(error => console.error("PSPDFKit failed to load", error));
};*/
/// ===================================================== ///
/*window.loadPSPDFKit = function(pdfUrl) {
    if (!window.PSPDFKit) {
        console.error("PSPDFKit is not loaded!");
        return;
    }

    PSPDFKit.load({
        document: pdfUrl,
        container: "#pspdfkit-container",
        enableToolbar: true,
        enableAnnotations: true,
        enableForms: true,
    }).then(instance => {
        console.log("✅ PSPDFKit successfully loaded!", instance);
        instance.setViewState(instance.viewState.set("interactionMode", PSPDFKit.InteractionMode.EDIT));

        // Send the instance info to Flutter
        window.parent.postMessage({ type: "PSPDFKitLoaded", data: instance }, "*");
    }).catch(error => {
        console.error("PSPDFKit failed to load", error);
        window.parent.postMessage({ type: "PSPDFKitError", error: error.toString() }, "*");
    });
};*/



window.pspdfkitInstance = null; // Store the instance globally

window.loadPSPDFKit = function (pdfUrl) {
    if (!window.PSPDFKit) {
        console.error("PSPDFKit is not loaded!");
        window.parent.postMessage({ type: "PSPDFKitError", error: "PSPDFKit is not loaded!" }, "*");
        return;
    }

    PSPDFKit.load({
        document: pdfUrl,
        container: "#pspdfkit-container",
        enableToolbar: true,
        enableAnnotations: true,
        enableForms: true,
    }).then(instance => {
        console.log("✅ PSPDFKit successfully loaded!");

        // Store instance globally
        window.pspdfkitInstance = instance;

         instance.addEventListener("viewState.change", (viewState) => {
                    let currentPage = viewState.currentPageIndex;
                    window.parent.postMessage({ type: "CurrentPage", data: currentPage }, "*");
                });

        // Send confirmation to Flutter
        window.parent.postMessage({ type: "PSPDFKitLoaded", message: "PSPDFKit successfully loaded!" }, "*");
    }).catch(error => {
        console.error("PSPDFKit failed to load", error);
        window.parent.postMessage({ type: "PSPDFKitError", error: error.toString() }, "*");
    });
};

// Expose functions to interact with the instance
window.getDocumentMetadata = function () {
    if (!window.pspdfkitInstance) {
        console.error("PSPDFKit instance not available");
        return;
    }

    let metadata = {
        totalPages: window.pspdfkitInstance.totalPageCount,
        currentPage: window.pspdfkitInstance.viewState.currentPageIndex
    };

    window.parent.postMessage({ type: "DocumentMetadata", data: metadata }, "*");
};

window.goToPage = function (pageNumber) {
    if (!window.pspdfkitInstance) {
        console.error("PSPDFKit instance not available");
        return;
    }

    window.pspdfkitInstance.setViewState(
        window.pspdfkitInstance.viewState.set("currentPageIndex", pageNumber)
    );
};

window.setZoom = function (zoomPercentage) {
    if (!window.pspdfkitInstance) {
        console.error("PSPDFKit instance not available");
        return;
    }


    // Convert percentage to zoom scale
    let newZoom = Math.max(0.1, Math.min(zoomPercentage / 100, 5.0));

    // Set the new zoom level
    window.pspdfkitInstance.setViewState(
        window.pspdfkitInstance.viewState.set("zoom", newZoom)
    );

    // Notify parent window about the zoom change
    window.parent.postMessage({ type: "ZoomChanged", zoom: newZoom * 100 }, "*");
};


window.saveEditedPDF = function (fileName = "edited.pdf") {
    if (!window.pspdfkitInstance) {
        console.error("PSPDFKit instance not available");
        return;
    }

    window.pspdfkitInstance.exportPDF().then((pdfArrayBuffer) => {
        let pdfBlob = new Blob([pdfArrayBuffer], { type: "application/pdf" });

        let reader = new FileReader();
        reader.readAsDataURL(pdfBlob);
        reader.onloadend = function () {
            let base64data = reader.result.split(',')[1]; // Extract Base64

            // Create a download link with the specified file name
            let downloadLink = document.createElement("a");
            downloadLink.href = reader.result;
            downloadLink.download = fileName;
            document.body.appendChild(downloadLink);
            downloadLink.click();
            document.body.removeChild(downloadLink);
        };
    }).catch(error => {
        console.error("Failed to export PDF", error);
    });
};



window.printPDF = function () {
    if (!window.pspdfkitInstance) {
        console.error("PSPDFKit instance not available");
        return;
    }

    window.pspdfkitInstance.exportPDF().then((pdfArrayBuffer) => {
        let pdfBlob = new Blob([pdfArrayBuffer], { type: "application/pdf" });
        let pdfUrl = URL.createObjectURL(pdfBlob);
        // Open PDF in a new tab for printing
        let printWindow = window.open(pdfUrl);
        if (printWindow) {
            printWindow.onload = function () {
                printWindow.print();
            };
        } else {
            console.error("Failed to open print window");
        }
    }).catch(error => {
        console.error("Failed to export PDF", error);
        window.parent.postMessage({ type: "PSPDFKitError", error: error.toString() }, "*");
    });
};
