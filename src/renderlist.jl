"""
`render_list(items)` converts a vector of strings into an HTML unordered list.
"""
function render_list(items)
    @htl("""
    <ul>
        $((@htl("<li>$item</li>") for item in items))
    </ul>
    """)
end
