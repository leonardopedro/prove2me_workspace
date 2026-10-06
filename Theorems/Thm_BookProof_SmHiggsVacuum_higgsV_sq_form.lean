-- Generated from ChapterSmHiggsVacuum.lean — theorem BookProof.SmHiggsVacuum.higgsV_sq_form
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Finset

noncomputable section


theorem BookProof.SmHiggsVacuum.higgsV_sq_form {lam mu2 : ℝ} (hlam : 0 < lam) (phi : E) :
    higgsV lam mu2 phi = (lam / 4) * (‖phi‖ ^ 2 - mu2 / lam) ^ 2 - mu2 ^ 2 / (4 * lam) := by sorry
