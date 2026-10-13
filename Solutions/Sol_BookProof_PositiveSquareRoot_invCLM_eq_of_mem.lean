-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.invCLM_eq_of_mem
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_invLin_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterFriedrichsSquareFactorization
import Definitions.Def_ChapterVonNeumannCore
import Definitions.Def_ChapterA4
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) {x h : F} (hx : (x, h - x) ∈ T) :
    invCLM hT h = x := by

  have hp := invPair_unique hT hx (show x + (h - x) = h by abel)
  rw [invCLM_apply, invLin_apply, hp]
