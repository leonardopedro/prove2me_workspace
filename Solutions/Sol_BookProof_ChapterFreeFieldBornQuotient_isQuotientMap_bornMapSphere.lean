-- Generated from ChapterFreeFieldBornQuotient.lean — solution of BookProof.ChapterFreeFieldBornQuotient.isQuotientMap_bornMapSphere
import Mathlib
import Definitions.Def_ChapterFreeFieldBornQuotient
import Theorems.Thm_BookProof_ChapterFreeFieldBornQuotient_continuous_bornMapSphere
import Theorems.Thm_BookProof_ChapterFreeFieldBornQuotient_surjective_bornMapSphere
open BookProof.ChapterFreeFieldBornQuotient



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    Topology.IsQuotientMap (bornMapSphere n) := by

  haveI : CompactSpace ↥(Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1) :=
    isCompact_iff_compactSpace.mp (isCompact_sphere _ _)
  exact (continuous_bornMapSphere.isClosedMap).isQuotientMap
    continuous_bornMapSphere surjective_bornMapSphere
