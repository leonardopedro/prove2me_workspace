-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.relOfCLM_le_adjPairs
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterA4
open BookProof.ClosureUniqueness
open BookProof.ResolventCorrespondence

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}



open BookProof.NonnegSquareRoot
open scoped ComplexOrder


theorem BookProof.ResolventCorrespondence.relOfCLM_le_adjPairs (hR : IsSelfAdjoint R) : relOfCLM R ≤ adjPairs (relOfCLM R) := by sorry
