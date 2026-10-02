-- Generated from ChapterSqSumFarisLavine.lean — theorem BookProof.SqSumFarisLavine.schur_bound
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterGaussCoreQuadBounds
import Mathlib
import Definitions.Def_ChapterSqSumFarisLavine
open BookProof.SqSumFarisLavine

variable {D : ℕ} {R : Type*} [Fintype R]



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock
open BookProof.GaussCoreQuadBounds

noncomputable section


theorem BookProof.SqSumFarisLavine.schur_bound {I J : Type*} [Fintype I] [Fintype J] (A : I → J → ℝ) {a b : ℝ}
    (ha0 : 0 ≤ a)
    (ha : ∀ i, ∑ j : J, |A i j| ≤ a) (hb : ∀ j, ∑ i : I, |A i j| ≤ b) (y : J → ℝ) :
    ∑ i : I, (∑ j : J, A i j * y j) ^ 2 ≤ a * b * ∑ j : J, (y j) ^ 2 := by sorry
