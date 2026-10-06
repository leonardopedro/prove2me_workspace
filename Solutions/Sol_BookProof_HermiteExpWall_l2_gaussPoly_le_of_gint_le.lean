-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.l2_gaussPoly_le_of_gint_le
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_l2_nonneg
import Theorems.Thm_BookProof_HermiteExpWall_l2_psi_sq
import Theorems.Thm_BookProof_HermiteExpWall_l2_gaussPoly_sq
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {q : Polynomial ℝ} {K : ℝ} (hK : 0 ≤ K) (N : ℕ)
    (h : gint (q * q) ≤ K ^ 2 * gaussMoment (2 * N)) :
    l2 (gaussPoly q) ≤ K * l2 (psi N) :=
    have h1 : l2 (gaussPoly q) ^ 2 ≤ (K * l2 (psi N)) ^ 2 := by
      rw [l2_gaussPoly_sq, mul_pow, l2_psi_sq]; exact h
    have h2 : 0 ≤ l2 (gaussPoly q) := l2_nonneg _
    have h3 : 0 ≤ K * l2 (psi N) := mul_nonneg hK (l2_nonneg _)
    nlinarith
  
  theo
