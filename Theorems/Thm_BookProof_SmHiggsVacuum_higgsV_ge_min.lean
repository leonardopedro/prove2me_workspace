-- Generated from ChapterSmHiggsVacuum.lean — theorem BookProof.SmHiggsVacuum.higgsV_ge_min
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Finset

noncomputable section


theorem BookProof.SmHiggsVacuum.higgsV_ge_min {lam mu2 : ℝ} (hlam : 0 < lam) (phi : E) :
    -(mu2 ^ 2 / (4 * lam)) ≤ higgsV lam mu2 phi := by sorry
