-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.condProb_of_continuity_infinite
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Theorems.Thm_BookProof_ChapterContinuityUnitaryInfinite_bornPMF_apply
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
nPMF_apply (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) (z : ℤ)  := 
