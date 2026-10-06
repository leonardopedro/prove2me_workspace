-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.bumpSeq_support
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    Function.support ((bumpSeq n).normed volume) ⊆ ball (0 : ℂ) ((bumpSeq n).rOut) := (bumpSeq n).support_normed_eq.subset
