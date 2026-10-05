-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.LadderOrd.comp
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {S T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {a b : ℕ}
    (hS : LadderOrd S a) (hT : LadderOrd T b) : LadderOrd (S ∘ₗ T) (a + b) := by

  intro m
  obtain ⟨C₁, hC₁, h₁⟩ := hS m
  obtain ⟨C₂, hC₂, h₂⟩ := hT (m + a)
  refine ⟨C₁ * C₂, by finiteness, fun p => ?_⟩
  rw [LinearMap.comp_apply]
  calc hn m (pgLp (S (T p))) ≤ C₁ * hn (m + a) (pgLp (T p)) := h₁ _
    _ ≤ C₁ * (C₂ * hn (m + a + b) (pgLp p)) := by gcongr; exact h₂ p
    _ = C₁ * C₂ * hn (m + (a + b)) (pgLp p) := by rw [← add_assoc, mul_assoc]
