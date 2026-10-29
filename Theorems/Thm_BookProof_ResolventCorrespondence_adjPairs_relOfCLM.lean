-- Generated from ChapterResolventCorrespondence.lean — theorem BookProof.ResolventCorrespondence.adjPairs_relOfCLM
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Definitions.Def_ChapterNonnegSquareRoot
import Mathlib
import Definitions.Def_ChapterResolventCorrespondence
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterVonNeumannCore
open BookProof.ClosureUniqueness



open BookProof.ClosureUniqueness
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {R : F →L[ℂ] F} {T : Submodule ℂ (F × F)}


theorem BookProof.ResolventCorrespondence.adjPairs_relOfCLM (hR : IsSelfAdjoint R) : adjPairs (relOfCLM R) = relOfCLM R := by sorry
