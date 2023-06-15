
class Token {
   final String username, tokenID, verification;
   final DateTime creationDate, expirationDate;

   const Token( {
      required this.username,
     required this.creationDate,
     required this.expirationDate,
     required this.tokenID,
     required this.verification
   });

   Map<String , dynamic> toMap() {
     return {
       'username': username,
       'tokenID': tokenID,
       'verification': verification,
       'creationDate':creationDate,
       'expirationDate': expirationDate
     };
   }

}