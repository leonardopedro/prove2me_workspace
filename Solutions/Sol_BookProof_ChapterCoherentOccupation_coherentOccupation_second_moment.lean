-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.coherentOccupation_second_moment
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Theorems.Thm_BookProof_ChapterCoherentOccupation_coherentOccupation_hasSum_second_moment
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) :
    ∑' n : ℕ, (n : ℝ) ^ 2 * coherentOccupation lam n = lam ^ 2 + lam := (coherentOccupation_hasSum_second_moment lam).tsum_eq
