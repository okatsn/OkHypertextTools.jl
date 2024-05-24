thead(s, h) = @htl("<$h>$s") # Because you cannot interpolate html syntax (interpolated "<" will be "&lt;")

function render_row(row)
    @htl("""
<tr>$((thead(item, "td") for item in string.(values(row))))
""")
end


"""
`render_table(df; caption=" ")` render `df::DataFrame` to a `HypertextLiteral.Result`.

# Example
```julia
df = DataFrame( :a => 1:5, :b => 6:10)
htxt = render_table(df)
msg0 = @htl(\"\"\"
    <html>

        <head>
            <style>
            h1 {
                font-size: 24px;
                font-weight: bold;
            }

            h2 {
                font-size: 18px;
                font-weight: bold;
            }

            table {
                border-collapse: collapse;
                width: 100%;
            }

            table, th, td {
                border: 1px solid black;
            }
            </style>
        </head>

        <body>
            <p>
                <p><h1> My Table: </h1></p>
                <p>\$htxt</p>
            </p>
        </body>
    </html>
\"\"\")


```

This function is inspired by the tutorial of https://github.com/JuliaPluto/HypertextLiteral.jl
"""
function render_table(df; caption=" ")
    @htl("""
    <table><caption><h3>$caption</h3></caption>
    <thead><tr>$((thead(col, "th") for col in string.(names(df))))<tbody>
    $((render_row(b) for b in eachrow(df)))</tbody></table>""")
end
