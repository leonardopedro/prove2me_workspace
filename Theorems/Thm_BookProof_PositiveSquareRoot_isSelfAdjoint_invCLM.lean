-- Generated from ChapterPositiveSquareRootUnique.lean — theorem BookProof.PositiveSquareRoot.isSelfAdjoint_invCLM
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
open BookProof.PositiveSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open scoped ComplexOrder


theorem BookProof.PositiveSquareRoot.isSelfAdjoint_invCLM (hT : IsNonnegSelfAdjoint T) : IsSelfAdjoint (invCLM hT) := by sorry
