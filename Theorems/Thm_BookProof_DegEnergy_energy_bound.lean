-- Generated from ChapterDegEnergyEstimate.lean — theorem BookProof.DegEnergy.energy_bound
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterConvolutionCalc
import Mathlib
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.DegEnergy



open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section

variable {d : ℕ}

variable (S : Finset (Fin d))

theorem BookProof.DegEnergy.energy_bound {z : ℂ} (hz : z.re = 0) {v G : Vd d → ℂ}
    (hv : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) v) (hG : Continuous G)
    (hid : ∀ x, lapCS S v x = G x - z * v x)
    {χ : Vd d → ℝ} (hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ) (hχc : HasCompactSupport χ) :
    (∫ x, cx χ x ^ 2 * (starRingEnd ℂ) (v x) * G x).re
      ≤ 2 * ∑ j ∈ S, ∫ x, ‖dcoord j (cx χ) x‖ ^ 2 * ‖v x‖ ^ 2 := by sorry
