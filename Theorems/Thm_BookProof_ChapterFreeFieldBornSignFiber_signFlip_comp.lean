-- Generated from ChapterFreeFieldBornSignFiber.lean — theorem BookProof.ChapterFreeFieldBornSignFiber.signFlip_comp
import Definitions.Def_ChapterFreeFieldBorn
import Definitions.Def_ChapterFreeFieldBornSignGauge
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignFiber
open BookProof.ChapterFreeFieldBornSignFiber

variable {n : ℕ}


open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSignGauge



theorem BookProof.ChapterFreeFieldBornSignFiber.signFlip_comp (s t : Fin n → ℝ) (x : EuclideanSpace ℝ (Fin n)) :
    signFlip s (signFlip t x) = signFlip (fun k => s k * t k) x := by sorry
