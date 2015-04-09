def isPageLoaded browser
  state = browser.execute_script("return document.readyState")
  if state == "complete"
    true
  else
  	false
  end
end