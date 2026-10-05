-- Generated from ChapterFockNumberPreservingGap.lean — solution of BookProof.FockNumberPreservingGap.shiftCol_apply
import Mathlib
import Definitions.Def_ChapterFockNumberPreservingGap
import Theorems.Thm_BookProof_FockNumberPreservingGap_numberCol_eq
open BookProof.FockNumberPreservingGap



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FarisLavine BookProof.NavierStokesFlow

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (mu : ℝ) (k : ℕ) :
    shiftCol col mu k = col k - ((mu : ℝ) : ℂ) • numberCol k := by

  rw [shiftCol, numberCol_eq]
