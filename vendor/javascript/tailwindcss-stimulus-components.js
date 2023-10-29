import {Controller as t} from "@hotwired/stimulus";

var e = Object.defineProperty;
var S = (t, a, i) => a in t ? e(t, a, {enumerable: !0, configurable: !0, writable: !0, value: i}) : t[a] = i;
var s = (t, e, a) => (S(t, "symbol" != typeof e ? e + "" : e, a), a);
var a = new Map;

async function o(t, e, a = null) {
    e ? await l(t, a) : await u(t, a)
}

async function l(t, e = null) {
    try {
        t.classList.remove("hidden"), await C("enter", t, e)
    } finally {
        y(t, e)
    }
}

async function u(t, e = null) {
    try {
        await C("leave", t, e)
    } finally {
        t.classList.add("hidden"), y(t, e)
    }
}

async function C(t, e, i) {
    y(e, i);
    let n = w(t, e, i);
    a.set(e, t), c(e, n.transition), c(e, n.start), f(e, n.end), await A(), f(e, n.start), c(e, n.end), await D(e), f(e, n.end), f(e, n.transition), "originalClass" in e.dataset && "" !== e.dataset.originalClass && c(e, e.dataset.originalClass.split(" ")), a.delete(e)
}

function w(t, e, a) {
    let i = e.dataset, n = a ? `${a}-${t}` : t, r = `transition${t.charAt(0).toUpperCase() + t.slice(1)}`;
    return {
        transition: i[r] ? i[r].split(" ") : [n],
        start: i[`${r}From`] ? i[`${r}From`].split(" ") : [`${n}-from`],
        end: i[`${r}To`] ? i[`${r}To`].split(" ") : [`${n}-to`]
    }
}

function c(t, e) {
    t.classList.add(...e)
}

function f(t, e) {
    t.classList.remove(...e)
}

function A() {
    return new Promise((t => {
        requestAnimationFrame((() => {
            requestAnimationFrame(t)
        }))
    }))
}

function D(t) {
    return Promise.all(t.getAnimations().map((t => t.finished)))
}

async function y(t, e = null) {
    if ("originalClass" in t.dataset || (t.dataset.originalClass = [...t.classList].filter((t => "hidden" !== t)).join(" ")), a.has(t)) {
        let i = a.get(t), n = w(i, t, e);
        f(t, n.transition + n.start + n.end), "originalClass" in t.dataset && "" !== t.dataset.originalClass && c(t, t.dataset.originalClass.split(" ")), a.delete(t)
    }
}

