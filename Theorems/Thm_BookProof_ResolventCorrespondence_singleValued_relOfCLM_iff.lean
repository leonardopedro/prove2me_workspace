-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.singleValued_relOfCLM_iff
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Definitions.Def_ChapterA4
open BookProof.ResolventCorrespondence

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}



open BookProof.NonnegSquareRoot
open scoped ComplexOrder


theorem BookProof.ResolventCorrespondence.singleValued_relOfCLM_iff :
    (∀ w : F, ((0 : F), w) ∈ relOfCLM R → w = 0) ↔ Function.Injective R := by sorry
