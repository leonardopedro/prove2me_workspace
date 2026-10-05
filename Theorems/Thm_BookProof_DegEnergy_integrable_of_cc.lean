-- Generated from ChapterDegEnergyEstimate.lean — theorem BookProof.DegEnergy.integrable_of_cc
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


theorem BookProof.DegEnergy.integrable_of_cc {f : Vd d → ℂ} (hf : Continuous f) (hc : HasCompactSupport f) :
    Integrable f (volume : Measure (Vd d)) := by sorry
