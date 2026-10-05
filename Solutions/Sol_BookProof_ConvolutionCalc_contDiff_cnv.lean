-- Generated from ChapterConvolutionCalc.lean — solution of BookProof.ConvolutionCalc.contDiff_cnv
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
open BookProof.ConvolutionCalc




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {u ρ : Vd d → ℂ} (hu : LocallyIntegrable u (volume : Measure (Vd d)))
    (hρ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) ρ) (hc : HasCompactSupport ρ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cnv u ρ) := hc.contDiff_convolution_right _ hu hρ
