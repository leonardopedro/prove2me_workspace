-- Generated from ChapterTempleSeparationNecessary.lean — theorem BookProof.TempleSeparationNecessary.witness_apply
import Definitions.Def_ChapterRitzCertificate
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow.FarisLavineLift
open BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData
open BookProof.TempleSeparationNecessary


noncomputable section


open BookProof.RitzCertificate

theorem BookProof.TempleSeparationNecessary.witness_apply (M : ℝ) (x y : E2) :
    witness M x y = ((-M : ℝ) : ℂ) • (y - (inner ℂ x y : ℂ) • x) := by sorry
