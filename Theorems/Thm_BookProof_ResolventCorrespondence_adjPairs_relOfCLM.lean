-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.adjPairs_relOfCLM
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Definitions.Def_ChapterClosureUniqueness
open BookProof.ClosureUniqueness
open BookProof.ResolventCorrespondence

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}



open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot
open scoped ComplexOrder


theorem BookProof.ResolventCorrespondence.adjPairs_relOfCLM (hR : IsSelfAdjoint R) : adjPairs (relOfCLM R) = relOfCLM R := by sorry
