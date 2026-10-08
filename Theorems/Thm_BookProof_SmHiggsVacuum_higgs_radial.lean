-- Generated from ChapterSmHiggsVacuum.lean — theorem BookProof.SmHiggsVacuum.higgs_radial
import Mathlib
import Definitions.Def_ChapterSmHiggsVacuum
open BookProof.SmHiggsVacuum



open Finset

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]


theorem BookProof.SmHiggsVacuum.higgs_radial {lam mu2 : ℝ} {u : E} (hu : lam * ‖u‖ ^ 2 = mu2) (t : ℝ) :
    higgsV lam mu2 ((1 + t) • u)
      = higgsV lam mu2 u + mu2 * ‖u‖ ^ 2 * t ^ 2 * (1 + t + t ^ 2 / 4) := by sorry
