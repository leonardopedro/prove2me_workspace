-- Generated from ChapterQgOuterFockInteractionFL.lean — solution of BookProof.QgOuterFockInteractionFL.qgInt_coupling_nontrivial
import Mathlib
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_nextPart_ne
import Theorems.Thm_BookProof_QgOuterFockInteractionFL_qgCoupling_spans_two_particles
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
theorem solution {lam : ℝ} (hlam : lam ≠ 0) {n : ℕ} (hn : 2 ≤ n) :
    ∃ (r : (Fin n × Fin 64) ⊕ (Fin n × Fin 64)) (I J : Fin (n * 84)),
      partOf I ≠ partOf J ∧ qgIntVec lam n r I ≠ 0 ∧ qgIntVec lam n r J ≠ 0 := by

  have hn0 : 0 < n := by omega
  set p : Fin n := ⟨0, hn0⟩ with hpdef
  have hp : nextPart p ≠ p := nextPart_ne hn p rfl
  set m : Fin 64 := ⟨16, by norm_num⟩ with hmdef
  have hm : torsionMu m ≠ torsionNu m := by decide
  obtain ⟨h1, h2⟩ := qgCoupling_spans_two_particles lam p hp hm
  refine ⟨Sum.inr (p, m), pcoord p (torsionIdx1 m),
    pcoord (nextPart p) (torsionIdx1 m), ?_, ?_, ?_⟩
  · rw [partOf_pcoord, partOf_pcoord]
    exact fun h => hp h.symm
  · rw [h1]; exact hlam
  · rw [h2]; simpa using hlam
