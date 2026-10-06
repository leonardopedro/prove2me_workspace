-- Generated from ChapterA4c.lean — solution of BookProof.ChapterA3.massive_little_group
import Mathlib
import Definitions.Def_ChapterA4c
import Theorems.Thm_BookProof_ChapterA3_fixesTimeAxis_iff_unitary
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution :
    {T : Matrix (Fin 2) (Fin 2) ℂ | T.det = 1 ∧ FixesTimeAxis (Upsilon T)} = SUtwo := by

  ext T
  simp only [Set.mem_setOf_eq, SUtwo]
  constructor
  · rintro ⟨hd, hf⟩; exact ⟨hd, (fixesTimeAxis_iff_unitary T).mp hf⟩
  · rintro ⟨hd, hu⟩; exact ⟨hd, (fixesTimeAxis_iff_unitary T).mpr hu⟩
