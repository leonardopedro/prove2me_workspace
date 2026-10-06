-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.coherentOccupation_mean
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Theorems.Thm_BookProof_ChapterCoherentOccupation_coherentOccupation_hasSum_mean
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) :
    ∑' n : ℕ, (n : ℝ) * coherentOccupation lam n = lam := (coherentOccupation_hasSum_mean lam).tsum_eq
