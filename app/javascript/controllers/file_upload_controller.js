import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    readURL(event) {
        this.clearUploads(event)
        const files = event.target.files;
        if (files.length > 0) {
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                const reader = new FileReader();

                reader.onload = function (e) {
                    const div = $(`<div class="relative" data-file-name="${file.name}" data-file-size="${file.size}" data-allow-remove="true"></div>`);
                    div.append($(`<img src="${e.target.result}" alt="${file.name}">`));

                    const deleteButton = $('<div class="absolute top-0 right-0 bg-white w-6 h-6 text-center" data-action="click->file-upload#removeUpload"></div>');
                    deleteButton.append('x');
                    div.append(deleteButton);
                    $('#file-upload-content').append(div);
                };
                reader.readAsDataURL(file);
            }
        }
    }

    removeUpload(event) {
        const div = event.target.closest(".relative");
        const fileName = div.getAttribute("data-file-name")
        const fileSize = div.getAttribute('data-file-size');
        console.log(fileName, fileSize);
        // div.remove();
        this.clearUploads(event);
        const fileInputField = document.querySelector('#images-upload-field');
        fileInputField.files = [];
        fileInputField.value = '';
    }

    clearUploads(event) {
        const div = event.target.closest('.grid').querySelectorAll('.relative');
        for (let i = 0; i < div.length; i++) {
            if (div[i].getAttribute('data-allow-remove')) {
                div[i].remove();
            }
        }
    }
}
