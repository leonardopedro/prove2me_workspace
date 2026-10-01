-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.conj_mul_ofReal
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

set_option maxHeartbeats 1000000 in
bolDomain lam →ₗ[ℂ] L2Nat :=
  mulSymbolOp lam lam (fun _ => le_rfl)

theorem solution (b : ℝ) (z : ℂ) : :=
   (b : ℂ) * z * (starRingEnd ℂ) z = ((b * Complex.normSq z : ℝ) : ℂ) := by
    rw [show (b : ℂ) * z * (starRingEnd ℂ) z = (b : ℂ) * ((starRingEnd ℂ)
