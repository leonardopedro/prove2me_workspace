-- Generated from ChapterDegEnergyEstimate.lean — theorem BookProof.DegEnergy.integral_dcoord_mul
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterConvolutionCalc
import Mathlib
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.DegEnergy

variable {d : ℕ}



open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section


theorem BookProof.DegEnergy.integral_dcoord_mul {f g : Vd d → ℂ} (hf : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) f)
    (hfc : HasCompactSupport f) (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g) (j : Fin d) :
    ∫ x, f x * dcoord j g x = -∫ x, dcoord j f x * g x := by sorry
