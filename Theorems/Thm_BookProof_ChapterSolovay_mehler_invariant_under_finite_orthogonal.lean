-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.mehler_invariant_under_finite_orthogonal
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.mehler_invariant_under_finite_orthogonal
    (T : _root_.InnerTail → _root_.InnerTail)
    (hT : IsFiniteOrthogonalTailSymmetry T) :
    Measure.map T _root_.tailMeasure = _root_.tailMeasure := by sorry
