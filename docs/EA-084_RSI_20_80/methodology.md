📚 System Documentation & Knowledge Base

Thư mục này chứa toàn bộ tài liệu kỹ thuật, hướng dẫn kiến trúc, quy chuẩn lập trình, quy trình vận hành tiêu chuẩn (SOP), cũng như các tài liệu hướng dẫn người dùng cho dự án.

📁 Cấu trúc Thư mục

Docs/
├── architecture/          # Tài liệu thiết kế hệ thống và kiến trúc phần mềm
│   ├── system_overview.md # Tổng quan kiến trúc hệ thống
│   └── data_flow.png      # Sơ đồ luồng dữ liệu
├── api/                   # Tài liệu mô tả các cổng kết nối API, REST, WebSocket
│   └── broker_api.md      # Kết nối API với Broker / Exchange
├── guidelines/            # Quy chuẩn và nguyên tắc phát triển
│   ├── coding_standards.md # Quy chuẩn viết code (Clean Code, Naming Conventions)
│   └── git_workflow.md    # Quy trình quản lý branch và commit (Gitflow)
├── deployment/            # Hướng dẫn cài đặt, cấu hình và triển khai
│   ├── setup_guide.md     # Hướng dẫn thiết lập môi trường phát triển (Dev Environment)
│   └── server_config.md   # Cấu hình máy chủ / VPS / Docker
├── user_manuals/          # Hướng dẫn sử dụng cho người dùng cuối / Trader
│   └── ea_user_guide.md   # Hướng dẫn cài đặt và vận hành EA
└── README.md              # Tài liệu hướng dẫn này (Index)



🛠️ Quy chuẩn Viết Tài liệu (Documentation Standards)

Để đảm bảo tính nhất quán và dễ đọc, tất cả các tài liệu trong thư mục này cần tuân thủ các quy tắc sau:

Định dạng Markdown: Sử dụng cú pháp Markdown chuẩn (.md) cho mọi tệp tài liệu văn bản.

Cấu trúc Tiêu đề:

# cho Tiêu đề chính (Title - chỉ sử dụng 1 lần ở đầu trang).

## cho các Mục chính (Sections).

### cho các Mục phụ (Subsections).

Mã nguồn & Cú pháp (Code Blocks): Chỉ định rõ ngôn ngữ lập trình cho các khối code (VD: python`, bash, ````json).

Biểu đồ & Sơ đồ: Khuyến khích sử dụng cú pháp Mermaid.js để vẽ sơ đồ trực tiếp trong tệp Markdown (giúp dễ quản lý phiên bản qua Git).

Ví dụ sơ đồ luồng Mermaid:

graph LR;
    A[Data Feed] --> B[Indicator Engine];
    B --> C[Strategy Logic];
    C --> D[Execution Handler];


🚀 Hướng dẫn Bắt đầu Nhanh (Quick Links)

📖 Người mới bắt đầu? Đọc ngay Setup Guide để cài đặt môi trường.

💻 Dành cho Developer: Xem Coding Standards trước khi thực hiện pull request.

⚙️ Dành cho Trader / Vận hành: Đọc EA User Guide để biết cách thiết lập hệ thống trên VPS.

📝 Nhật ký Bảo trì Tài liệu

Ngày cập nhật

Người thực hiện

Nội dung thay đổi

2026-09-28

System Admin

Khởi tạo cấu trúc tài liệu thư mục Docs

Lưu ý: Tài liệu cần được cập nhật song song mỗi khi có thay đổi quan trọng về mặt cấu trúc hệ thống hoặc logic xử lý.
