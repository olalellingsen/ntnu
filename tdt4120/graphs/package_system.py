
def resolve_and_install(package):
    # allerede installert
    if package.is_installed:
        return
    # installerer avhengighetene
    for p in package.dependencies:
        resolve_and_install(p)
    
    #installer pakken
    install(package)
    