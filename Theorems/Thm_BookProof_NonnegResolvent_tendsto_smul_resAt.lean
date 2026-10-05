-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.tendsto_smul_resAt
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


theorem BookProof.NonnegResolvent.tendsto_smul_resAt (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (h : F) :
    Filter.Tendsto (fun n : ℕ => (((n : ℝ) + 1 : ℝ) : ℂ) • resAt hT n h) Filter.atTop
      (nhds h) := by sorry
