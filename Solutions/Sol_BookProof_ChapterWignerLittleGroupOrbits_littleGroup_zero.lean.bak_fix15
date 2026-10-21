-- Generated from ChapterWignerLittleGroupOrbits.lean — solution of BookProof.ChapterWignerLittleGroupOrbits.littleGroup_zero
import Mathlib
import Definitions.Def_ChapterWignerLittleGroupOrbits
import Theorems.Thm_BookProof_ChapterWignerLittleGroupOrbits_hermOfMom_zero
open BookProof.ChapterWignerLittleGroupOrbits



open Matrix Complex
open scoped ComplexOrder


open BookProof.ChapterWignerLittleGroup

set_option maxHeartbeats 1000000 in
theorem solution :
    littleGroup (fun _ => 0) = {A : Matrix (Fin 2) (Fin 2) ℂ | A.det = 1} := by

  ext A
  simp only [littleGroup, Set.mem_setOf_eq, hermOfMom_zero, act, Matrix.mul_zero,
    Matrix.zero_mul, and_true]
