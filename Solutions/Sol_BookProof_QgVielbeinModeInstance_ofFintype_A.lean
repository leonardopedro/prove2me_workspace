-- Generated from ChapterQgVielbeinModeInstance.lean — solution of BookProof.QgVielbeinModeInstance.ofFintype_A
import Mathlib
import Definitions.Def_ChapterQgVielbeinModeInstance




open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable [Fintype ι] [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution (sig : ι → ℝ) (one_le_sig : ∀ a, 1 ≤ sig a) (A B : ι → ι → ℂ)
    (A_herm : ∀ a b, A b a = (starRingEnd ℂ) (A a b))
    (B_herm : ∀ a b, B b a = (starRingEnd ℂ) (B a b)) :
    (ofFintype sig one_le_sig A B A_herm B_herm).A = A := rfl
