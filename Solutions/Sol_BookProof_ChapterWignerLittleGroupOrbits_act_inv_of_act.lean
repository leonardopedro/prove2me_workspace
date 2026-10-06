-- Generated from ChapterWignerLittleGroupOrbits.lean — solution of BookProof.ChapterWignerLittleGroupOrbits.act_inv_of_act
import Mathlib
import Definitions.Def_ChapterWignerLittleGroupOrbits
import Theorems.Thm_BookProof_ChapterWignerLittleGroup_act_mul
import Theorems.Thm_BookProof_ChapterWignerLittleGroup_act_one
open BookProof.ChapterWignerLittleGroupOrbits



open Matrix Complex
open scoped ComplexOrder


open BookProof.ChapterWignerLittleGroup

set_option maxHeartbeats 1000000 in
theorem solution {A X Y : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) (h : act A X = Y) :
    act A⁻¹ Y = X := by

  have hunit : IsUnit A.det := by rw [hA]; exact isUnit_one
  rw [← h, ← act_mul, Matrix.nonsing_inv_mul A hunit, act_one]
