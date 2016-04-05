/* brewsearch examples */

// Search an RGB color string
brewsearch "255 127 14"

// Display the returned values
ret li

// Search a named color style that does not exist on the system
brewsearch "xkcd7327"

// Display the returned values
ret li

// Search a named color style that does exist if the user installed the XKCD colors
brewsearch "xkcd327"

// Display the returned values
ret li

// Display a known color style
brewsearch "ltbluishgray"

// Display the returned values
ret li

