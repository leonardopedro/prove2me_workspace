-- Generated from ChapterConvolutionCalc.lean — theorem BookProof.ConvolutionCalc.hasCompactSupport_dcoord
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.ConvolutionCalc

variable {d : ℕ}



open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section


theorem BookProof.ConvolutionCalc.hasCompactSupport_dcoord {ρ : Vd d → ℂ}
    (hc : HasCompactSupport ρ) (j : Fin d) : HasCompactSupport (dcoord j ρ) := by sorry
