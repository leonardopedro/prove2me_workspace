-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.invLin_mem
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
theorem solution (hT : IsNonnegSelfAdjoint T) (h : F) : (invLin hT h, h - invLin hT h) ∈ T := by

  have hmem := invPair_mem hT h
  have hsum := invPair_add hT h
  have heq : (invLin hT h, h - invLin hT h) = invPair hT h := by
    rw [invLin_apply, Prod.ext_iff]
    exact ⟨rfl, (eq_sub_of_add_eq' hsum).symm⟩
  rw [heq]; exact hmem
