import Child "Child";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Cycles "mo:base/ExperimentalCycles";

actor {
  stable var children: [Principal] = [];
  // create fee + installation + 1T cycles
  let CREATE_FEE = 7_692_307_692 + 6_153_891_538 + 1_000_000_000_000;

  public func create_child () : async Principal {
    Cycles.add(CREATE_FEE);
    let child = await Child.Child();
    let principal = Principal.fromActor(child);
    let buf = Buffer.fromArray<Principal>(children);
    buf.add(principal);
    children := Buffer.toArray(buf);
    
    principal;
  };

  // Not currently working
  public func accept_cycles () : async () {
    let available = Cycles.available();
    ignore Cycles.accept(available);
  };

  public func get_children () : async [Principal] {
    children;
  };
};
