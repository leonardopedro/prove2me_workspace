-- Generated from ChapterFreeFieldBornSurj.lean — solution of BookProof.ChapterFreeFieldBornSurj.bornMap_surjOn_stdSimplex
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSurj
import Theorems.Thm_BookProof_ChapterFreeFieldBornSurj_bornMap_bornSection
import Theorems.Thm_BookProof_ChapterFreeFieldBornSurj_bornSection_mem_sphere
open BookProof.ChapterFreeFieldBornSurj



open MeasureTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere
open BookProof.ChapterFreeFieldSphereSupport BookProof.ChapterFreeFieldBorn


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    Set.SurjOn (bornMap : EuclideanSpace ℝ (Fin n) → _)
      (Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) (stdSimplex ℝ (Fin n)) := by

  intro p hp
  exact ⟨bornSection p, bornSection_mem_sphere hp, bornMap_bornSection hp⟩
