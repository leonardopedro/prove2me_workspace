-- Generated from ChapterFreeFieldBorn.lean — solution of BookProof.ChapterFreeFieldBorn.measurable_bornMap
import Mathlib
import Definitions.Def_ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBorn



open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : Measurable (bornMap : EuclideanSpace ℝ (Fin n) → _) := by

  unfold bornMap; fun_prop
