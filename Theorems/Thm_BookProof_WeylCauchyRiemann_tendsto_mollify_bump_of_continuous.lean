-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.tendsto_mollify_bump_of_continuous
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.tendsto_mollify_bump_of_continuous {h : ℂ → ℂ} (hh : Continuous h) (z : ℂ) :
    Tendsto (fun n => mollify h ((bumpSeq n).normed volume) z) atTop (nhds (h z)) := by sorry
