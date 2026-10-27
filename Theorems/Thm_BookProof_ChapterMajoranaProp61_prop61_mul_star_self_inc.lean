-- Generated from ChapterMajoranaProp61.lean — theorem BookProof.ChapterMajoranaProp61.prop61_mul_star_self_inc
import Mathlib
import Definitions.Def_ChapterMajoranaProp61
import Definitions.Def_ChapterMajoranaFourier
open BookProof.ChapterMajoranaFourier
open BookProof.ChapterMajoranaProp61



variable {𝒜 : Type*} [Ring 𝒜] [StarRing 𝒜] [Algebra ℝ 𝒜] [StarModule ℝ 𝒜]

variable (U H g E N Ni : 𝒜) (m : ℝ)
  (hU₁ : star U * U = 1) (hU₂ : U * star U = 1)
  (hg_sa : star g = g) (hg2 : g * g = 1)
  (hH_sa : star H = H)
  (hanti : H * g + g * H = (2 * m) • (1 : 𝒜))
  (hE_sa : star E = E)
  (hE2 : E * E = U * (H * H) * star U)
  (hEA : E * Aop U H g = Aop U H g * E)
  (hN_sa : star N = N)
  (hN2 : N * N = (2 : ℝ) • (E * E) + (2 * m) • E)
  (hNi₁ : N * Ni = 1) (hNi₂ : Ni * N = 1)
  (hNE : N * E = E * N)
  (hNA : N * Aop U H g = Aop U H g * N)

include hE2 hEA hE_sa hH_sa hN2 hN_sa hNi₁ hNi₂ hU₁ hU₂ hanti hg2 hg_sa in
theorem BookProof.ChapterMajoranaProp61.prop61_mul_star_self_inc :
    Uprime U H g E Ni * star (Uprime U H g E Ni) = 1 := by sorry
