
ImportXML([=[
<triggers>
  <trigger
   enabled="y"
   group="market"
   match="^\[Tradesman Market\] ([A-Z][a-z]+? [A-Z][a-z]+?) has commenced a sale\. [SsHhe]{2,3} is selling (\w+?) tradesman item (certificates?) for ([0-9,]+[.0-9]{3}) credits\s?(a piece)?\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("misc/tradesmanSale")
   print ("[Tradesman Market] New Sale by %1: %2 %3 for %4 credits.")
   channel ("market", "[Tradesman Market] New Sale by %1: %2 %3 for %4 credits.", {"market"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="market"
   match="^\[Tradesman Market\] ([A-Z][a-z]+ [A-Z][a-z]+?) has (lowered|raised) the price of ([ehisr]{3}) sale from ([0-9,]+[.0-9]{3}) credits to ([0-9,]+[.0-9]{3}) credits per certificate\.$"
   regexp="y"
   omit_from_output="y"
   send_to="14"
   sequence="100"
  >
  <send>
   mplay ("misc/tradesmanPrice")
   local diff, v1, v2 = 0, string.gsub ("%4",",",""), string.gsub ("%5",",","")
   if "%2" == "lowered" then
    diff = assert (tonumber (v1 - v2)) -- close assertion 
   else
    diff = assert (tonumber (v2 - v1)) -- close assertion
   end -- if

   print ("[Tradesman Market] %1 %2 %3 sale by "..diff.." credits. Price: %5")
   channel ("market", "[Tradesman Market] %1 %2 %3 sale by "..diff.." credits. Price: %5", {"market"})
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="market"
   match="^\[Tradesman Market\] [A-Z][a-z]+ [A-Z][a-z]+'?s? (?:has canceled \w+ sale|sale has completed)\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   channel("market", "%0", {"market"})
   mplay ("misc/tradesmanComplete")
  </send>
  </trigger>

  <trigger
   enabled="y"
   group="market"
   match="^\[Tradesman Market\] [A-Z][a-z]+ [A-Z][a-z]+ has bought (\w+?) tradesman certificate from [A-Z][a-z]+ [A-Z][a-z]+\.$"
   regexp="y"
   send_to="12"
   sequence="100"
  >
  <send>
   channel("market", "%0", {"market"})
   mplay ("misc/tradesmanBid")
  </send>
  </trigger>

</triggers>
]=])