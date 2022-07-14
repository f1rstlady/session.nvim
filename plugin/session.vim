if exists("g:loaded_session")
  finish
endif
let g:loaded_session = 1

let g:session_name = get(g:, 'session_name', 'Session.vim')

function! s:SessionExists()
  return filereadable(g:session_name)
endfunction

function! s:LoadSession()
  " If a session was already loaded, do nothing.
  if get(s:, 'session_loaded', 0)
    return
  endif

  if s:SessionExists() && !get(s:, 'read_from_stdin', 0) && (argc() == 0)
    let s:save_session = 1
    let s:session_loaded = 1
    execute 'source ' . escape(g:session_name, '%')
    echohl ModeMsg | echomsg 'Session loaded' | echohl Normal
  else
    let s:save_session = 0
  endif
endfunction

function! s:RemoveSession()
  call delete(g:session_name)
endfunction

function! s:SaveSession()
  if s:save_session
    execute 'mksession! '.g:session_name
  endif
endfunction

augroup Session
  autocmd! VimEnter * nested call s:LoadSession()
  autocmd! VimLeave *        call s:SaveSession()
  autocmd! StdinReadPost * let s:read_from_stdin = 1
augroup END

function! s:ToggleSession()
  echohl ModeMsg
  if get(s:, 'save_session', 0)
    let s:save_session = 0
    call s:RemoveSession()
    echomsg 'Session removed'
  elseif !s:SessionExists()
      \ || inputdialog('A session already exists. Do you want to overwrite it? (y/n) ')[0] ==? 'y'
    redraw
    let s:save_session = 1
    call s:SaveSession()
    echomsg 'Session created'
  endif
  echohl Normal
endfunction

command! -bar ToggleSession call s:ToggleSession()
