-- Generated from ChapterSqSumOuterFamily.lean — solution of BookProof.SqSumOuterFamily.outerFriedN_surj
import Mathlib
import Definitions.Def_ChapterSqSumOuterFamily
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterHermiteProductCore
open BookProof.SqSumOuterFamily




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine
open BookProof.HermiteProductCore

noncomputable section

variable (dim : ℕ → ℕ)

set_option maxHeartbeats 1000000 in
theorem solution (f : outerFock dim) :
    ∃ x : outerFriedDom dim, outerFriedN dim x + (x : outerFock dim) = f := (outerComparison dim).surj f
