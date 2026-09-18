-- Generated from ChapterWallEsaSemibounded.lean — solution of BookProof.WallEsaSemibounded.wallHamBddBelow_semibounded
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Theorems.Thm_BookProof_WallEsaSemibounded_kinCcR_quadratic_form
import Theorems.Thm_BookProof_WallEsaSemibounded_opCc_quadratic_form
import Theorems.Thm_BookProof_WallEsaSemibounded_ccEquiv_norm_sq
open BookProof.WallEsaSemibounded











open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) {c : ℝ} (hVc : ∀ x, -c ≤ V x) :
    SemiboundedBelowOn (ccDomain ℝ) (wallHam V hV) c := by

  intro v
  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective v
  have hk := kinCcR_quadratic_form f
  have hp := opCc_quadratic_form V hV f
  have hn := ccEquiv_norm_sq f
  have hcf : Continuous ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) := (f : 𝓢(ℝ, ℂ)).continuous
  have hsq : Continuous fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by fun_prop
  have hsupp : HasCompactSupport fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    f.2.comp_left (g := fun z : ℂ => ‖z‖ ^ 2) (by simp)
  have hI0 : Integrable fun x => ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    hsq.integrable_of_hasCompactSupport hsupp
  have hIV : Integrable fun x => V x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    ((hV.continuous.mul hsq)).integrable_of_hasCompactSupport hsupp.mul_left
  have hIc : Integrable fun x => -c * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := hI0.const_mul _
  have hkin_nonneg : (0 : ℝ) ≤ ∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 :=
    integral_nonneg fun x => by positivity
  have hpot : (-c) * (∫ x, ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2)
      ≤ ∫ x, V x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
    rw [← integral_const_mul]
    exact integral_mono hIc hIV fun x => by
      have := hVc x
      nlinarith [sq_nonneg ‖(f : 𝓢(ℝ, ℂ)) x‖, norm_nonneg ((f : 𝓢(ℝ, ℂ)) x)]
  simp only [wallHam, LinearMap.add_apply, inner_add_left, hk, hp, hn]
  simp only [Complex.add_re, Complex.ofReal_re]
  linarith
