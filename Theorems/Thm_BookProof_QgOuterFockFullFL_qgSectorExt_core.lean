-- Generated from ChapterQgOuterFockFullFL.lean — theorem BookProof.QgOuterFockFullFL.qgSectorExt_core
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterSqSumFarisLavine
import Mathlib
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
open BookProof.HermiteProductCore
open BookProof.QgOuterFock
open BookProof.QgOuterFockFL
open BookProof.QgOuterFockFullFL

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.Qg3DGaugeEsa BookProof.QuantumGravity3DGauge
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine
open Filter Topology

noncomputable section

theorem BookProof.QgOuterFockFullFL.qgSectorExt_core (n : ℕ) (p : polyGaussCore (d := n * 84))
    (h : (p : L2d (n * 84)) ∈ (harmFried (n * 84)).dom) :
    qgSectorExt n ⟨(p : L2d (n * 84)), h⟩ = qgSectorHam n p := by sorry
