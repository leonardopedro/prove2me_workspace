-- Generated from ChapterWignerOrbitClassification.lean — solution of BookProof.ChapterWignerOrbitClassification.SameOrbit.symm
import Mathlib
import Definitions.Def_ChapterWignerOrbitClassification
import Theorems.Thm_BookProof_ChapterWignerLittleGroupOrbits_act_inv_of_act
import Theorems.Thm_BookProof_ChapterWignerLittleGroupOrbits_det_inv_eq_one
open BookProof.ChapterWignerOrbitClassification



open Matrix Complex


open BookProof.ChapterWignerLittleGroup BookProof.ChapterWignerLittleGroupOrbits

set_option maxHeartbeats 1000000 in
theorem solution {p q : Fin 4 → ℝ} (h : SameOrbit p q) : SameOrbit q p := by

  obtain ⟨A, hA, hact⟩ := h
  exact ⟨A⁻¹, det_inv_eq_one hA, act_inv_of_act hA hact⟩
