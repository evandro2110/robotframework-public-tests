*** Settings ***
Documentation    Arquivo de contendo as variáveis comumente usadas de carrinho de compras

Library          SeleniumLibrary


*** Variables ***
# --- PRODUCTS
${PRODUCT_NAME_SORT}        ${EMPTY}

# --- BOTOES
${BTN_CHECKOUT}             id=checkout
${BTN_CONTINUE_SHOPPING}    id=continue-shopping
${BTN_ADD_TO_CART}          css:button.btn_inventory

# --- ITEM
${INVENTORY_ITEM_NAME}      css:.inventory_item_name
${INVENTORY_BTN_NAME}       css:.btn_inventory

# --- WARN/ERRORS
# --- TITLES
# --- TEXT
# --- LINKS
# --- INPUTS
