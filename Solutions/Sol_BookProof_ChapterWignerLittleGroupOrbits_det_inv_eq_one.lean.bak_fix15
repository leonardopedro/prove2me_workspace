-- Generated from ChapterWignerLittleGroupOrbits.lean — solution of BookProof.ChapterWignerLittleGroupOrbits.det_inv_eq_one
import Mathlib
import Definitions.Def_ChapterWignerLittleGroupOrbits
open BookProof.ChapterWignerLittleGroupOrbits



open Matrix Complex
open scoped ComplexOrder


open BookProof.ChapterWignerLittleGroup

set_option maxHeartbeats 1000000 in
theorem solution {A : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) : (A⁻¹).det = 1 := by

  rw [Matrix.det_nonsing_inv, hA]
  simp
