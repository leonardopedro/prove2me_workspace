-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.sameOrbit_of_zero
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
import Theorems.Thm_BookProof_ChapterWignerLittleGroupOrbits_hermOfMom_eq_zero_iff
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution {p q : Fin 4 → ℝ} (hp : ∀ i, p i = 0) (hq : ∀ i, q i = 0) :
    SameOrbit p q := by

  refine ⟨1, by simp, ?_⟩
  rw [hermOfMom_eq_zero_iff.2 hp, hermOfMom_eq_zero_iff.2 hq, act, Matrix.mul_zero,
    Matrix.zero_mul]
