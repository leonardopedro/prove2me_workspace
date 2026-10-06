-- Generated from ChapterSpectralEnergyBound.lean — theorem BookProof.ChapterSpectralEnergyBound.norm_evolve_apply
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure
open BookProof.ChapterSpectralEnergyBound

variable {n : Type*} [Fintype n]




theorem BookProof.ChapterSpectralEnergyBound.norm_evolve_apply (f : n → ℝ) (t : ℝ) (v : EuclideanSpace ℂ n) (i : n) :
    ‖evolve f t v i‖ = ‖v i‖ := by sorry
