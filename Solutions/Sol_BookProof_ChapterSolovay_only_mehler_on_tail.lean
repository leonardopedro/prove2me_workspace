-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.only_mehler_on_tail
import Mathlib
import Definitions.Def_ChapterSolovay
import Theorems.Thm_PhysMehler_rcpPriorOnSubstrate_atomless
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution : TailPriorAdmissible _root_.tailMeasure := by

  refine ⟨?_, ?_, ?_⟩
  · exact _root_.PhysMehler.rcpPriorOnSubstrate_isProb
  · exact _root_.PhysMehler.rcpPriorOnSubstrate_atomless
  · exact fun T hT => hT.map_eq
