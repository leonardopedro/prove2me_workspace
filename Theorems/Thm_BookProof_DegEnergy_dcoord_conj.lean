-- Generated from ChapterDegEnergyEstimate.lean — theorem BookProof.DegEnergy.dcoord_conj
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


theorem BookProof.DegEnergy.dcoord_conj {v : Vd d → ℂ} (hv : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) v) (j : Fin d)
    (x : Vd d) :
    dcoord j (fun y => (starRingEnd ℂ) (v y)) x = (starRingEnd ℂ) (dcoord j v x) := by sorry
