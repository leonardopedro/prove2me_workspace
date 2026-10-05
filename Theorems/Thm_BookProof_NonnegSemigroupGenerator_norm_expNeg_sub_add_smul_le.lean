-- Generated from ChapterNonnegSemigroupGenerator.lean — theorem BookProof.NonnegSemigroupGenerator.norm_expNeg_sub_add_smul_le
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterNonnegResolvent
import Definitions.Def_ChapterNonnegUnitaryGroup
import Definitions.Def_ChapterNonnegSemigroup
import Mathlib
import Definitions.Def_ChapterNonnegSemigroupGenerator
open BookProof.NonnegSemigroupGenerator

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent BookProof.NonnegUnitaryGroup BookProof.NonnegSemigroup
open Filter Topology NormedSpace


theorem BookProof.NonnegSemigroupGenerator.norm_expNeg_sub_add_smul_le {A : F →L[ℂ] F} (hA : 0 ≤ A) {t : ℝ} (ht : 0 ≤ t)
    (h k : F) {M : ℝ} (hM : ∀ s ∈ Set.Icc (0 : ℝ) t, ‖expNeg A s k - k‖ ≤ M) :
    ‖expNeg A t h - h + t • k‖ ≤ t * (‖k - A h‖ + M) := by sorry
