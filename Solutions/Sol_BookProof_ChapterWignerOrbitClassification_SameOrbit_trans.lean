-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.SameOrbit.trans
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
import Theorems.Thm_BookProof_ChapterWignerLittleGroup_act_mul
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution {p q r : Fin 4 → ℝ} (h₁ : SameOrbit p q) (h₂ : SameOrbit q r) :
    SameOrbit p r := by

  obtain ⟨A, hA, ha⟩ := h₁
  obtain ⟨B, hB, hb⟩ := h₂
  exact ⟨B * A, by rw [Matrix.det_mul, hA, hB]; ring, by rw [act_mul, ha, hb]⟩
