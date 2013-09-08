import lldb

def KGFlickrMedia_summary(valueObject, dictionary):
    size = valueObject.GetChildMemberWithName('_mediaSize').GetSummary()
    return 'Size: ' + size

def __lldb_init_module(debugger, dict):
    debugger.HandleCommand('type summary add KGFlickrMedia -F KGFlickrMedia.KGFlickrMedia_summary')
