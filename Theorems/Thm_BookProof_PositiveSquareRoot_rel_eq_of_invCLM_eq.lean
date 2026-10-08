-- Generated from ChapterPositiveSquareRootUnique.lean — theorem BookProof.PositiveSquareRoot.rel_eq_of_invCLM_eq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
open BookProof.PositiveSquareRoot



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]

theorem BookProof.PositiveSquareRoot.rel_eq_of_invCLM_eq (hT₁ : IsNonnegSelfAdjoint T₁) (hT₂ : IsNonnegSelfAdjoint T₂)
    (heq : invCLM hT₁ = invCLM hT₂) : T₁ = T₂ := by sorry
