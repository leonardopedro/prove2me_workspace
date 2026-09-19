-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.sum_single_block
import Mathlib
import Definitions.Def_ChapterQgOuterFockEsa
open BookProof.QgOuterFock




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.QgHermiteOscillator
open BookProof.DirectSumEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (p : Fin n) (c : Fin 84) :
    ∑ i : Fin 84, ((if i = c then (1 : ℝ) else 0 : ℝ) : ℂ)
        • (X (pcoord p i) : MvPolynomial (Fin (n * 84)) ℂ) = X (pcoord p c) := by

  rw [Finset.sum_eq_single c]
  · simp
  · intro b _ hb
    simp [hb]
  · intro hc
    exact absurd (Finset.mem_univ c) hc
