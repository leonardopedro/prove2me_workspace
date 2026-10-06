-- Generated from ChapterComputableScarcity.lean — solution of BookProof.ComputableScarcity.exists_code_of_computable
import Mathlib
import Definitions.Def_ChapterComputableScarcity
open BookProof.ComputableScarcity




open Nat.Partrec

open Classical

set_option maxHeartbeats 1000000 in
theorem solution {f : ℕ → ℕ} (hf : Computable f) :
    ∃ c : Code, evalTotal c = f := by

  have h1 : Nat.Partrec (fun n => Part.some (f n)) := Partrec.nat_iff.mp hf.partrec
  obtain ⟨c, hc⟩ := Nat.Partrec.Code.exists_code.mp h1
  refine ⟨c, ?_⟩
  funext n
  simp [evalTotal, hc]
