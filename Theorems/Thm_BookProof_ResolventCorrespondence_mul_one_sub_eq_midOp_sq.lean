-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.mul_one_sub_eq_midOp_sq
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Definitions.Def_ChapterA4
open BookProof.ResolventCorrespondence

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}



open BookProof.NonnegSquareRoot
open scoped ComplexOrder


theorem BookProof.ResolventCorrespondence.mul_one_sub_eq_midOp_sq (h0 : 0 ≤ R) (h1 : R ≤ 1) :
    R * (1 - R) = midOp R * midOp R := by sorry
