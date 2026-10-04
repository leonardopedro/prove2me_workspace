-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.mem_relOfCLM
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Definitions.Def_ChapterA4
open BookProof.ResolventCorrespondence

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}



open BookProof.NonnegSquareRoot
open scoped ComplexOrder


theorem BookProof.ResolventCorrespondence.mem_relOfCLM (R : F →L[ℂ] F) (y : F) : (R y, y - R y) ∈ relOfCLM R := by sorry
