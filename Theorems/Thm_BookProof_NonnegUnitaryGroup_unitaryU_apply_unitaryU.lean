-- Generated from ChapterNonnegUnitaryGroup.lean — theorem BookProof.NonnegUnitaryGroup.unitaryU_apply_unitaryU
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
open BookProof.NonnegUnitaryGroup

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace


theorem BookProof.NonnegUnitaryGroup.unitaryU_apply_unitaryU (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (s t : ℝ) (x : F) :
    unitaryU hT hsv s (unitaryU hT hsv t x) = unitaryU hT hsv (s + t) x := by sorry
