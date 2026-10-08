-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.conj_mul_ofReal₂
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) (z : ℂ) :
    (b : ℂ) * z * (starRingEnd ℂ) ((a : ℂ) * z) = ((a * b * Complex.normSq z : ℝ) : ℂ) :=
  starRingEnd ℂ) ((a : ℂ) * z) = ((a * b * Complex.normSq z : ℝ) : ℂ) := by
    rw [map_mul, Complex.conj_ofReal,
      show (b : ℂ) * z * ((a : ℂ) * (starRingEnd ℂ) z)
        = (a : ℂ) * (b : ℂ) * ((starRingEnd ℂ)
