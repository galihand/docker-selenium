from selenium import webdriver
import time

options = webdriver.chrome.options.Options()
options.add_argument("--no-sandbox")


driver = webdriver.Chrome(options=options)

driver.maximize_window()
time.sleep(5)
driver.get("https://xendit.co/")

# time.sleep(5)
# # driver.find_element_by_link_text("Get started free").click()

time.sleep(5)
driver.close()
driver.quit()
print("Finish")
