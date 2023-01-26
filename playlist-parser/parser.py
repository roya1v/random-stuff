from selenium import webdriver
from selenium.webdriver.common.by import By

import sys

driver = webdriver.Chrome()
driver.get(sys.argv[1])

# Find the coockie reject button and click it
reject = driver.find_element(By.XPATH, '//*[@id="yDmH0d"]/c-wiz/div/div/div/div[2]/div[1]/div[3]/div[1]/form[1]')
reject.click()

links = driver.find_elements(By.XPATH, '//*[@id="video-title"]')
for link in links:
    print(f'- [ ] [{link.get_attribute("title")}]({link.get_attribute("href")})')