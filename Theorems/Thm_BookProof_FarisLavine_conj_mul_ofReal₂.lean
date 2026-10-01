-- Generated from ChapterFarisLavine.lean — theorem BookProof.FarisLavine.conj_mul_ofReal₂
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Mathlib
import Definitions.Def_ChapterFarisLavine
open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}






open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

 * z) by ring,
    ← Complex.normSq_eq_conj_mul_self]
  push_cast
  ring

theorem BookProof.FarisLavine.conj_mul_ofReal₂₂ (a b : ℝ) (z : ℂ) :
    (b : ℂ) * z * ( := by sorry
