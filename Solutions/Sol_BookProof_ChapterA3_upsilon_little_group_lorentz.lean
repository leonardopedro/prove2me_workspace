-- Generated from ChapterA4c.lean — solution of BookProof.ChapterA3.upsilon_little_group_lorentz
import Mathlib
import Definitions.Def_ChapterA4c
import Theorems.Thm_BookProof_ChapterA3_fixesTimeAxis_iff_unitary
import Theorems.Thm_BookProof_ChapterA3_upsilon_mem_lorentz
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (T : Matrix (Fin 2) (Fin 2) ℂ) (hT : T ∈ SUtwo) :
    Upsilon T ∈ LorentzO ∧ FixesTimeAxis (Upsilon T) := by

  obtain ⟨hd, hu⟩ := hT
  exact ⟨upsilon_mem_lorentz T hd, (fixesTimeAxis_iff_unitary T).mpr hu⟩
