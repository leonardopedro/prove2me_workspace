-- Generated from ChapterQgVielbeinModeInstance.lean — theorem BookProof.QgVielbeinModeInstance.ofFintype_B
import Mathlib
import Definitions.Def_ChapterQgVielbeinModeInstance
open BookProof.QgVielbeinModeInstance

variable {ι : Type*}
variable [Fintype ι] [DecidableEq ι]
variable (L : ℕ) [NeZero L]



open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

variable {ι : Type*}

theorem BookProof.QgVielbeinModeInstance.ofFintype_B (sig : ι → ℝ) (one_le_sig : ∀ a, 1 ≤ sig a) (A B : ι → ι → ℂ)
    (A_herm : ∀ a b, A b a = (starRingEnd ℂ) (A a b))
    (B_herm : ∀ a b, B b a = (starRingEnd ℂ) (B a b)) :
    (ofFintype sig one_le_sig A B A_herm B_herm).B = B := by sorry
