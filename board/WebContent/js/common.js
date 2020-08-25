function checkValidation(param){
    var flag = false;
    for(let key in param) {
        if (param[key] == '') flag = true;
    }
    return flag;
}