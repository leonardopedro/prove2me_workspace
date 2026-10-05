-- Generated from ChapterConvolutionCalc.lean — solution of BookProof.ConvolutionCalc.cnv_apply
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
open BookProof.ConvolutionCalc




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (u ρ : Vd d → ℂ) (x : Vd d) : cnv u ρ x = ∫ y, u y * ρ (x - y) := rfl
