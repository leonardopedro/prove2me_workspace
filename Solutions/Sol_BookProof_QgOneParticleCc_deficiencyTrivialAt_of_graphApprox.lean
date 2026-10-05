-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.deficiencyTrivialAt_of_graphApprox
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D₁ D₂ : Submodule ℂ F}
    (T₁ : D₁ →ₗ[ℂ] F) (T₂ : D₂ →ₗ[ℂ] F) {z : ℂ}
    (happrox : ∀ (x : D₁) (ε : ℝ), 0 < ε →
      ∃ y : D₂, ‖(y : F) - (x : F)‖ < ε ∧ ‖T₂ y - T₁ x‖ < ε)
    (h₁ : DeficiencyTrivialAt D₁ T₁ z) :
    DeficiencyTrivialAt D₂ T₂ z := by

  intro w hw
  refine h₁ w fun x => ?_
  have hzero : ∀ ε : ℝ, 0 < ε →
      ‖(inner ℂ (T₁ x) w : ℂ) - z * inner ℂ (x : F) w‖ ≤ ε * (1 + ‖z‖) * ‖w‖ := by
    intro ε hε
    obtain ⟨y, hy1, hy2⟩ := happrox x ε hε
    have hwy := hw y
    have hsplit : (inner ℂ (T₁ x) w : ℂ) - z * inner ℂ (x : F) w
        = (inner ℂ (T₁ x - T₂ y) w : ℂ) + z * inner ℂ ((y : F) - (x : F)) w := by
      rw [inner_sub_left, inner_sub_left, hwy]
      ring
    calc ‖(inner ℂ (T₁ x) w : ℂ) - z * inner ℂ (x : F) w‖
        ≤ ‖(inner ℂ (T₁ x - T₂ y) w : ℂ)‖ + ‖z * (inner ℂ ((y : F) - (x : F)) w : ℂ)‖ := by
          rw [hsplit]; exact norm_add_le _ _
      _ ≤ ‖T₁ x - T₂ y‖ * ‖w‖ + ‖z‖ * (‖(y : F) - (x : F)‖ * ‖w‖) := by
          gcongr
          · exact norm_inner_le_norm _ _
          · rw [norm_mul]
            gcongr
            exact norm_inner_le_norm _ _
      _ ≤ ε * (1 + ‖z‖) * ‖w‖ := by
          have h1 : ‖T₁ x - T₂ y‖ ≤ ε := by
            rw [← norm_neg]; simpa [neg_sub] using hy2.le
          have hA : ‖T₁ x - T₂ y‖ * ‖w‖ ≤ ε * ‖w‖ :=
            mul_le_mul_of_nonneg_right h1 (norm_nonneg w)
          have hB : ‖z‖ * (‖(y : F) - (x : F)‖ * ‖w‖) ≤ ‖z‖ * (ε * ‖w‖) :=
            mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_right hy1.le (norm_nonneg w))
              (norm_nonneg z)
          nlinarith [norm_nonneg w, norm_nonneg z]
  have hnn : ‖(inner ℂ (T₁ x) w : ℂ) - z * inner ℂ (x : F) w‖ ≤ 0 := by
    refine le_of_forall_pos_le_add fun δ hδ => ?_
    have hpos : 0 < δ / ((1 + ‖z‖) * (1 + ‖w‖)) := by positivity
    have hb := hzero _ hpos
    have hbound : δ / ((1 + ‖z‖) * (1 + ‖w‖)) * (1 + ‖z‖) * ‖w‖ ≤ δ := by
      rw [div_mul_eq_mul_div, div_mul_eq_mul_div, div_le_iff₀ (by positivity)]
      nlinarith [norm_nonneg w, norm_nonneg z, hδ.le]
    linarith
  exact sub_eq_zero.mp (norm_le_zero_iff.mp hnn)
