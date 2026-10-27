-- Generated from ChapterDegEnergyEstimate.lean — solution of BookProof.DegEnergy.integrable_of_cc
import Mathlib
import Definitions.Def_ChapterDegEnergyEstimate
open BookProof.DegEnergy




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {f : Vd d → ℂ} (hf : Continuous f) (hc : HasCompactSupport f) :
    Integrable f (volume : Measure (Vd d)) := hf.integrable_of_hasCompactSupport hc
