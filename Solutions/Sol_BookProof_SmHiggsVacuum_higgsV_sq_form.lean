-- Generated from ChapterSmHiggsVacuum.lean — solution of BookProof.SmHiggsVacuum.higgsV_sq_form
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum




open Finset

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {lam mu2 : ℝ} (hlam : 0 < lam) (phi : E) :
    higgsV lam mu2 phi = (lam / 4) * (‖phi‖ ^ 2 - mu2 / lam) ^ 2 - mu2 ^ 2 / (4 * lam) := by

  have hne : lam ≠ 0 := ne_of_gt hlam
  rw [higgsV]
  field_simp
  ring
