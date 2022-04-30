import Debug "mo:base/Debug";   //importing Library from MOTOKO base library
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank{   //new canister
  stable var currentValue:Float = 300;   //stable keyword make this variable a persistence variable
  currentValue := 300;   //reassignemt operator

  //let id = 5466124564654; 

 stable var startTime = Time.now();
 startTime := Time.now();
  Debug.print(debug_show(startTime));

  // Debug.print("Hello");
  Debug.print(debug_show(currentValue));

  public func topUp(amount: Float){   //Nat = Natural Number datatype       //Update Call
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount:Float){                    //Update Call: Allow the user to change the state of the canister and have changes persist.
    let tempValue:Float = currentValue-amount;
    if(tempValue >=0){
      currentValue-=amount;
      Debug.print(debug_show(currentValue));
    }else{
      Debug.print("Cannot OverWithdraw");
    }
  };

  public query func checkBalance(): async Float{  //Query Call:Calls a function that operates on the canister's state without changing it
  //async keyword needs to be used before the return type because So basically whenever you have a function that has an output, the output has to come out asynchronously.
    return currentValue;
  };

  // topUp();   
  //dfx canister call dbank topUp       //command to call the function from terminal

  public func compound(){
    let currentTime = Time.now();
    let timeElapsedNS = currentTime-startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));   //exponent = **
    startTime:=currentTime;
  };

}