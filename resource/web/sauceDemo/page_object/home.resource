*** Settings ***
Documentation    Arquivo de contendo as variáveis comumente usadas na tela de login

Library          SeleniumLibrary


*** Variables ***
# --- BUTTON
${BTN_CART}              xpath=//a[@class="shopping_cart_link"]
${BTN_MENU}              id=react-burger-menu-btn
${RESTORE_APP_STATE}     id=reset_sidebar_link

# --- TEXT
${TXT_FINAL_PAGE}        xpath=//div[@class="footer_copy"]

# -- LIST
${LIST_FILTER}           css:.product_sort_container

# --- WARN/ERRORS
# --- TITLES
# --- LINKS
# --- INPUTS
