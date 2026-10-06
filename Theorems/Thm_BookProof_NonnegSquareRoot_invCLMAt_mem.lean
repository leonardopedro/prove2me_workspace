-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.invCLMAt_mem
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterPositiveSquareRootUnique
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
open BookProof.NonnegSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}
variable {a : ℝ}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder


theorem BookProof.NonnegSquareRoot.invCLMAt_mem (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    (invCLMAt hT ha h, h - (a : ℂ) • invCLMAt hT ha h) ∈ T := by sorry
