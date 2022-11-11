local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
    print("Missing impatient")
    return
end

impatient.enable_profile()
