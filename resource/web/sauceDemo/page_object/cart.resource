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
${BTN_CART_BADGE}           css:.shopping_cart_badge
${BTN_CONTINUE}             id=continue
${BTN_CANCEL}               id=cancel

# --- ITEM
${INVENTORY_ITEM_NAME}      css:.inventory_item_name
${INVENTORY_BTN_NAME}       css:.btn_inventory

# --- WARN/ERRORS
${ICON}                     css:svg.error_icon

# --- TITLES
# --- TEXT
${TXT_FIST_NAME_REQUIRED}      Error: First Name is required
${TXT_LAST_NAME_REQUIRED}      Error: Last Name is required
${TXT_ZIP_CODE_REQUIRED}       Error: Postal Code is required
# --- LINKS
# --- INPUTS
${INPUT_FIRST_NAME}            id=first-name
${INPUT_LAST_NAME}             id=last-name
${INPUT_POSTAL_CODE}           id=postal-code
