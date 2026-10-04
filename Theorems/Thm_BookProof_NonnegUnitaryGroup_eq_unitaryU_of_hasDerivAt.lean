-- Generated from ChapterNonnegUnitaryGroup.lean — theorem BookProof.NonnegUnitaryGroup.eq_unitaryU_of_hasDerivAt
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterA4
open BookProof.NonnegUnitaryGroup

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}



open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace


theorem BookProof.NonnegUnitaryGroup.eq_unitaryU_of_hasDerivAt (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {u kk : ℝ → F}
    (hmem : ∀ s : ℝ, (u s, kk s) ∈ T)
    (hu : ∀ s : ℝ, HasDerivAt u ((-Complex.I) • kk s) s) (t : ℝ) :
    u t = unitaryU hT hsv t (u 0) := by sorry
