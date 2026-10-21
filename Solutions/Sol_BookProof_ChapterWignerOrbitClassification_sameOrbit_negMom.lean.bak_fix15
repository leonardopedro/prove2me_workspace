-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.sameOrbit_negMom
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
import Theorems.Thm_BookProof_ChapterWignerOrbitClassification_hermOfMom_negMom
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution {p q : Fin 4 → ℝ} (h : SameOrbit p q) :
    SameOrbit (negMom p) (negMom q) := by

  obtain ⟨A, hA, hact⟩ := h
  refine ⟨A, hA, ?_⟩
  simp only [act] at hact ⊢
  rw [hermOfMom_negMom, hermOfMom_negMom, Matrix.mul_neg, Matrix.neg_mul, hact]
