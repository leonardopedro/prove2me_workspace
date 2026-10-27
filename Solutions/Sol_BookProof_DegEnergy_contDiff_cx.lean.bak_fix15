-- Generated from ChapterDegEnergyEstimate.lean — solution of BookProof.DegEnergy.contDiff_cx
import Mathlib
import Definitions.Def_ChapterDegEnergyEstimate
open BookProof.DegEnergy




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable (S : Finset (Fin d))

set_option maxHeartbeats 1000000 in
theorem solution {χ : Vd d → ℝ} (hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cx χ) := Complex.ofRealCLM.contDiff.comp hχ
