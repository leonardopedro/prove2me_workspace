-- Generated from ChapterSpectralEnergyBound.lean — theorem BookProof.ChapterSpectralEnergyBound.evolve_support
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterBornMeasure
open BookProof.ChapterSpectralEnergyBound



variable {n : Type*} [Fintype n]


theorem BookProof.ChapterSpectralEnergyBound.evolve_support (f : n → ℝ) (t : ℝ) (v : EuclideanSpace ℂ n) (i : n)
    (h : evolve f t v i ≠ 0) : v i ≠ 0 := by sorry
