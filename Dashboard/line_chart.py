import streamlit as st
import pandas as pd
import plotly.express as px
from datetime import datetime, timedelta

# 生成示例數據
def create_data():
    date_range = pd.date_range(start='2023-01-01', end='2023-09-30', freq='D')
    data = {
        'date': date_range,
        'value': [i + (i % 10) for i in range(len(date_range))]
    }
    return pd.DataFrame(data)

# 加載數據
df = create_data()

# 標題
st.title('可調整時間軸的折線圖')

# 選擇日期範圍
start_date, end_date = st.date_input(
    '選擇日期範圍',
    value=(datetime(2023, 1, 1), datetime(2023, 9, 30))
)

# 根據選擇的日期範圍過濾數據
filtered_df = df[(df['date'] >= pd.to_datetime(start_date)) & (df['date'] <= pd.to_datetime(end_date))]

# 繪製折線圖
fig = px.line(filtered_df, x='date', y='value', title='日期範圍內的折線圖')
st.plotly_chart(fig)
