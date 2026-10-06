-- Generated from ChapterTempleSeparationNecessary.lean — theorem BookProof.TempleSeparationNecessary.separation_necessary
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
import Definitions.Def_ChapterNavierStokesFarisLavineLift
import Definitions.Def_ChapterRitzCertificate
open BookProof.NavierStokesFlow.FarisLavineLift
open BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData
open BookProof.RitzCertificate
open BookProof.TempleSeparationNecessary


noncomputable section


open BookProof.RitzCertificate

theorem BookProof.TempleSeparationNecessary.separation_necessary (M : ℝ) :
    ∃ (A : E2 →L[ℂ] E2) (x : E2), IsSelfAdjoint A ∧ ‖x‖ = 1 ∧
      rayleigh A x = 0 ∧ resid A x = 0 ∧ sInf (spectrum ℝ A) ≤ -M := by sorry
