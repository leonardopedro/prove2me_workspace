-- Generated from ChapterNonnegUnitaryGroup.lean — theorem BookProof.NonnegUnitaryGroup.tendstoUniformlyOn_approxU
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterStoneEvolution
open BookProof.NonnegUnitaryGroup



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

theorem BookProof.NonnegUnitaryGroup.tendstoUniformlyOn_approxU (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (z : F) (R : ℝ) :
    TendstoUniformlyOn (fun (n : ℕ) (t : ℝ) => approxU hT n t z)
      (fun t : ℝ => unitaryU hT hsv t z) atTop {t : ℝ | |t| ≤ R} := by sorry
