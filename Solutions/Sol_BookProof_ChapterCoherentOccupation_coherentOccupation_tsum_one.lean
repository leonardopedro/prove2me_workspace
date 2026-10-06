-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.coherentOccupation_tsum_one
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Theorems.Thm_BookProof_ChapterCoherentOccupation_coherentOccupation_hasSum_one
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) : ∑' n : ℕ, coherentOccupation lam n = 1 := (coherentOccupation_hasSum_one lam).tsum_eq
