-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.number_le_dGamma_quadForm
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockNumberPreservingGap_dGamma_shiftCol
import Theorems.Thm_BookProof_FockSecondQuantization_inner_dGamma_nonneg
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ}
    (hgap : IsPosCol (shiftCol col mu)) (u : FockAlg) :
    mu * numberQuad u ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by

  have hsplit : (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ)
      = inner ℂ (toLp u) (toLp (dGamma (shiftCol col mu) u))
        + ((mu : ℝ) : ℂ) * inner ℂ (toLp u) (toLp (dGamma numberCol u)) := by
    have hcol : dGamma col u
        = dGamma (shiftCol col mu) u + ((mu : ℝ) : ℂ) • dGamma numberCol u := by
      rw [dGamma_shiftCol, sub_add_cancel]
    have hadd : ∀ a b : FockAlg, toLp (a + b) = toLp a + toLp b := fun a b =>
      map_add toLpL a b
    have hsmul : ∀ (c : ℂ) (a : FockAlg), toLp (c • a) = c • toLp a := fun c a =>
      map_smul toLpL c a
    rw [hcol, hadd, hsmul, inner_add_right, inner_smul_right]
  rw [hsplit, Complex.add_re, Complex.re_ofReal_mul]
  have h1 : 0 ≤ (inner ℂ (toLp u) (toLp (dGamma (shiftCol col mu) u)) : ℂ).re :=
    inner_dGamma_nonneg hgap u
  have h2 : numberQuad u = (inner ℂ (toLp u) (toLp (dGamma numberCol u)) : ℂ).re := rfl
  rw [h2]
  linarith
