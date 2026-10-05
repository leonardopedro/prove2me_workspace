-- Generated from ChapterFreeFieldBorn.lean — solution of BookProof.ChapterFreeFieldBorn.bornMap_nonneg
import Mathlib
import Definitions.Def_ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBorn



open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : EuclideanSpace ℝ (Fin n)) (k : Fin n) : 0 ≤ bornMap x k := by

  unfold bornMap; positivity
