-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.conj_mul_ofReal
import Mathlib
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}




open scoped ENNReal

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (b : ℝ) (z : ℂ) :
    (b : ℂ) * z * (starRingEnd ℂ) z = ((b * Complex.normSq z : ℝ) : ℂ) := by
  rw [show (b : ℂ) * z * (starRingEnd ℂ) z = (b : ℂ) * ((starRingEnd ℂ) z * z) by ring,
    ← Complex.normSq_eq_conj_mul_self]
  push_cast
  ring
