-- Generated from ChapterQgOuterFockInteractionFL.lean — theorem BookProof.QgOuterFockInteractionFL.qgCoupling_spans_two_particles
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterQgOuterFockFullFL
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterSqSumFarisLavine
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterQg3DGaugeEsa
import Definitions.Def_ChapterQgOuterFockEsa
open BookProof.Qg3DGaugeEsa
open BookProof.QgOuterFock
open BookProof.QgOuterFockInteractionFL



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockFullFL
open BookProof.Qg3DGaugeEsa BookProof.QuantumGravity3DGauge
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine

noncomputable section

variable (F : QgFamily)

theorem BookProof.QgOuterFockInteractionFL.qgCoupling_spans_two_particles (lam : ℝ) {n : ℕ} (p : Fin n)
    (hp : nextPart p ≠ p) {m : Fin 64} (hm : torsionMu m ≠ torsionNu m) :
    qgIntVec lam n (Sum.inr (p, m)) (pcoord p (torsionIdx1 m)) = lam ∧
      qgIntVec lam n (Sum.inr (p, m)) (pcoord (nextPart p) (torsionIdx1 m)) = -lam := by sorry
