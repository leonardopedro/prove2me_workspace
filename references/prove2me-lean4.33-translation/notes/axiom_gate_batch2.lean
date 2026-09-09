/-
Phase 0 soundness gate: for every theorem/lemma in the imported chapters,
compute the transitive axiom closure (like `#print axioms`) and flag anything
outside {propext, Classical.choice, Quot.sound}.
-/
import Mathlib
import BookProof.ChapterBRSTNilpotent
import BookProof.ChapterNavierStokes
import BookProof.ChapterGaugeFixing
import BookProof.ChapterMassGap
import BookProof.ChapterGhostField
import BookProof.ChapterYangMillsFieldStrength
import BookProof.ChapterSirkFinitePrecision
import BookProof.ChapterBaryonAsymmetry
import BookProof.ChapterMajoranaClifford
import BookProof.ChapterMajoranaProp61
import BookProof.ChapterMajoranaProp76
import BookProof.ChapterParityMajoranaQuant
import BookProof.ChapterYangMillsBianchi
import BookProof.ChapterYangMillsSU3
import BookProof.ChapterSirkGroupTransfer
-- For a future batch from PnpProof/UsedRoute/UnusedRoute, add those imports
-- here (e.g. `import UsedRoute.Basic`) and the gate covers them automatically.

open Lean

-- Gate every imported module in the project's math folders, whatever the batch
-- adds to the imports above.  `Book.` is deliberately NOT gated/imported here
-- (prose chapters — user rule: never publish from Book/).  Folders gated:
-- BookProof, PnpProof, UsedRoute, UnusedRoute, RandomMap.
def gateModule (m : Name) : Bool :=
  let s := m.toString
  s.startsWith "BookProof." || s.startsWith "PnpProof." || s.startsWith "UsedRoute."
    || s.startsWith "UnusedRoute." || s.startsWith "RandomMap."

run_meta do
  let env ← getEnv
  let modNames := env.header.moduleNames
  let getMod : Name → Option Name := fun n =>
    match env.getModuleIdxFor? n with
    | some idx => modNames[idx.toNat]?
    | none => none
  -- Iterative DFS per theorem with a seed-level memo threaded through a pure
  -- fold (a `let rec` inside `Id.run` trips Lean v4.28's evaluator sorry-guard,
  -- so recursion is avoided).  Each gated theorem's axioms are cached under its
  -- own name, so later theorems that import earlier ones reuse the result
  -- instead of re-walking the same constant chains.
  let t0 ← IO.monoMsNow
  let axiomsOf (seed : Name) (memo : Std.HashMap Name (List Name)) : List Name := Id.run do
    let mut acc : Std.HashSet Name := {}
    let mut done : Std.HashSet Name := {}
    let mut work := [seed]
    while !work.isEmpty do
      let u := work.head!
      work := work.tail!
      if done.contains u then continue
      done := done.insert u
      match memo.get? u with
      | some axu => acc := acc.union (Std.HashSet.ofList axu)
      | none =>
        match env.find? u with
        | some (.axiomInfo _) => acc := acc.insert u
        | some (.thmInfo t) =>
            work := t.type.getUsedConstants.toList ++ t.value.getUsedConstants.toList ++ work
        | some (.defnInfo d) =>
            work := d.type.getUsedConstants.toList ++ d.value.getUsedConstants.toList ++ work
        | some (.opaqueInfo o) =>
            work := o.type.getUsedConstants.toList ++ o.value.getUsedConstants.toList ++ work
        | _ => pure ()
    acc.toList.mergeSort (fun a b => a.toString < b.toString)
  let gated :=
    (env.constants.toList.filter fun (n, _) =>
        match getMod n with | some m => gateModule m | none => false).filter fun (_, ci) =>
      match ci with | .thmInfo _ => true | _ => false
  let acc0 : Std.HashMap Name (List Name) × List (Name × List Name) := ({}, [])
  let (_, pairs) := gated.foldl
    (fun acc nci =>
      let memo := acc.1
      let out := acc.2
      let n := nci.1
      let ax := axiomsOf n memo
      (memo.insert n ax, out ++ [(n, ax)]))
    acc0
  for (n, ax) in pairs do
    let userName := (privateToUserName? n).getD n
    let bad := ax.filter (· ≠ `propext) |>.filter (· ≠ `Classical.choice) |>.filter (· ≠ `Quot.sound)
    if bad.isEmpty then
      logInfo (s!"OK  {userName}")
    else
      let sep := ", "
      let bads := bad.map (·.toString)
      logInfo (s!"BAD {userName} :: {String.intercalate sep bads}")
  let t1 ← IO.monoMsNow
  logInfo (s!"GATE: checked {pairs.length} theorems in {(t1 - t0) / 1000} s")