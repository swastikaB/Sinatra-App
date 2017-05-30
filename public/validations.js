function validateStudentForm(){
    var firstName = document.getElementById('fname');
    if(!firstName.value)
    {
        document.getElementById('errorMessage').innerHTML= "Please enter First Name";
        return false;
    }
    var dob = document.getElementById('dob').value;
    if(dob){
        let dateText = /^[0-1][0-2]\/([0-2][0-9]|[3][0-1])\/\d{4}/;
        if(!dob.match(dateText)){
            document.getElementById('errorMessage').innerHTML= "Please enter Date of Birth in the right format";
            return false;
        }
    }
    return true;
}