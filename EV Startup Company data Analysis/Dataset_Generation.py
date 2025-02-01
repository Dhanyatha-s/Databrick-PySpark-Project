# creatting dataset from faker module
import pandas as pd
import random
from faker import Faker

fake = Faker()

data = []
for _ in range(200):
    record = {
        'Vehicle_ID': fake.uuid4(),
        'Vehicle_Type': random.choice(['Two-wheeler', 'Four-wheeler']),
        'Manufacturing_Cost': round(random.uniform(5000, 20000), 2),
        'Advertising_Cost': round(random.uniform(1000, 10000), 2),
        'Funding_Source': random.choice(['Angel Investor', 'Venture Capital', 'Crowdfunding']),
        'Budget_Allocation': round(random.uniform(50000, 200000), 2),
        'Employee_ID': fake.uuid4(),
        'Employee_Role': random.choice(['Engineer', 'Designer', 'Marketer', 'Technician']),
        'Employee_Salary': round(random.uniform(30000, 100000), 2),
        'Issue_Type': random.choice(['Technical', 'Financial', 'Operational']),
        'Issue_Description': fake.sentence(),
        'Market_Demand': round(random.uniform(500, 5000)),
        'Customer_Feedback_Rating': round(random.uniform(1, 5), 1),
        'Customer_Feedback_Comments': fake.sentence(),
        'Production_Date': fake.date_this_decade(),
        'Sales_Forecast': round(random.uniform(100, 1000))
    }
    data.append(record)

df = pd.DataFrame(data)
df.to_parquet("EV_Company_data.parquet")
df.to_csv("EV_Company_data.csv")

print('Data is Created')

