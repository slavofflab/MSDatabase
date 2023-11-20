For Trypsin/P
    for pep in peplist2:
        Tag = True
        j += 1
        if j%10 == 0:
            print(f"{j} peptides done")
        if pep[-1] == "K" or pep[-1] == "R":
            p = re.compile(r"(_M|[_KR])"+ pep)
        else:
            p = re.compile(r"(_M|[_KR])"+ pep + "@")
        for pro in prolist:
            if re.search(p,pro):
                Tag = False
                break
        if Tag:
            peplist3.append(pep)
For Asp-N
    for pep in peplist2:
        Tag = True
        j += 1
        if j%10 == 0:
            print(f"{j} peptides done")
        if pep[0] == "B" or pep[0] == "D":
            p = re.compile(pep + r"[BD@]")
        else:
            p = re.compile(r"(_M|_)"+ pep + "[BD@]")
        for pro in prolist:
            if re.search(p,pro):
                Tag = False
                break
        if Tag:
            peplist3.append(pep)
