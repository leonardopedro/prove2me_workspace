-- Generated from ChapterSpectralEnergyBound.lean — theorem BookProof.ChapterSpectralEnergyBound.evolve_lipschitz
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterBornMeasure
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.ChapterBornMeasure
open BookProof.ChapterSpectralEnergyBound



variable {n : Type*} [Fintype n]


theorem BookProof.ChapterSpectralEnergyBound.evolve_lipschitz (f : n → ℝ) (E : ℝ) (v : EuclideanSpace ℂ n)
    (h : ∀ i, v i ≠ 0 → |f i| ≤ E) (s t : ℝ) :
    ‖evolve f t v - evolve f s v‖ ≤ E * ‖v‖ * |t - s| := by
  have hderiv : ∀ x ∈ Set.uIcc s t,
      HasDerivWithinAt (fun r : ℝ => evolve f r v)
        (-Complex.I • diagOp f (evolve f x v)) (Set.uIcc s t) x := by sorry
