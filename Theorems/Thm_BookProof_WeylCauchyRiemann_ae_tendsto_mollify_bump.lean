-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.ae_tendsto_mollify_bump
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.ae_tendsto_mollify_bump {F : ℂ → ℂ} (hF : LocallyIntegrable F) :
    ∀ᵐ z : ℂ, Tendsto (fun n => mollify F ((bumpSeq n).normed volume) z) atTop (nhds (F z)) := by sorry
