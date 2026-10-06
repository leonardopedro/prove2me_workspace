-- Generated from ChapterSmHiggsVacuum.lean — theorem BookProof.SmHiggsVacuum.higgs_goldstone
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]



open Finset

noncomputable section


theorem BookProof.SmHiggsVacuum.higgs_goldstone {lam mu2 : ℝ} {u w : E} (hu : lam * ‖u‖ ^ 2 = mu2)
    (hperp : (inner ℝ u w : ℝ) = 0) (t : ℝ) :
    higgsV lam mu2 (u + t • w) = higgsV lam mu2 u + (lam / 4) * t ^ 4 * ‖w‖ ^ 4 := by sorry
