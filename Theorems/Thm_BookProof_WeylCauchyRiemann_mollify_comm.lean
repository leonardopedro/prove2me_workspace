-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.mollify_comm
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.mollify_comm {F : ℂ → ℂ} (hF : Integrable F) {χ₁ χ₂ : ℂ → ℝ}
    (hχ₁ : Continuous χ₁) (hχ₁c : HasCompactSupport χ₁)
    (hχ₂ : Continuous χ₂) (hχ₂c : HasCompactSupport χ₂) :
    mollify (mollify F χ₁) χ₂ = mollify (mollify F χ₂) χ₁ := by sorry
