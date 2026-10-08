-- Generated from ChapterSpectralEnergyBound.lean — theorem BookProof.ChapterSpectralEnergyBound.hasDerivAt_evolve
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.ChapterBornMeasure
open BookProof.ChapterSpectralEnergyBound



variable {n : Type*} [Fintype n]


theorem BookProof.ChapterSpectralEnergyBound.hasDerivAt_evolve (f : n → ℝ) (v : EuclideanSpace ℂ n) (t : ℝ) :
    HasDerivAt (fun s : ℝ => evolve f s v)
      (-Complex.I • diagOp f (evolve f t v)) t := by sorry
