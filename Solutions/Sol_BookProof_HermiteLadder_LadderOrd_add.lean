-- Generated from ChapterHermiteLadderOrder.lean — solution of BookProof.HermiteLadder.LadderOrd.add
import Mathlib
import Definitions.Def_ChapterHermiteLadderOrder
import Theorems.Thm_BookProof_HermiteLadder_hn_add_le
import Theorems.Thm_BookProof_HermiteLadder_pgLp_add'
open BookProof.HermiteLadder




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.DegSchrodinger
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {S T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ} {n : ℕ}
    (hS : LadderOrd S n) (hT : LadderOrd T n) : LadderOrd (S + T) n := by

  intro m
  obtain ⟨C₁, hC₁, h₁⟩ := hS m
  obtain ⟨C₂, hC₂, h₂⟩ := hT m
  refine ⟨2 * C₁ + 2 * C₂, by finiteness, fun p => ?_⟩
  rw [LinearMap.add_apply, pgLp_add']
  calc hn m (pgLp (S p) + pgLp (T p)) ≤ 2 * hn m (pgLp (S p)) + 2 * hn m (pgLp (T p)) :=
        hn_add_le _ _ _
    _ ≤ 2 * (C₁ * hn (m + n) (pgLp p)) + 2 * (C₂ * hn (m + n) (pgLp p)) := by
        gcongr
        · exact h₁ p
        · exact h₂ p
    _ = (2 * C₁ + 2 * C₂) * hn (m + n) (pgLp p) := by ring
