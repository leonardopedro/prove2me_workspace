-- Generated from ChapterPauliCommutant.lean — solution of BookProof.ChapterA3.mgamma_commutant_iff
import Mathlib
import Definitions.Def_ChapterPauliCommutant
import Theorems.Thm_BookProof_ChapterA3_mgamma_commutant_scalar
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 4) (Fin 4) ℂ) :
    (∀ μ, M * mgamma μ = mgamma μ * M) ↔ ∃ c : ℂ, M = c • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by

  constructor
  · intro h; exact ⟨M 0 0, mgamma_commutant_scalar M h⟩
  · rintro ⟨c, rfl⟩ μ
    simp []
