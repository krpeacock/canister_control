import Cycles "mo:base/ExperimentalCycles";
import Principal "mo:base/Principal";
shared ({caller = creator}) actor class Child() = self {
  public func getBalance() : async Nat {
    Cycles.balance();
  };
  
  // Not currently working
  public func refund() : async () {
    type Parent = actor {
      accept_cycles: () -> async ();
    };
    let parent: Parent = actor(Principal.toText(creator));
    Cycles.add(15_000_000);
    await parent.accept_cycles();
  };


};
