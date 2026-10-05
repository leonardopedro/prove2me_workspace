-- Generated from ChapterQgOuterFockInteractionFL.lean — solution of BookProof.QgOuterFockInteractionFL.qgCoupling_spans_two_particles
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_torsionVec_self
import Theorems.Thm_BookProof_QgOuterFock_modeOf_pcoord
import Theorems.Thm_BookProof_QgOuterFock_partOf_pcoord
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

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) {n : ℕ} (p : Fin n)
    (hp : nextPart p ≠ p) {m : Fin 64} (hm : torsionMu m ≠ torsionNu m) :
    qgIntVec lam n (Sum.inr (p, m)) (pcoord p (torsionIdx1 m)) = lam ∧
      qgIntVec lam n (Sum.inr (p, m)) (pcoord (nextPart p) (torsionIdx1 m)) = -lam := by

  have hone := torsionVec_self hm
  constructor
  · change lam * (qgTorsionVecN n (p, m) (pcoord p (torsionIdx1 m))
        - qgTorsionVecN n (nextPart p, m) (pcoord p (torsionIdx1 m))) = lam
    rw [qgTorsionVecN, qgTorsionVecN, partOf_pcoord, modeOf_pcoord, if_pos rfl,
      if_neg (fun h => hp h.symm), hone]
    ring
  · change lam * (qgTorsionVecN n (p, m) (pcoord (nextPart p) (torsionIdx1 m))
        - qgTorsionVecN n (nextPart p, m) (pcoord (nextPart p) (torsionIdx1 m))) = -lam
    rw [qgTorsionVecN, qgTorsionVecN, partOf_pcoord, modeOf_pcoord, if_pos rfl, if_neg hp,
      hone]
    ring
