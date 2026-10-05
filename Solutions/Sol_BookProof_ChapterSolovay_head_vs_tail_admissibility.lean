-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.head_vs_tail_admissibility
import Mathlib
import Definitions.Def_ChapterSolovay
import Theorems.Thm_BookProof_ChapterSolovay_stateMeasure_isProbability
import Theorems.Thm_BookProof_ChapterSolovay_only_mehler_on_tail
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ)
    (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] :
    IsProbabilityMeasure (_root_.stateMeasure N headDist) ∧
      TailPriorAdmissible _root_.tailMeasure := by

  exact ⟨stateMeasure_isProbability N headDist, only_mehler_on_tail⟩
