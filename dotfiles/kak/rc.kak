## GENERAL ##

# Use <space> as user mode key (leader key)
map global normal <space> , -docstring 'leader'
map global normal <backspace> <space> -docstring 'remove all sels except main' # this is space by default
map global normal <a-backspace> <a-space> -docstring 'remove main sel'

## TERMINAL ##

hook global WinCreate .* %{
    set-option global termcmd 'foot sh -c'
}

define-command -override \
        -docstring "Duplicate the current window in a new terminal sharing the same session" \
        dup-window \
	%{ nop %sh{ footclient -N kak -c $kak_session $kak_buffile } }

map global user w ': dup-window<ret>' -docstring "Duplicate the window"

## CLIPBOARD ##
hook global WinCreate .* %{ kakboard-enable }

## FZF ##
#
# Docs: https://github.com/andreyorst/fzf.kak
#
# TODO:
# 
# - A binding to search including gitignored files (rg --hidden).
# 
map global user f ': fzf-mode<ret>' -docstring 'fzf'
map global user <space> ': require-module fzf; require-module fzf-file; fzf-file<ret>' -docstring 'Find files'

hook global ModuleLoaded fzf-file %{
    set-option global fzf_file_command 'rg --files --follow' 
}

## RANGER ##

define-command -override -docstring 'Open a file with ranger' \
	-params 0..1 \
	browse-file \
	%{ eval %sh{
        	TMPFILE=`mktemp`;
        	foot ranger --choosefile=$TMPFILE $1;
        	if [[ -s $TMPFILE ]]
        	then
                    	echo "edit \"`cat $TMPFILE`\"";
		else
        		echo nop;
		fi
    	} }

map global user r ': browse-file %sh{dirname $kak_buffile} <ret>' -docstring 'Browse files with ranger'

## NIX ##
#
hook global BufCreate ^.*\.nix$ %{
    set-option buffer formatcmd 'nixfmt'
}

hook global BufWritePre ^.*\.nix$ %{
    eval format
}

## LSP ##
#
# Docs: https://github.com/kak-lsp/kak-lsp
# 
eval %sh{kak-lsp --kakoune -s $kak_session --log /tmp/kak-lsp.log}
map global user l %{: enter-user-mode lsp<ret>} -docstring "LSP mode"

hook global WinSetOption filetype=(rust|python|go|javascript|typescript|c|cpp) %{
    lsp-enable-window
}

## Rust ##
hook global WinSetOption filetype=rust %{
    hook window BufWritePre .* lsp-formatting-sync
}
 
