-- Generated from ChapterDegEnergyEstimate.lean — theorem BookProof.DegEnergy.dcoord_cx_sq
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


theorem BookProof.DegEnergy.dcoord_cx_sq {χ : Vd d → ℝ} (hχ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) χ) (j : Fin d)
    (x : Vd d) : dcoord j (fun y => cx χ y ^ 2) x = 2 * cx χ x * dcoord j (cx χ) x := by sorry
