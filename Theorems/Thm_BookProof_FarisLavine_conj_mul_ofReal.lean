-- Generated from ChapterFarisLavine.lean — theorem BookProof.FarisLavine.conj_mul_ofReal
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

bolDomain lam →ₗ[ℂ] L2Nat :=
  mulSymbolOp lam lam (fun _ => le_rfl)

theorem BookProof.FarisLavine.conj_mul_ofReal (b : ℝ) (z : ℂ) : := by sorry
