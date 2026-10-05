-- Generated from ChapterDegEnergyEstimate.lean — theorem BookProof.DegEnergy.lapCS_cx_conj
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterConvolutionCalc
import Mathlib
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.DegEnergy

variable {d : ℕ}
variable (S : Finset (Fin d))



open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section


theorem BookProof.DegEnergy.lapCS_cx_conj {χ : Vd d → ℝ} (hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ)
    (S : Finset (Fin d)) (y : Vd d) :
    (starRingEnd ℂ) (lapCS S (cx χ) y) = lapCS S (cx χ) y := by sorry
