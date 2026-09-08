-- Generated from ChapterMajoranaProp61.lean — solution of BookProof.ChapterMajoranaProp61.gsq_Hsq_comm
import Mathlib
import Definitions.Def_ChapterMajoranaProp61
open BookProof.ChapterMajoranaProp61














variable {𝒜 : Type*} [Ring 𝒜] [StarRing 𝒜] [Algebra ℝ 𝒜] [StarModule ℝ 𝒜]

set_option maxHeartbeats 1000000 in
omit [StarRing 𝒜] [StarModule ℝ 𝒜] in
theorem solution (H g : 𝒜) (m : ℝ) (hanti : H * g + g * H = (2 * m) • (1 : 𝒜)) :
    g * (H * H) = (H * H) * g := by

  simp_all [ mul_assoc, ← eq_sub_iff_add_eq' ]
  simp [ ← mul_assoc, hanti ]
  simp [ mul_sub, sub_mul, mul_assoc, hanti ]
