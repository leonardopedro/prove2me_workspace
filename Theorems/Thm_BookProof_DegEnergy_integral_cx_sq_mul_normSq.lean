-- Generated from ChapterDegEnergyEstimate.lean — theorem BookProof.DegEnergy.integral_cx_sq_mul_normSq
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

theorem BookProof.DegEnergy.integral_cx_sq_mul_normSq {χ : Vd d → ℝ} (v : Vd d → ℂ) :
    ∀ x : Vd d, cx χ x ^ 2 * (starRingEnd ℂ) (v x) * v x
      = (((χ x) ^ 2 * ‖v x‖ ^ 2 : ℝ) : ℂ) := by sorry
