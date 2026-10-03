-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.bornRecover_mono
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
theorem solution (v : LinfZ) (t : ℝ) (psi : L2Z) :
    ‖evolvedState v t psi‖ = ‖psi‖ := set.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positiv
