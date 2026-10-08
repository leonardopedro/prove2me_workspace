-- Generated from ChapterNonnegSemigroupGenerator.lean — theorem BookProof.NonnegSemigroupGenerator.norm_expNeg_le_exp
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterNonnegSemigroup
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
open BookProof.NonnegSemigroupGenerator



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {T : Submodule ℂ (F × F)}

theorem BookProof.NonnegSemigroupGenerator.norm_expNeg_le_exp (A : F →L[ℂ] F) {mu : ℝ}
    (hmu : ∀ x : F, mu * ‖x‖ ^ 2 ≤ (inner ℂ (A x) x : ℂ).re) {t : ℝ} (ht : 0 ≤ t) (x : F) :
    ‖expNeg A t x‖ ≤ Real.exp (-(mu * t)) * ‖x‖ := by sorry