var i = class extends t {
    connect() {
        setTimeout((() => {
            l(this.element)
        }), this.showDelayValue), this.hasDismissAfterValue && setTimeout((() => {
            this.close()
        }), this.dismissAfterValue)
    }

    close() {
        u(this.element).then((() => {
            this.element.remove()
        }))
    }
};
s(i, "values", {
    dismissAfter: Number,
    showDelay: {type: Number, default: 0},
    removeDelay: {type: Number, default: 1100}
});
var n = class extends t {
    connect() {
        this.timeout = null
    }

    save() {
        clearTimeout(this.timeout), this.timeout = setTimeout((() => {
            this.statusTarget.textContent = this.submittingTextValue, this.formTarget.requestSubmit()
        }), this.submitDurationValue)
    }

    success() {
        this.setStatus(this.successTextValue)
    }

    error() {
        this.setStatus(this.errorTextValue)
    }

    setStatus(t) {
        this.statusTarget.textContent = t, this.timeout = setTimeout((() => {
            this.statusTarget.textContent = ""
        }), this.statusDurationValue)
    }
};
s(n, "targets", ["form", "status"]), s(n, "values", {
    submitDuration: {type: Number, default: 1e3},
    statusDuration: {type: Number, default: 2e3},
    submittingText: {type: String, default: "Saving..."},
    successText: {type: String, default: "Saved!"},
    errorText: {type: String, default: "Unable to save."}
});
var r = class extends t {
    update() {
        this.preview = this.colorTarget.value
    }

    set preview(t) {
        this.previewTarget.style[this.styleValue] = t;
        let e = this._getContrastYIQ(t);
        "color" === this.styleValue ? this.previewTarget.style.backgroundColor = e : this.previewTarget.style.color = e
    }

    _getContrastYIQ(t) {
        t = t.replace("#", "");
        let e = 128, a = parseInt(t.substr(0, 2), 16), i = parseInt(t.substr(2, 2), 16),
            n = parseInt(t.substr(4, 2), 16);
        return (299 * a + 587 * i + 114 * n) / 1e3 >= e ? "#000" : "#fff"
    }
};
s(r, "targets", ["preview", "color"]), s(r, "values", {style: {type: String, default: "backgroundColor"}});
var h = class extends t {
    connect() {
        this.hasButtonTarget && (this.buttonTarget.addEventListener("keydown", this._onMenuButtonKeydown), this.buttonTarget.setAttribute("aria-haspopup", "true"))
    }

    disconnect() {
        this.hasButtonTarget && (this.buttonTarget.removeEventListener("keydown", this._onMenuButtonKeydown), this.buttonTarget.removeAttribute("aria-haspopup"))
    }

    openValueChanged() {
        o(this.menuTarget, this.openValue), !0 === this.openValue && this.hasMenuItemTarget && this.menuItemTargets[0].focus()
    }

    show() {
        this.openValue = !0
    }

    hide(t) {
        t.target.nodeType && !1 === this.element.contains(t.target) && this.openValue && (this.openValue = !1)
    }

    toggle() {
        this.openValue = !this.openValue
    }

    nextItem() {
        let t = Math.min(this.currentItemIndex + 1, this.menuItemTargets.length - 1);
        this.menuItemTargets[t].focus()
    }

    previousItem() {
        let t = Math.max(this.currentItemIndex - 1, 0);
        this.menuItemTargets[t].focus()
    }

    get currentItemIndex() {
        return this.menuItemTargets.indexOf(document.activeElement)
    }
};
s(h, "targets", ["menu", "button", "menuItem"]), s(h, "values", {open: Boolean, default: !1});
var d = class extends t {
    disconnect() {
        this.close()
    }

    open() {
        this.openValue = !0
    }

    close() {
        this.openValue = !1
    }

    closeBackground(t) {
        t.target === this.backgroundTarget && this.close()
    }

    async openValueChanged() {
        this.openValue ? (this.containerTarget.focus(), this.lockScroll(), l(this.backgroundTarget), l(this.containerTarget)) : (u(this.containerTarget), await u(this.backgroundTarget), this.unlockScroll())
    }

    lockScroll() {
        this.restoreScrollValue && (this.saveScrollPosition(), document.body.style.top = `-${this.scrollPosition}px`);
        let t = window.innerWidth - document.documentElement.clientWidth;
        document.body.style.paddingRight = `${t}px`, document.body.classList.add("fixed", "inset-x-0", "overflow-hidden")
    }

    unlockScroll() {
        document.body.style.paddingRight = null, document.body.classList.remove("fixed", "inset-x-0", "overflow-hidden"), this.restoreScrollValue && (this.restoreScrollPosition(), document.body.style.top = null)
    }

    saveScrollPosition() {
        this.scrollPosition = window.pageYOffset || document.body.scrollTop
    }

    restoreScrollPosition() {
        void 0 !== this.scrollPosition && (document.documentElement.scrollTop = this.scrollPosition)
    }
};
s(d, "targets", ["container", "background"]), s(d, "values", {
    open: {type: Boolean, default: !1},
    restoreScroll: {type: Boolean, default: !0}
});
var m = class extends t {
    openValueChanged() {
        o(this.contentTarget, this.openValue), this.shouldAutoDismiss && this.scheduleDismissal()
    }

    show(t) {
        this.shouldAutoDismiss && this.scheduleDismissal(), this.openValue = !0
    }

    hide() {
        this.openValue = !1
    }

    toggle() {
        this.openValue = !this.openValue
    }

    get shouldAutoDismiss() {
        return this.openValue && this.hasDismissAfterValue
    }

    scheduleDismissal() {
        this.hasDismissAfterValue && (this.cancelDismissal(), this.timeoutId = setTimeout((() => {
            this.hide(), this.timeoutId = void 0
        }), this.dismissAfterValue))
    }

    cancelDismissal() {
        "number" == typeof this.timeoutId && (clearTimeout(this.timeoutId), this.timeoutId = void 0)
    }
};
s(m, "targets", ["content"]), s(m, "values", {dismissAfter: Number, open: {type: Boolean, default: !1}});
var g = class extends h {
    openValueChanged() {
        o(this.overlayTarget, this.openValue), o(this.menuTarget, this.openValue), this.hasCloseTarget && o(this.closeTarget, this.openValue)
    }
};
s(g, "targets", ["menu", "overlay", "close"]);
var p = class extends t {
    connect() {
        this.anchor && (this.indexValue = this.tabTargets.findIndex((t => t.id === this.anchor))), this.showTab()
    }

    change(t) {
        "SELECT" === t.currentTarget.tagName ? this.indexValue = t.currentTarget.selectedIndex : t.currentTarget.dataset.index ? this.indexValue = t.currentTarget.dataset.index : t.currentTarget.dataset.id ? this.indexValue = this.tabTargets.findIndex((e => e.id == t.currentTarget.dataset.id)) : this.indexValue = this.tabTargets.indexOf(t.currentTarget), window.dispatchEvent(new CustomEvent("tsc:tab-change"))
    }

    nextTab() {
        this.indexValue = Math.min(this.indexValue + 1, this.tabsCount - 1)
    }

    previousTab() {
        this.indexValue = Math.max(this.indexValue - 1, 0)
    }

    firstTab() {
        this.indexValue = 0
    }

    lastTab() {
        this.indexValue = this.tabsCount - 1
    }

    indexValueChanged() {
        this.showTab(), this.updateAnchorValue && (location.hash = this.tabTargets[this.indexValue].id)
    }

    showTab() {
        this.panelTargets.forEach(((t, e) => {
            let a = this.tabTargets[e];
            e === this.indexValue ? (t.classList.remove("hidden"), this.hasInactiveTabClass && a?.classList?.remove(...this.inactiveTabClasses), this.hasActiveTabClass && a?.classList?.add(...this.activeTabClasses)) : (t.classList.add("hidden"), this.hasActiveTabClass && a?.classList?.remove(...this.activeTabClasses), this.hasInactiveTabClass && a?.classList?.add(...this.inactiveTabClasses))
        })), this.hasSelectTarget && (this.selectTarget.selectedIndex = this.indexValue)
    }

    get tabsCount() {
        return this.tabTargets.length
    }

    get anchor() {
        return document.URL.split("#").length > 1 ? document.URL.split("#")[1] : null
    }
};
s(p, "classes", ["activeTab", "inactiveTab"]), s(p, "targets", ["tab", "panel", "select"]), s(p, "values", {
    index: 0,
    updateAnchor: Boolean
});
var T = class extends t {
    toggle(t) {
        this.openValue = !this.openValue, this.animate()
    }

    hide() {
        this.openValue = !1, this.animate()
    }

    show() {
        this.openValue = !0, this.animate()
    }

    animate() {
        this.toggleableTargets.forEach((t => {
            o(t, this.openValue)
        }))
    }
};
s(T, "targets", ["toggleable"]), s(T, "values", {open: {type: Boolean, default: !1}});
export {
    i as Alert,
    n as Autosave,
    r as ColorPreview,
    h as Dropdown,
    d as Modal,
    m as Popover,
    g as Slideover,
    p as Tabs,
    T as Toggle
};

