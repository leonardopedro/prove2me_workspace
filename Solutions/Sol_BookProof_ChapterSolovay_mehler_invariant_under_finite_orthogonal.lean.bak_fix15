-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.mehler_invariant_under_finite_orthogonal
import Mathlib
import Definitions.Def_ChapterSolovay
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution
    (T : _root_.InnerTail → _root_.InnerTail)
    (hT : IsFiniteOrthogonalTailSymmetry T) :
    Measure.map T _root_.tailMeasure = _root_.tailMeasure := by

  exact hT.map_eq
