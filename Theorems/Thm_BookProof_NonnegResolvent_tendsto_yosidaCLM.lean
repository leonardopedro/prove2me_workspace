-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.tendsto_yosidaCLM
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
open BookProof.NonnegResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder


theorem BookProof.NonnegResolvent.tendsto_yosidaCLM (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) {ε : ℝ} (hε : 0 < ε) :
    ∃ A : ℝ, 0 < A ∧ ∀ (c : ℝ) (hc : 0 < c), A ≤ c → ‖yosidaCLM hT hc h - k‖ < ε := by sorry
