-- Generated from ChapterSmHiggsVacuum.lean — theorem BookProof.SmHiggsVacuum.higgsV_eq_min_iff
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Finset

noncomputable section


theorem BookProof.SmHiggsVacuum.higgsV_eq_min_iff {lam mu2 : ℝ} (hlam : 0 < lam) (phi : E) :
    higgsV lam mu2 phi = -(mu2 ^ 2 / (4 * lam)) ↔ ‖phi‖ ^ 2 = mu2 / lam := by sorry
