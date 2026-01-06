# Cấu Hình Neovim

Đây là cấu hình Neovim cá nhân với Lazy.nvim plugin manager, tối ưu cho tôi.

## Cài Đặt

### Tải và Cài Đặt Cấu Hình

```bash
# Clone repository về máy
git clone https://github.com/Pax97/mynvim.git ~/.config/nvim

# Hoặc tải trực tiếp file init.vimrc cho Vi/Vim trên Linux
curl -fLo ~/.vimrc https://raw.githubusercontent.com/Pax97/mynvim/main/init.vimrc

# Hoặc sử dụng wget
wget -O ~/.vimrc https://raw.githubusercontent.com/Pax97/mynvim/main/init.vimrc
```

## Cấu Trúc Thư Mục

```
mynvim/
├── init.lua              # Entry point chính
├── init.vimrc            # Cấu hình Vim cơ bản (tự động sync từ settings.vim)
├── lua/
│   ├── config/           # Cấu hình chung
│   │   └── settings.vim  # File cấu hình Vim settings
│   └── plugins/          # Plugin configurations
└── lazy-lock.json        # Plugin version lock file
```

## Một Số Phím Tắt Quan Trọng

- `<Leader>` = `\` (backslash)
- `<LocalLeader>` = `<Space>` (phím cách)
- `<Leader>bd` - Đóng buffer hiện tại
- `<Esc>n` - Tắt highlight tìm kiếm

### Tự Động Bao Quanh Văn Bản (Visual Mode)

Bôi đen văn bản và nhấn:
- `(` hoặc `)` - Bao quanh bằng ngoặc tròn
- `[` hoặc `]` - Bao quanh bằng ngoặc vuông
- `{` hoặc `}` - Bao quanh bằng ngoặc nhọn
- `'` - Bao quanh bằng nháy đơn
- `"` - Bao quanh bằng nháy kép
- `` ` `` - Bao quanh bằng backtick
- `<` - Bao quanh bằng ngoặc nhọn

## Yêu Cầu Hệ Thống

- Neovim >= 0.11.0
- Git
- Node.js (cho một số LSP servers)

## Ghi Chú

File `init.vimrc` được tự động đồng bộ từ `lua/config/settings.vim` bằng GitHub Actions mỗi khi có thay đổi được push lên repository.

## License

MIT License
