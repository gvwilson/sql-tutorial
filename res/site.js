// Convert keyed glossary references to links.
const patch_glossary_references = () => {
    for (const span of [...document.querySelectorAll("span[data-gloss]")]) {
	const target = span.getAttribute("data-gloss")
	const link = document.createElement("a")
	link.setAttribute("href", `#gloss:${target}`)
	span.parentElement.replaceChild(link, span)
	link.appendChild(span)
    }
}

// Patch tutorial content.
const patch = () => {
    patch_glossary_references()
}

// Run.
patch()
