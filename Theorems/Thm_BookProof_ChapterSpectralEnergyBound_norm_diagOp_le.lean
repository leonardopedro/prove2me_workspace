-- Generated from ChapterSpectralEnergyBound.lean — theorem BookProof.ChapterSpectralEnergyBound.norm_diagOp_le
import Mathlib
import Definitions.Def_ChapterSpectralEnergyBound
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable
open BookProof.ChapterSpectralEnergyBound



variable {n : Type*} [Fintype n]


theorem BookProof.ChapterSpectralEnergyBound.norm_diagOp_le (f : n → ℝ) (E : ℝ) (v : EuclideanSpace ℂ n)
    (h : ∀ i, v i ≠ 0 → |f i| ≤ E) :
    ‖diagOp f v‖ ≤ E * ‖v‖ := by sorry
