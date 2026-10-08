-- Generated from ChapterNonnegResolvent.lean — theorem BookProof.NonnegResolvent.smul_nonneg_of_nonneg
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
open BookProof.NonnegResolvent



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}


theorem BookProof.NonnegResolvent.smul_nonneg_of_nonneg {c : ℝ} (hc : 0 ≤ c) {A : F →L[ℂ] F} (hA : 0 ≤ A) :
    0 ≤ (c : ℂ) • A := by sorry
