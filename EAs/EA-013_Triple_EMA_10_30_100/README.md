# EA-013: Triple EMA (10/30/100) Trend Alignment Strategy

## Overview
- **Symbol**: XAUUSD
- **Timeframe**: M1
- **Strategy Type**: Triple EMA Trend Following & Swing Breakout Execution
- **Max Open Orders**: 1 position at a time

---

## Strategy Logic

### Trend Alignment (Triple EMA)
Hệ thống xác định xu hướng chính dựa trên sự xếp lớp của 3 đường Exponential Moving Average:
- **Fast EMA**: 10
- **Medium EMA**: 30
- **Slow EMA**: 100

- **Uptrend (Bullish)**: EMA 10 > EMA 30 > EMA 100
- **Downtrend (Bearish)**: EMA 10 < EMA 30 < EMA 100

### Entry Conditions
- **Buy Order**: 
  1. Điều kiện xếp lớp EMA xác nhận Xu hướng Tăng (`EMA 10 > EMA 30 > EMA 100`).
  2. Giá đóng cửa của nến hiện tại vượt/phá vỡ đỉnh Swing High gần nhất.
- **Sell Order**: 
  1. Điều kiện xếp lớp EMA xác nhận Xu hướng Giảm (`EMA 10 < EMA 30 < EMA 100`).
  2. Giá đóng cửa của nến hiện tại phá vỡ đáy Swing Low gần nhất.

---

## Risk & Trade Management

| Parameter | Value | Description |
| :--- | :--- | :--- |
| **Stop Loss (SL)** | 300 points | Mức cắt lỗ cố định từ điểm vào lệnh (30 pips) |
| **Take Profit (TP)** | 600 points | Mức chốt lời cố định từ điểm vào lệnh (60 pips) |
| **Break Even (BE)** | 150 points | Dời SL về hòa vốn khi lợi nhuận đạt từ 150 points (15 pips) |
| **Trailing Stop** | 200 points | Kích hoạt Trailing Stop duy trì khoảng cách khi đạt lợi nhuận tối thiểu 200 points |
| **Max Spread Filter** | 30 points | Bỏ qua tín hiệu vào lệnh nếu Spread vượt quá 30 points (3 pips) |
| **Max Positions** | 1 | Chỉ cho phép mở tối đa 1 lệnh tại một thời điểm |
