-- Generated from ChapterWallEsaSemibounded.lean — solution of BookProof.WallEsaSemibounded.opCc_quadratic_form
import Mathlib
import Definitions.Def_ChapterWallEsaSemibounded
import Theorems.Thm_BookProof_StrichartzWave_inner_toLp_left
open BookProof.WallEsaSemibounded











open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa BookProof.WallEsaBddBelow

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    (f : ccSchwartz ℝ) :
    (inner ℂ (opCc V hV (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, V x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by

  rw [opCc_apply, ccEquiv_coe, inner_toLp_left, ← integral_complex_ofReal]
  refine integral_congr_ae ?_
  filter_upwards [(f : 𝓢(ℝ, ℂ)).coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx]
  simp only [mulCc_apply, map_mul, Complex.conj_ofReal, Complex.ofReal_mul]
  rw [mul_assoc, Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]
