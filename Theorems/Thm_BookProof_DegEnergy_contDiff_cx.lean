-- Generated from ChapterDegEnergyEstimate.lean — theorem BookProof.DegEnergy.contDiff_cx
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


theorem BookProof.DegEnergy.contDiff_cx {χ : Vd d → ℝ} (hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cx χ) := by sorry
