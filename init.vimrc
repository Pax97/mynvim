" Tes Git Workflow
" --- CẤU HÌNH HỆ THỐNG & HIỆU NĂNG ---
set nocompatible            " Tắt tương thích với vi cổ điển
set encoding=utf-8          " Hỗ trợ ký tự tiếng Việt/UTF-8
set hidden                  " Chuyển file không cần lưu ngay
set ttyfast                 " Tối ưu tốc độ vẽ màn hình (cho Vim)
set clipboard=unnamedplus   " Dùng chung clipboard với hệ thống (cần xclip/xsel)
set mouse=a                 " Cho phép dùng chuột trong Vim
set modelines=0             " Tính năng bảo mật vô hiệu các script đầu và cuối dòng
set noswapfile              " Tắt file file swap
set statusline=%f\ %y\ %m\ %r\ %h\ %w\ [%{&ff}]%=\ %l/%L\ (%p%%) " Tùy chỉnh thanh trạng thái để hiển thị định dạng file (OS Format)
set splitright
set scrolloff=10

autocmd BufLeave,FocusLost * silent! wall


" --- CẤU HÌNH GIAO DIỆN ---
syntax on                   " Bật highlight cú pháp
set number                  " Hiển thị số dòng
set relativenumber          " Số dòng tương đối (giúp di chuyển nhanh)
set cursorline              " Highlight dòng hiện tại
set termguicolors           " Hỗ trợ màu sắc 24-bit (cho các theme hiện đại)
set background=dark         " Tối ưu màu sắc cho nền tối
set laststatus=2            " Luôn hiển thị thanh trạng thái
set showcmd                 " Hiển thị lệnh đang gõ
set nowrap                  " Tự động xuống dòng khi văn bản quá dài

" --- CẤU HÌNH SOẠN THẢO (TAB & THỤT LỀ) ---
set tabstop=4               " 1 tab hiển thị bằng 2 dấu cách
set shiftwidth=4            " Độ rộng khi thụt lề bằng phím > <
set softtabstop=2           " Xử lý phím Tab như 2 dấu cách khi gõ
set expandtab               " Chuyển Tab thành khoảng trắng
set autoindent              " Tự động thụt lề dòng mới
set smartindent             " Thụt lề thông minh theo ngôn ngữ lập trình
set copyindent              " Sao chép cách thụt lề của dòng trước
set noshiftround            " Không làm tròn thụt lề

" --- CẤU HÌNH TÌM KIẾM ---
set hlsearch                " Tô sáng kết quả tìm kiếm
set incsearch               " Tìm ngay khi đang gõ
set ignorecase              " Không phân biệt hoa thường khi tìm kiếm
set smartcase               " Tự phân biệt hoa thường nếu gõ chữ hoa

" --- Keymaps
let mapleader = "\\"
let maplocalleader = "\<Space>"

" --------------- Close buffer
function! SmartClose()
    " 1. Lấy danh sách các buffer đang hiển thị (buflisted)
    let l:listed_buffers = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    " 2. Lấy ID của buffer hiện tại
    let l:current_buf = bufnr('%')
    " 3. Kiểm tra số lượng buffer
    if len(l:listed_buffers) <= 1
        " Nếu chỉ còn 1 buffer duy nhất, thực hiện lệnh thoát có xác nhận
        confirm quit
    else
        " Nếu còn nhiều hơn 1 buffer:
        " Nhảy sang buffer trước đó để giữ cửa sổ không bị đóng
        bprevious
        " Xóa buffer cũ (dùng execute để truyền ID vào lệnh)
        execute 'confirm bdelete ' . l:current_buf
    endif
endfunction

" Thiết lập phím tắt (Mapping)
nnoremap <silent> <leader>bd :call SmartClose()<CR>

" -------------- SmartClose End

" Nhấn ESC 2 lần để vừa xóa highlight tìm kiếm, vừa làm mới (redraw) màn hình
nnoremap <silent> <Esc>n :nohlsearch<CR>

" --- Chế độ Visual: Bôi đen rồi nhấn phím để bao quanh ---
" Ngoặc tròn ()
vnoremap ( <esc>`>a)<esc>`<i(<esc>
vnoremap ) <esc>`>a)<esc>`<i(<esc>

" Ngoặc vuông []
vnoremap [ <esc>`>a]<esc>`<i[<esc>
vnoremap ] <esc>`>a]<esc>`<i[<esc>

" Ngoặc nhọn {}
vnoremap { <esc>`>a}<esc>`<i{<esc>
vnoremap } <esc>`>a}<esc>`<i{<esc>

" Nháy đơn '' và Nháy kép ""
vnoremap ' <esc>`>a'<esc>`<i'<esc>
vnoremap " <esc>`>a"<esc>`<i"<esc>

" Dấu huyền (Backtick) `` - Dùng cho Markdown/Code
vnoremap ` <esc>`>a`<esc>`<i`<esc>

" Dấu ngoặc nhọn nhọn <>
vnoremap < <esc>`>a><esc>`<i<<esc>
