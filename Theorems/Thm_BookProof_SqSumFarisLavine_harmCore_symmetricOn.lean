-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.harmCore_symmetricOn
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgHermiteOscillatorEsa
open BookProof.SqSumFarisLavine












open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine
open BookProof.GaussCoreQuadBounds

noncomputable section

variable {D : ℕ} {R : Type*} [Fintype R]

theorem BookProof.SqSumFarisLavine.harmCore_symmetricOn : SymmetricOn (polyGaussCore (d := D)) (harmCore (d := D)) := by sorry
