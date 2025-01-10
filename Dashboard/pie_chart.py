import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt

# 创建示例数据
data = {
    '类别': ['A', 'B', 'C', 'D'],
    '值': [10, 20, 30, 40]
}
df = pd.DataFrame(data)

# 选择类别
selected_category = st.selectbox("选择类别:", df['类别'])

# 根据选择的类别过滤数据
# filtered_data = df[df['类别'] == selected_category]

# 绘制圆饼图
plt.figure(figsize=(8, 6))
plt.pie(df['值'], labels=df['类别'], autopct='%1.1f%%', startangle=90)
plt.title(f'{selected_category}')
plt.axis('equal')  # 确保圆饼图是圆的

# 显示图表
st.pyplot(plt)