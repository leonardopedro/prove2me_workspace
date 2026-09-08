-- Generated from ChapterBaryonAsymmetry.lean — solution of BookProof.ChapterBaryonAsymmetry.matterRadiationRatio_eq
import Mathlib
import Definitions.Def_ChapterBaryonAsymmetry
open BookProof.ChapterBaryonAsymmetry













open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (ρm0 ρr0 a : ℝ) (ha : 0 < a) (hr : ρr0 ≠ 0) :
    matterRadiationRatio ρm0 ρr0 a = (ρm0 / ρr0) * a := by

  have hane : a ≠ 0 := ne_of_gt ha
  simp only [matterRadiationRatio, matterDensity, radDensity]
  field_simp
