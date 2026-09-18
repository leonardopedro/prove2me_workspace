-- Generated from ChapterMajoranaProp61.lean — solution of BookProof.ChapterMajoranaProp61.prop61_isUnit
import Mathlib
import Definitions.Def_ChapterMajoranaProp61
import Theorems.Thm_BookProof_ChapterMajoranaProp61_prop61_star_mul_self
import Theorems.Thm_BookProof_ChapterMajoranaProp61_prop61_mul_star_self
open BookProof.ChapterMajoranaProp61




variable {𝒜 : Type*} [Ring 𝒜] [StarRing 𝒜] [Algebra ℝ 𝒜] [StarModule ℝ 𝒜]

set_option maxHeartbeats 1000000 in
theorem solution : IsUnit (Uprime U H g E Ni) :=
  ⟨⟨Uprime U H g E Ni, star (Uprime U H g E Ni),
        prop61_mul_star_self U H g E N Ni m hU₁ hU₂ hg_sa hg2 hH_sa hanti hE_sa hE2 hEA
          hN_sa hN2 hNi₁ hNi₂,
        prop61_star_mul_self U H g E N Ni m hU₁ hU₂ hg_sa hg2 hH_sa hanti hE_sa hE2 hEA
          hN_sa hN2 hNi₁ hNi₂ hNE hNA⟩,
      rfl⟩
