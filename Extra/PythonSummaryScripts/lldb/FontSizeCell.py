import lldb

def FontSizeCell_summary(valueObject, dictionary):
    sizeFormat = valueObject.GetChildMemberWithName('sizeFormatString').GetSummary()
    size = valueObject.GetChildMemberWithName('savedSize').GetSummary()
    return 'Size Format: ' + sizeFormat + ', size is ' + size

def __lldb_init_module(debugger, dict):
    debugger.HandleCommand('type summary add FontSizeCell -F FontSizeCell.FontSizeCell_summary')
