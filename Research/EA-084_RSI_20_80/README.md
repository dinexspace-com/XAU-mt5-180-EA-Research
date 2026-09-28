🔬 Research & Market Analysis Module

Thư mục này là không gian lưu trữ và quản lý toàn bộ tài liệu nghiên cứu, phân tích định lượng (Quantitative Analysis), giả thuyết giao dịch (Trading Hypotheses), cùng các báo cáo chuyên sâu về thị trường tài chính trước khi đưa vào phát triển hệ thống thử nghiệm (Backtest).

📁 Cấu trúc Thư mục

Research/
├── academic_papers/     # Các bài báo khoa học, whitepapers, tài liệu học thuật (PDF/Link)
├── market_analysis/     # Báo cáo phân tích vĩ mô, chu kỳ thị trường và tài sản
│   ├── macro/           # Phân tích kinh tế vĩ mô (Lãi suất, Lạm phát, CPI...)
│   └── technical/       # Phân tích hành vi giá (Price Action), Indicator, On-chain...
├── strategies/          # Tài liệu mô tả ý tưởng & nguyên lý chiến thuật giao dịch
│   ├── draft_ideas/     # Các ý tưởng sơ khai đang trong giai đoạn phác thảo
│   └── finalized/       # Chiến lược đã duyệt, sẵn sàng chuyển sang bước Backtest
├── notebooks/           # Jupyter Notebooks phục vụ EDA (Exploratory Data Analysis)
│   ├── data_exploration.ipynb
│   └── stat_arbitrage_test.ipynb
└── README.md            # Tài liệu hướng dẫn này


🎯 Quy trình Nghiên cứu (Research Workflow)

Định hướng nghiên cứu tuân theo mô hình 4 bước nghiêm ngặt:

[ Ý tưởng / Giả thuyết ] ──► [ Phân tích dữ liệu sơ bộ (EDA) ] ──► [ Đánh giá lý thuyết ] ──► [ Chuyển giao Backtest ]


Phát triển Giả thuyết (Hypothesis Generation):

Đặt ra câu hỏi hoặc quan sát hành vi thị trường (VD: "Liệu việc chênh lệch lãi suất có ảnh hưởng tới cặp GBPJPY trong phiên Âu?").

Tạo tài liệu mô tả ban đầu tại strategies/draft_ideas/.

Phân tích Dữ liệu Sơ bộ (Exploratory Data Analysis - EDA):

Sử dụng Jupyter Notebooks trong notebooks/ để thu thập dữ liệu mẫu, kiểm tra tính tương quan, kiểm định thống kê (Statistical Tests).

Tổng hợp & Đánh giá (Synthesis):

Đối chiếu với các nghiên cứu học thuật liên quan trong academic_papers/.

Xác định ưu/nhược điểm, rủi ro tiềm ẩn và điều kiện thị trường phù hợp.

Chuẩn hóa & Chuyển giao (Handover):

Hoàn thiện tài liệu chiến lược tại strategies/finalized/.

Chuyển thông số và quy tắc giao dịch sang bộ phận/thư mục Backtest để lập trình và thử nghiệm rộng rãi.

📝 Mẫu Tài liệu Chiến lược (Strategy Document Template)

Khi đề xuất một chiến lược mới vào thư mục strategies/, tài liệu cần đảm bảo các mục sau:

Tên chiến lược (Strategy Name):

Tác giả (Author) & Ngày khởi tạo:

Triết lý giao dịch (Rationale): Tại sao chiến lược này có thể tạo ra lợi nhuận (Edge)?

Điều kiện Thị trường (Market Conditions): Trending, Ranging, High/Low Volatility...

Khung thời gian (Timeframes) & Cặp tiền/Tài sản (Instruments):

Quy tắc Vào/Ra lệnh (Entry/Exit Rules):

Quản lý rủi ro (Risk Management): Mức cắt lỗ (SL), chốt lời (TP), Trailing stop...

📚 Tài liệu & Công cụ Hỗ trợ

Libraries thường dùng (Python): pandas, numpy, statsmodels, scikit-learn, matplotlib, seaborn

Nguồn dữ liệu tham khảo: Yahoo Finance, TradingView, Quandl, St. Louis Fed (FRED)

Lưu ý: Mọi tài liệu và phát hiện nghiên cứu trong thư mục này cần được kiểm định thực nghiệm (Backtest) kỹ lưỡng trước khi đưa vào tài khoản Live.
