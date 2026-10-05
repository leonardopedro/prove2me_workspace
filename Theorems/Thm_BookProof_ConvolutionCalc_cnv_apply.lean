-- Generated from ChapterConvolutionCalc.lean — theorem BookProof.ConvolutionCalc.cnv_apply
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


theorem BookProof.ConvolutionCalc.cnv_apply (u ρ : Vd d → ℂ) (x : Vd d) : cnv u ρ x = ∫ y, u y * ρ (x - y) := by sorry
