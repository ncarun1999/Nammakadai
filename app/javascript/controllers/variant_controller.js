import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['optionSet', 'addOptionSet', 'variants', 'toggleButton', 'valueFields', 'optionSetFirstElement']

    initialize() {
        this.setupInputListener();
    }

    setupInputListener() {
        document.querySelectorAll('.value-fields').forEach((valueField) => {
            valueField.addEventListener("input", (event) => {
                const lastValueField = valueField.lastElementChild;

                if (event.target === lastValueField && lastValueField.value.trim() !== "") {
                    this.addNewValueField(valueField);
                    this.variantsTarget.classList.remove("hidden");
                }

                let removeBg = true
                const allOtherValueFields = event.target.closest('.value-fields').querySelectorAll('input');
                allOtherValueFields.forEach((otherValueField) => {
                    if ((event.target !== otherValueField) && (otherValueField.value === event.target.value)) {
                        event.target.classList.add("bg-red-300");
                        removeBg = false
                    } else {
                        if (removeBg) {
                            event.target.classList.remove("bg-red-300");
                        }
                    }
                });
            });
        });
    }

    addNewValueField(valueField) {
        const lastValueField = valueField.lastElementChild;
        const optionSetId = lastValueField.closest('.option-set-fields').querySelector('select').getAttribute('data-field-id')
        if (lastValueField.value.trim() !== "") {
            const newValueField = lastValueField.cloneNode(true);
            newValueField.id = Date.now();
            newValueField.name = `product[option_names_attributes][${optionSetId}][option_values_attributes][${Date.now()}][name]`;
            newValueField.value = "";
            newValueField.placeholder = "Add another option";
            valueField.appendChild(newValueField);
        }
    }

    addOptionSet() {
        const newOptionSet = this.optionSetFirstElementTarget.cloneNode(true);
        const selectField = newOptionSet.querySelector('select');
        const uniqueId = Date.now();
        selectField.id = uniqueId;
        selectField.name = `product[option_names_attributes][${uniqueId}][name]`
        selectField.setAttribute('data-field-id', uniqueId);

        newOptionSet.querySelectorAll('input').forEach((input) => {
            input.value = '';
        });

        // Only one input field for value
        const valueFields = newOptionSet.querySelector('[data-variant-target="valueFields"]');
        const name = `product[option_names_attributes][${uniqueId}][option_values_attributes][${Date.now()}][name]`
        valueFields.innerHTML = `<input type="text" name="${name}" placeholder="Medium" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500">`;

        this.optionSetTarget.appendChild(document.createElement('hr'));
        this.optionSetTarget.appendChild(newOptionSet);
        this.setupInputListener();
    }

    showOptionSet(event) {
        this.toggleButtonTarget.classList.add("hidden");
        this.optionSetTarget.classList.remove("hidden");
        this.addOptionSetTarget.classList.remove("hidden");
        this.optionSetTarget.querySelectorAll('input, select').forEach((input) => {
            input.disabled = false;
        });
    }
}
