-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.dbar_eq_zero_of_notMem_tsupport
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.dbar_eq_zero_of_notMem_tsupport {φ : ℂ → ℂ} {z : ℂ} (hz : z ∉ tsupport φ) :
    dbar φ z = 0 := by sorry
