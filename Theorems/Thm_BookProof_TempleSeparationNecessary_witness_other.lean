-- Generated from ChapterTempleSeparationNecessary.lean — theorem BookProof.TempleSeparationNecessary.witness_other
import Definitions.Def_ChapterRitzCertificate
import Mathlib
import Definitions.Def_ChapterTempleSeparationNecessary
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow.FarisLavineLift
open BookProof.NavierStokesFlow.FarisLavineLift.ComparisonData
open BookProof.TempleSeparationNecessary


noncomputable section


open BookProof.RitzCertificate

theorem BookProof.TempleSeparationNecessary.witness_other (M : ℝ) : witness M trial other = ((-M : ℝ) : ℂ) • other := by sorry
