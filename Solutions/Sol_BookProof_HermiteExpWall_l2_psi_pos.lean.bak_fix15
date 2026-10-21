-- Generated from ChapterHermiteExpWall.lean — solution of BookProof.HermiteExpWall.l2_psi_pos
import Mathlib
import Definitions.Def_ChapterHermiteExpWall
import Theorems.Thm_BookProof_HermiteExpWall_l2_nonneg
import Theorems.Thm_BookProof_HermiteExpWall_gaussMoment_even_pos
import Theorems.Thm_BookProof_HermiteExpWall_l2_psi_sq
open BookProof.HermiteExpWall




open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) : 0 < l2 (psi N) := by

  have h := l2_psi_sq N
  have hnn : 0 ≤ l2 (psi N) := l2_nonneg _
  nlinarith [gaussMoment_even_pos N, h]
