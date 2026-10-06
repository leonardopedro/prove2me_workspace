-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.dbar_ofReal_comp_sub
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.dbar_ofReal_comp_sub {χ : ℂ → ℝ} (hχ : ContDiff ℝ ∞ χ) (z w : ℂ) :
    dbar (fun v => ((χ (z - v) : ℝ) : ℂ)) w = -dbarR χ (z - w) := by sorry
